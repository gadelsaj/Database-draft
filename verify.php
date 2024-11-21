<?php
session_start();
include 'db_connection.php';

// Generate a unique token for this session
if (!isset($_SESSION['form_token'])) {
    $_SESSION['form_token'] = bin2hex(random_bytes(32));
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Check the token
    if (!isset($_POST['form_token']) || $_POST['form_token'] !== $_SESSION['form_token']) {
        die("Invalid form submission.");
    }

    // Clear the token to prevent reuse
    unset($_SESSION['form_token']);

    $email = $_POST['email'];
    $phone = $_POST['phone'];

    $sql = "SELECT emp_no FROM employees WHERE email = ? AND phone = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ss", $email, $phone);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $_SESSION['verified'] = true;
        header("Location: employee_list.php"); // Redirect after successful verification
        exit;
    } else {
        $error = "Invalid email or phone number."; // Set an error message
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Verify Manager</title>
    <style>
        /* Styling for the form */
        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            background-color: #f4f4f9;
            margin: 0;
        }

        h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        form {
            background: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 300px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 8px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            background-color: #3e3e3e; /* Dark, muted gray */
            color: white;
            border: 2px solid #4a4a4a;
            padding: 10px 20px;
            font-size: 1em;
            cursor: pointer;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: background-color 0.3s, border-color 0.3s ease;
        }

        button:hover {
            background-color: #c5a300; /* Goldish yellow on hover */
            border-color: #c5a300;
        }

        button:focus {
            outline: none;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.5);
        }

        p {
            color: red;
            font-weight: bold;
            text-align: center;
        }
    </style>
</head>
<body>
    <h1>Verify Manager</h1>
    <form method="POST">
        <input type="hidden" name="form_token" value="<?php echo htmlspecialchars($_SESSION['form_token']); ?>">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
        <label for="phone">Phone:</label>
        <input type="text" id="phone" name="phone" required>
        <button type="submit">Verify</button>
    </form>
    <?php if (isset($error)) echo "<p>$error</p>"; ?>
</body>
</html>
