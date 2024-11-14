<?php
session_start();
include 'db_connection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username']; // Employee number

    $sql = "SELECT emp_no, role FROM deptmanagers WHERE emp_no=? AND from_date<=CURDATE() AND to_date>=CURDATE()";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $username);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $manager = $result->fetch_assoc();
        $_SESSION['manager'] = $manager['emp_no'];
        $_SESSION['role'] = $manager['role']; // Set manager's role (e.g., admin or manager)
        header("Location: verify.php");
        exit;
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
        <button type="submit">Login</button>
    </form>
    <?php if (isset($error)) echo "<p style='color:red;'>$error</p>"; ?>
</body>
</html>
