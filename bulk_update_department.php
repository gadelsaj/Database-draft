<?php
session_start();
include 'db_connection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $emp_ids = $_POST['emp_ids']; // Array of employee IDs
    $new_dept_no = $_POST['new_department'];

    if (!empty($emp_ids) && !empty($new_dept_no)) {
        $placeholders = implode(',', array_fill(0, count($emp_ids), '?'));
        $sql = "UPDATE titles SET dept_no=? WHERE emp_no IN ($placeholders)";
        $stmt = $conn->prepare($sql);

        $params = array_merge([$new_dept_no], $emp_ids);
        $stmt->bind_param(str_repeat('i', count($params)), ...$params);

        if ($stmt->execute()) {
            echo "Department updated for selected employees successfully!";
        } else {
            echo "Error: " . $conn->error;
        }
    } else {
        echo "Please select employees and a department.";
    }
    exit;
}

// Fetch departments and employees
$departments = $conn->query("SELECT * FROM departments");
$employees = $conn->query("SELECT emp_no, first_name, last_name FROM employees");
?>
<!DOCTYPE html>
<html>
<head>
    <title>Bulk Update Department</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Bulk Update Department</h1>
    <form method="POST">
        <h3>Select Employees:</h3>
        <?php while ($row = $employees->fetch_assoc()) { ?>
            <input type="checkbox" name="emp_ids[]" value="<?php echo $row['emp_no']; ?>">
            <?php echo $row['first_name'] . " " . $row['last_name']; ?><br>
        <?php } ?>
        
        <h3>Select New Department:</h3>
        <select name="new_department">
            <?php while ($row = $departments->fetch_assoc()) { ?>
                <option value="<?php echo $row['dept_no']; ?>"><?php echo $row['dept_name']; ?></option>
            <?php } ?>
        </select>
        <button type="submit">Update Department</button>
    </form>
</body>
</html>
