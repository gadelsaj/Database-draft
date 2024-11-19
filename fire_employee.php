<?php
session_start();
include 'db_connection.php';

if (!isset($_SESSION['manager'])) {
    header("Location: login.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $emp_no = $_POST['emp_no'];

    if (empty($emp_no)) {
        echo "Error: Employee number is missing.";
        exit;
    }

    // Delete the employee from all relevant tables
    try {
        $conn->begin_transaction();

        // Remove from `titles` table
        $sql = "DELETE FROM titles WHERE emp_no = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $emp_no);
        $stmt->execute();

        // Remove from `salaries` table
        $sql = "DELETE FROM salaries WHERE emp_no = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $emp_no);
        $stmt->execute();

        // Remove from `employees` table
        $sql = "DELETE FROM employees WHERE emp_no = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $emp_no);
        $stmt->execute();

        $conn->commit();
        $_SESSION['message'] = "Employee #$emp_no was successfully removed.";
        header("Location: employee_list.php");
        exit;
    } catch (Exception $e) {
        $conn->rollback();
        echo "Error: Could not remove the employee. " . $e->getMessage();
        exit;
    }
} else {
    header("Location: employee_list.php");
    exit;
}
