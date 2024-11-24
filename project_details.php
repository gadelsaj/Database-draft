<?php
// Start session
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

// Fetch project ID from URL
$project_id = isset($_GET['project_id']) ? intval($_GET['project_id']) : 0;

if ($project_id > 0) {
    // Query to fetch project details
    $project_sql = "SELECT project_name, start_date, completion_date, status 
                    FROM project_assign 
                    WHERE project_id = ?";
    $project_stmt = $conn->prepare($project_sql);
    $project_stmt->bind_param("i", $project_id);
    $project_stmt->execute();
    $project_result = $project_stmt->get_result();
    $project = $project_result->fetch_assoc();

    // Query to fetch employees assigned to the project
    $employees_sql = "SELECT e.emp_no, e.first_name, e.last_name, ea.role_in_project, ea.assignment_date 
                      FROM employees e
                      JOIN emp_assignment ea ON e.emp_no = ea.emp_no
                      WHERE ea.project_id = ?";
    $employees_stmt = $conn->prepare($employees_sql);
    $employees_stmt->bind_param("i", $project_id);
    $employees_stmt->execute();
    $employees_result = $employees_stmt->get_result();
} else {
    die("Invalid project ID.");
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project Details</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

    <!-- Navbar -->
    <nav>
        <ul>
            <li><a href="dashboard.php">Dashboard</a></li>
            <li><a href="employee_list.php">List Employees</a></li>
            <li><a href="logout.php">Logout</a></li>
        </ul>
    </nav>

    <!-- Project Details -->
    <section>
        <h1>Project Details</h1>
        <?php if ($project): ?>
            <table>
                <tr>
                    <td>Project Name:</td>
                    <td><?php echo htmlspecialchars($project['project_name']); ?></td>
                </tr>
                <tr>
                    <td>Start Date:</td>
                    <td><?php echo htmlspecialchars($project['start_date']); ?></td>
                </tr>
                <tr>
                    <td>Completion Date:</td>
                    <td><?php echo htmlspecialchars($project['completion_date'] ?? 'Ongoing'); ?></td>
                </tr>
                <tr>
                    <td>Status:</td>
                    <td><?php echo htmlspecialchars($project['status']); ?></td>
                </tr>
            </table>
        <?php else: ?>
            <p>No project details available.</p>
        <?php endif; ?>
    </section>

    <!-- Assigned Employees -->
    <section>
        <h2>Assigned Employees</h2>
        <?php if ($employees_result->num_rows > 0): ?>
            <table border="1">
                <thead>
                    <tr>
                        <th>Employee ID</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Role in Project</th>
                        <th>Assignment Date</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($employee = $employees_result->fetch_assoc()): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($employee['emp_no']); ?></td>
                            <td><?php echo htmlspecialchars($employee['first_name']); ?></td>
                            <td><?php echo htmlspecialchars($employee['last_name']); ?></td>
                            <td><?php echo htmlspecialchars($employee['role_in_project']); ?></td>
                            <td><?php echo htmlspecialchars($employee['assignment_date']); ?></td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        <?php else: ?>
            <p>No employees assigned to this project.</p>
        <?php endif; ?>
    </section>

</body>
</html>
