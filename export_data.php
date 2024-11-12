<?php
include 'db_connection.php';

header('Content-Type: text/csv');
header('Content-Disposition: attachment;filename="employee_data.csv"');

$output = fopen('php://output', 'w');
fputcsv($output, ['Employee No', 'Name', 'Department', 'Title', 'Salary']);

$sql = "SELECT e.emp_no, CONCAT(e.first_name, ' ', e.last_name) AS name, d.dept_name, t.title, s.salary
        FROM employees e
        LEFT JOIN titles t ON e.emp_no = t.emp_no
        LEFT JOIN salaries s ON e.emp_no = s.emp_no
        LEFT JOIN departments d ON t.dept_no = d.dept_no";

$result = $conn->query($sql);

while ($row = $result->fetch_assoc()) {
    fputcsv($output, $row);
}

fclose($output);
?>
