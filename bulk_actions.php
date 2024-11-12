<?php
session_start();
include 'db_connection.php';

if (!isset($_SESSION['manager'])) {
    header("Location: login.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && isset($_POST['selected_employees'])) {
    $selected_employees = $_POST['selected_employees'];
    $action = $_POST['action'];

    if ($action === 'bulk_update_department' && isset($_POST['new_department'])) {
        $new_department = $_POST['new_department'];

        foreach ($selected_employees as $emp_no) {
            $sql = "UPDATE titles SET dept_no = ? WHERE emp_no = ? AND to_date = '9999-01-01'";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("ii", $new_department, $emp_no);
            $stmt->execute();
        }
        echo "Departments updated successfully! <a href='dashboard.php'>Back to Dashboard</a>";
    } elseif ($action === 'bulk_update_title' && isset($_POST['new_title'])) {
        $new_title = $_POST['new_title'];

        foreach ($selected_employees as $emp_no) {
            $sql = "UPDATE titles SET title = ? WHERE emp_no = ? AND to_date = '9999-01-01'";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("si", $new_title, $emp_no);
            $stmt->execute();
        }
        echo "Titles updated successfully! <a href='dashboard.php'>Back to Dashboard</a>";
    } else {
        echo "Invalid action or missing data. <a href='dashboard.php'>Back to Dashboard</a>";
    }
} else {
    echo "No employees selected. <a href='dashboard.php'>Back to Dashboard</a>";
}
?>
