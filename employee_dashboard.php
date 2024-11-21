<?php
session_start();
include 'db_connection.php';

// Ensure the user is logged in
if (!isset($_SESSION['emp_no'])) {
    header("Location: employee_login.php");
    exit;
}

$emp_no = $_SESSION['emp_no'];

// Fetch the employee's data
$sql = "SELECT e.emp_no, e.first_name, e.last_name, d.dept_name, t.title, s.salary
        FROM employees e
        LEFT JOIN titles t ON e.emp_no = t.emp_no
        LEFT JOIN salaries s ON e.emp_no = s.emp_no
        LEFT JOIN departments d ON t.dept_no = d.dept_no
        WHERE e.emp_no = ? AND t.to_date = '9999-01-01'"; // Only show current title

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $emp_no);
$stmt->execute();
$result = $stmt->get_result();

$employee = $result->fetch_assoc();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Employee Dashboard</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Welcome, <?php echo htmlspecialchars($_SESSION['first_name']); ?>!</h1>
    <h2>Your Information</h2>
    <table border="1">
        <tr>
            <td>Employee Number:</td>
            <td><?php echo htmlspecialchars($employee['emp_no']); ?></td>
        </tr>
        <tr>
            <td>First Name:</td>
            <td><?php echo htmlspecialchars($employee['first_name']); ?></td>
        </tr>
        <tr>
            <td>Last Name:</td>
            <td><?php echo htmlspecialchars($employee['last_name']); ?></td>
        </tr>
        <tr>
            <td>Department:</td>
            <td><?php echo htmlspecialchars($employee['dept_name']); ?></td>
        </tr>
        <tr>
            <td>Title:</td>
            <td><?php echo htmlspecialchars($employee['title']); ?></td>
        </tr>
        <tr>
            <td>Salary:</td>
            <td><?php echo "$" . number_format($employee['salary'], 2); ?></td>
        </tr>
    </table>
    <br>
    <a href="logout.php">Logout</a>
</body>
</html>
