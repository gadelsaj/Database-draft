<?php
session_start();
include 'db_connection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $emp_no = $_POST['emp_no']; // Employee number
    $password = $_POST['password']; // Manager's password
    $role = $_POST['role']; // Role (e.g., manager or admin)

    // Hash the password
    $hashedPassword = password_hash($password, PASSWORD_BCRYPT);

    // Insert new manager into the database
    $sql = "INSERT INTO deptmanagers (emp_no, password, role, from_date, to_date) 
            VALUES (?, ?, ?, CURDATE(), '9999-01-01')";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("iss", $emp_no, $hashedPassword, $role);
    
    if ($stmt->execute()) {
        $message = "Manager added successfully.";
    } else {
        $message = "Error: " . $stmt->error;
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Add Manager</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Add New Manager</h1>
    <form method="POST">
        <label for="emp_no">Employee Number:</label>
        <input type="text" name="emp_no" id="emp_no" required>
        <br>
        <label for="password">Password:</label>
        <input type="password" name="password" id="password" required>
        <br>
        <label for="role">Role:</label>
        <select name="role" id="role">
            <option value="manager">Manager</option>
            <option value="admin">Admin</option>
        </select>
        <br>
        <button type="submit">Add Manager</button>
    </form>

    <?php if (isset($message)) echo "<p style='color:green;'>$message</p>"; ?>
</body>
</html>
