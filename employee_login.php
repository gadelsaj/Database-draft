<?php
session_start();
include 'db_connection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $emp_no = $_POST['emp_no']; // Employee number

    // Query to verify the employee exists
    $sql = "SELECT emp_no, first_name, last_name FROM employees WHERE emp_no = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $emp_no);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $employee = $result->fetch_assoc();
        $_SESSION['emp_no'] = $employee['emp_no']; // Store employee number in session
        $_SESSION['first_name'] = $employee['first_name']; // Store employee's first name
        $_SESSION['last_name'] = $employee['last_name']; // Store employee's last name
        header("Location: employee_dashboard.php"); // Redirect to the employee's dashboard
        exit;
    } else {
        $error = "Invalid employee number.";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Employee Login</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Employee Login</h1>
    <form method="POST">
        <label for="emp_no">Employee Number:</label>
        <input type="text" name="emp_no" id="emp_no" required>
        <br>
        <button type="submit">Login</button>
    </form>
    <?php if (isset($error)) echo "<p style='color:red;'>$error</p>"; ?>
</body>
</html>
