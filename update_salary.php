<?php
session_start();
include 'db_connection.php';

if (!isset($_SESSION['manager'])) {
    header("Location: login.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $emp_no = $_POST['emp_no'];
    $new_salary = $_POST['new_salary'];

    // Fetch current salary for history tracking
    $current_salary = $conn->query("SELECT salary FROM salaries WHERE emp_no=$emp_no")->fetch_assoc()['salary'];

    // Update salary
    $sql = "UPDATE salaries SET salary=? WHERE emp_no=?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("di", $new_salary, $emp_no);

    if ($stmt->execute()) {
        // Insert into history table
        $history_sql = "INSERT INTO history (emp_no, change_type, old_value, new_value) VALUES (?, 'Salary Update', ?, ?)";
        $history_stmt = $conn->prepare($history_sql);
        $history_stmt->bind_param("iss", $emp_no, $current_salary, $new_salary);
        $history_stmt->execute();

        // Email notification
        $employee_email = $conn->query("SELECT email FROM employees WHERE emp_no=$emp_no")->fetch_assoc()['email'];
        $subject = "Salary Update Notification";
        $message = "Your salary has been updated to: $new_salary.";
        mail($employee_email, $subject, $message);

        echo "Salary updated successfully! <a href='dashboard.php'>Go back to Dashboard</a>";
    } else {
        echo "Error: " . $conn->error;
    }
    exit;
}

$emp_no = $_GET['emp_no'];
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Update Salary</title>
</head>
<body>
    <h1>Update Salary</h1>
    <form method="POST">
        <input type="hidden" name="emp_no" value="<?php echo $emp_no; ?>">
        <label for="new_salary">Enter New Salary:</label>
        <input type="number" name="new_salary" id="new_salary" step="0.01" required>
        <button type="submit">Update Salary</button>
    </form>
</body>
</html>
