<?php
// Start the session to retrieve the logged-in employee's ID (if needed)
session_start();

// Database connection
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "emp_project"; // Replace with your database name

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Initialize the employee data variable
$employee = null;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Ensure the user has entered a valid employee ID
    $employee_id = isset($_POST['emp_no']) ? $_POST['emp_no'] : null;
    
    if ($employee_id) {
        // SQL query to fetch employee details by employee number
        $sql = "SELECT e.emp_no, e.first_name, e.last_name, d.dept_name, t.title, s.salary
                FROM employees e
                LEFT JOIN titles t ON e.emp_no = t.emp_no
                LEFT JOIN salaries s ON e.emp_no = s.emp_no
                LEFT JOIN departments d ON t.dept_no = d.dept_no
                WHERE e.emp_no = ? AND t.to_date = '9999-01-01'"; // Current title

        // Prepare and bind the SQL query
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $employee_id);
        $stmt->execute();
        $result = $stmt->get_result();

        // Check if the employee exists in the database
        if ($result->num_rows > 0) {
            $employee = $result->fetch_assoc();
        } else {
            $error_message = "No employee found with the ID number: $employee_id";
        }
    } else {
        $error_message = "Please enter a valid Employee ID.";
    }
}

// Close the connection
$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Dashboard</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

    <!-- Navbar -->
    <nav>
        <ul>
            <li><a href="employee_list.php">List Employees</a></li>
            <li><a href="project_details.php?project_id=2">Project Details</a></li>
            <li><a href="logout.php">Logout</a></li>
        </ul>
    </nav>

    <!-- Banner -->
    <header>
        <h1>Employee Dashboard</h1>
    </header>

    <!-- Form to input Employee ID -->
    <section class="search-employee">
        <h2>Search Employee by ID</h2>
        <form method="POST">
            <label for="emp_no">Employee ID:</label>
            <input type="text" name="emp_no" id="emp_no" required>
            <button type="submit">Search</button>
        </form>
        <?php
        if (isset($error_message)) {
            echo "<p style='color:red;'>$error_message</p>";
        }
        ?>
    </section>

    <!-- Employee Information -->
    <section class="employee-info">
        <?php if ($employee): ?>
        <h2>Employee Information</h2>
        <table>
            <tr>
                <td>Employee Number:</td>
                <td><?php echo htmlspecialchars($employee['emp_no']); ?></td>
            </tr>
            <tr>
                <td>First Name:</td>
                <td><?php echo htmlspecialchars($employee['first_name']); ?></td>
            </tr>
            <tr>
                <td>Last Name:</td>
                <td><?php echo htmlspecialchars($employee['last_name']); ?></td>
            </tr>
            <tr>
                <td>Department:</td>
                <td><?php echo htmlspecialchars($employee['dept_name']); ?></td>
            </tr>
            <tr>
                <td>Title:</td>
                <td><?php echo htmlspecialchars($employee['title']); ?></td>
            </tr>
            <tr>
                <td>Salary:</td>
                <td><?php echo '$' . number_format($employee['salary'], 2); ?></td>
            </tr>
        </table>
        <?php else: ?>
        <p>No employee data available. Please try searching for a valid employee ID.</p>
        <?php endif; ?>
    </section>

</body>
</html>
