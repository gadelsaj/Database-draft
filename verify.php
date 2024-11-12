<?php
session_start();
include 'db_connection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'];
    $phone = $_POST['phone'];

    $sql = "SELECT emp_no FROM employees WHERE email = ? AND phone = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ss", $email, $phone);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $_SESSION['verified'] = true;
        header("Location: login.php");
        exit;
    } else {
        $error = "Invalid email or phone number.";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Verify Employee</title>
</head>
<body>
    <h1>Verify Employee</h1>
    <form method="POST">
        <label>Email:</label>
        <input type="email" name="email" required>
        <br>
        <label>Phone:</label>
        <input type="text" name="phone" required>
        <br>
        <button type="submit">Verify</button>
    </form>
    <?php if (isset($error)) echo "<p style='color:red;'>$error</p>"; ?>
</body>
</html>
