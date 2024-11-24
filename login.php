<?php
session_start();
include 'db_connection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username']; // Employee number
    $password = $_POST['password']; // Manager's password

    // Default password for first-time login
    $defaultPassword = 'default123'; // You can set this to any default password

    // Query to check if the manager exists in the system
    $sql = "SELECT emp_no, role, password FROM deptmanagers 
            WHERE emp_no = ? AND from_date <= CURDATE() AND to_date >= CURDATE()";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $username);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $manager = $result->fetch_assoc();

        // Check if the password matches the default password
        if ($password === $defaultPassword) {
            // Redirect to set password page if the default password is used
            $_SESSION['manager'] = $manager['emp_no'];
            header("Location: set_password.php");
            exit;
        }

        // Verify password if it's not the default password
        if (password_verify($password, $manager['password'])) {
            $_SESSION['manager'] = $manager['emp_no'];
            $_SESSION['role'] = 'admin'; // Grant admin privileges
            header("Location: dashboard.php");
            exit;
        } else {
            $error = "Invalid password.";
        }
    } else {
        $error = "Invalid login credentials.";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Manager Login</h1>
    <form method="POST">
        <label for="username">Employee Number:</label>
        <input type="text" name="username" id="username" required>
        <br>
        <label for="password">Password:</label>
        <input type="password" name="password" id="password" required>
        <br>
        <button type="submit">Login</button>
    </form>

    <?php if (isset($error)) echo "<p style='color:red;'>$error</p>"; ?>
</body>
</html>
