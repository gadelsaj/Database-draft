<?php
session_start();
include 'db_connection.php';

if (!isset($_SESSION['manager']) || $_SESSION['role'] !== 'admin') {
    die("Unauthorized access.");
}

if (isset($_GET['emp_no'])) {
    $emp_no = $_GET['emp_no'];

    // Update employee's employment_status to 'terminated'
    $sql = "UPDATE employees SET employment_status = 'terminated' WHERE emp_no = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $emp_no);

    if ($stmt->execute()) {
        // Optional email notification
        $employee_email = $conn->query("SELECT email FROM employees WHERE emp_no=$emp_no")->fetch_assoc()['email'];
        $subject = "Termination Notification";
        $message = "Your employment status has been updated to 'terminated'.";
      //  mail($employee_email, $subject, $message);

        echo "Employee terminated successfully! <a href='dashboard.php'>Go back to Dashboard</a>";
    } else {
        echo "Error: " . $conn->error;
    }
}
?>
