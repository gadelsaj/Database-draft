<?php
session_start();
include 'db_connection.php';

if (!isset($_SESSION['manager'])) {
    header("Location: login.php");
    exit;
}


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $emp_no = $_POST['emp_no'];
    $new_dept_no = $_POST['new_department'];

    // Fetch current department for history tracking
    $current_dept = $conn->query("SELECT dept_no FROM titles WHERE emp_no=$emp_no")->fetch_assoc()['dept_no'];

    // Update department
    $sql = "UPDATE titles SET dept_no=? WHERE emp_no=?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ii", $new_dept_no, $emp_no);

    if ($stmt->execute()) {
        // Insert into history table
        $history_sql = "INSERT INTO history (emp_no, change_type, old_value, new_value) VALUES (?, 'Department Change', ?, ?)";
        $history_stmt = $conn->prepare($history_sql);
        $history_stmt->bind_param("iss", $emp_no, $current_dept, $new_dept_no);
        $history_stmt->execute();

        // Email notification
        $employee_email = $conn->query("SELECT email FROM employees WHERE emp_no=$emp_no")->fetch_assoc()['email'];
        $subject = "Department Update Notification";
        $message = "Your department has been updated to department ID: $new_dept_no.";
        //mail($employee_email, $subject, $message);

        echo "Department updated successfully! <a href='dashboard.php'>Go back to Dashboard</a>";
    } else {
        echo "Error: " . $conn->error;
    }
    exit;
}

$emp_no = $_GET['emp_no'];
$departments = $conn->query("SELECT * FROM departments");
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Change Department</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Change Department</h1>
    <form method="POST">
        <input type="hidden" name="emp_no" value="<?php echo $emp_no; ?>">
        <label for="new_department">Select New Department:</label>
        <select name="new_department" id="new_department">
            <?php while ($row = $departments->fetch_assoc()) { ?>
                <option value="<?php echo $row['dept_no']; ?>"><?php echo $row['dept_name']; ?></option>
            <?php } ?>
        </select>
        <button type="submit">Update Department</button>
    </form>
</body>
</html>
