<?php
session_start();
include 'db_connection.php';

// Check if the manager is logged in
if (!isset($_SESSION['manager'])) {
    header("Location: login.php"); // Redirect to login if not logged in
    exit;
}

$emp_no = $_SESSION['manager']; // Manager's employee number

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $password = $_POST['password']; // Manager's password

    // Hash the password
    $hashedPassword = password_hash($password, PASSWORD_BCRYPT);

    // Update the password in the database
    $sql = "UPDATE deptmanagers SET password = ? WHERE emp_no = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("si", $hashedPassword, $emp_no);

    if ($stmt->execute()) {
        $message = "Password has been set successfully. You can now log in with your password.";
        // Optionally, log the user in immediately after setting the password
        $_SESSION['role'] = 'admin'; // Set role as admin after password is set
        header("Location: dashboard.php"); // Redirect to dashboard after setting the password
        exit;
    } else {
        $error = "Error: " . $stmt->error;
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Set Password</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Set Your Password</h1>
    <form method="POST">
        <label for="password">Password:</label>
        <input type="password" name="password" id="password" required>
        <br>
        <button type="submit">Set Password</button>
    </form>

    <?php if (isset($message)) echo "<p style='color:green;'>$message</p>"; ?>
    <?php if (isset($error)) echo "<p style='color:red;'>$error</p>"; ?>
</body>
</html>
