<?php
session_start();
include 'db_connection.php';

if (!isset($_SESSION['manager']) || $_SESSION['role'] !== 'admin') {
    die("Unauthorized access.");
}

if (isset($_GET['emp_no'])) {
    $emp_no = $_GET['emp_no'];

    // Delete related records
    $conn->query("DELETE FROM titles WHERE emp_no = $emp_no");
    $conn->query("DELETE FROM salaries WHERE emp_no = $emp_no");

    // Delete employee record
    $sql = "DELETE FROM employees WHERE emp_no=?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $emp_no);

    if ($stmt->execute()) {
        // Email notification
        $employee_email = $conn->query("SELECT email FROM employees WHERE emp_no=$emp_no")->fetch_assoc()['email'];
        $subject = "Termination Notification";
        $message = "Your employment has been terminated.";
        mail($employee_email, $subject, $message);

        echo "Employee fired successfully! <a href='dashboard.php'>Go back to Dashboard</a>";
    } else {
        echo "Error: " . $conn->error;
    }
}
?>
