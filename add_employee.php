<?php
session_start();
include 'db_connection.php';

if (!isset($_SESSION['manager'])) {
    header("Location: login.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Collect POST data
    $first_name = $_POST['first_name'];
    $last_name = $_POST['last_name'];
    $email = $_POST['email'];
    $phone = $_POST['phone'];
    $address = $_POST['address'];
    $birth_date = $_POST['birth_date'];
    $hire_date = $_POST['hire_date'];
    $employment_status = 'Active'; // Default to active
    $gender = $_POST['gender'];

    // Prepare the SQL query to insert the new employee
    $sql = "INSERT INTO employees (first_name, last_name, email, phone, address, birth_date, hire_date, employment_status, gender)
            VALUES ('$first_name', '$last_name', '$email', '$phone', '$address', '$birth_date', '$hire_date', '$employment_status', '$gender')";

    if ($conn->query($sql) === TRUE) {
        // Get the new employee's emp_no
        $emp_no = $conn->insert_id;

        // Insert into 'titles' table (using dummy values for dept_no and title)
        $dept_no = 1;  // Example department number, you can change it as needed
        $title = 'Junior Developer';  // Example title, you can modify this
        $from_date = date('Y-m-d');
        $to_date = '9999-01-01';  // Set a default value for the 'to_date'
        $sql_titles = "INSERT INTO titles (emp_no, dept_no, from_date, title, to_date)
                       VALUES ('$emp_no', '$dept_no', '$from_date', '$title', '$to_date')";
        $conn->query($sql_titles);

        // Insert into 'salaries' table
        $salary = 50000;  // Example salary, you can modify this or take it from form input
        $sql_salaries = "INSERT INTO salaries (emp_no, from_date, salary, to_date)
                         VALUES ('$emp_no', '$from_date', '$salary', '$to_date')";
        $conn->query($sql_salaries);

        // Insert into 'departments' table (assuming dept_name and location are provided or set default values)
        $dept_name = 'Development';  // Example department name
        $location = 'Headquarters';  // Example location
        $sql_departments = "INSERT INTO departments (dept_no, dept_name, location)
                            VALUES ('$dept_no', '$dept_name', '$location')";
        $conn->query($sql_departments);

        // Redirect to employee list page
        header("Location: employee_list.php");
        exit;
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Add Employee</title>
</head>
<body>
    <h1>Add New Employee</h1>

    <form method="POST" action="add_employee.php">
        <label>First Name:</label>
        <input type="text" name="first_name" required><br>

        <label>Last Name:</label>
        <input type="text" name="last_name" required><br>

        <label>Email:</label>
        <input type="email" name="email" required><br>

        <label>Phone:</label>
        <input type="text" name="phone"><br>

        <label>Address:</label>
        <textarea name="address"></textarea><br>

        <label>Birth Date:</label>
        <input type="date" name="birth_date" required><br>

        <label>Hire Date:</label>
        <input type="date" name="hire_date" required><br>

        <label>Gender:</label>
        <select name="gender">
            <option value="M">Male</option>
            <option value="F">Female</option>
        </select><br>

        <button type="submit">Add Employee</button>
    </form>

</body>
</html>
