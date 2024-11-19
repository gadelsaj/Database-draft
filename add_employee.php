<?php
session_start();
include 'db_connection.php';

if (!isset($_SESSION['manager'])) {
    header("Location: login.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Retrieve form data
    $first_name = $_POST['first_name'];
    $last_name = $_POST['last_name'];
    $dept_no = $_POST['dept_no'];
    $title = $_POST['title'];
    $salary = $_POST['salary'];

    // Insert employee into the database
    $sql = "INSERT INTO employees (first_name, last_name) VALUES ('$first_name', '$last_name')";
    if ($conn->query($sql) === TRUE) {
        $emp_no = $conn->insert_id; // Get the newly inserted employee's number

        // Add title and salary for the new employee
        $conn->query("INSERT INTO titles (emp_no, title, from_date, to_date, dept_no) VALUES ($emp_no, '$title', CURDATE(), '9999-01-01', '$dept_no')");
        $conn->query("INSERT INTO salaries (emp_no, salary, from_date, to_date) VALUES ($emp_no, '$salary', CURDATE(), '9999-01-01')");

        echo "New employee added successfully!";
        header("Location: employee_list.php");
        exit;
    } else {
        echo "Error: " . $conn->error;
    }
}

?>

<!DOCTYPE html>
<html>
<head>
    <title>Add Employee</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Add New Employee</h1>
    <form method="POST">
        <label for="first_name">First Name:</label>
        <input type="text" id="first_name" name="first_name" required>
        <br>
        <label for="last_name">Last Name:</label>
        <input type="text" id="last_name" name="last_name" required>
        <br>
        <label for="dept_no">Department:</label>
        <select name="dept_no" id="dept_no" required>
            <?php
            // Fetch departments from the database
            $result = $conn->query("SELECT * FROM departments");
            while ($row = $result->fetch_assoc()) {
                echo "<option value='" . $row['dept_no'] . "'>" . $row['dept_name'] . "</option>";
            }
            ?>
        </select>
        <br>
        <label for="title">Title:</label>
        <input type="text" id="title" name="title" required>
        <br>
        <label for="salary">Salary:</label>
        <input type="number" id="salary" name="salary" required>
        <br>
        <button type="submit">Add Employee</button>
    </form>
</body>
</html>
