<?php
session_start();
include 'db_connection.php';

if (!isset($_SESSION['manager'])) {
    header("Location: login.php");
    exit;
}

$role = $_SESSION['role']; // Use for RBAC

$sql = "SELECT e.emp_no, e.first_name, e.last_name, d.dept_name, MAX(t.title) AS title, MAX(s.salary) AS salary
        FROM employees e
        LEFT JOIN titles t ON e.emp_no = t.emp_no
        LEFT JOIN departments d ON t.dept_no = d.dept_no
        LEFT JOIN salaries s ON e.emp_no = s.emp_no
        WHERE t.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
        GROUP BY e.emp_no, e.first_name, e.last_name, d.dept_name";


$result = $conn->query($sql);

// Fetch department-wise and title-wise distributions for reporting
$dept_dist = $conn->query("SELECT d.dept_name, COUNT(*) AS count 
                           FROM employees e 
                           LEFT JOIN titles t ON e.emp_no = t.emp_no 
                           LEFT JOIN departments d ON t.dept_no = d.dept_no 
                           GROUP BY d.dept_name");

$title_dist = $conn->query("SELECT t.title, COUNT(*) AS count 
                            FROM titles t 
                            GROUP BY t.title");

// Fetch departments and titles for bulk actions
$departments = $conn->query("SELECT * FROM departments");
$titles = $conn->query("SELECT DISTINCT title FROM titles");
?>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
       <!-- Navbar -->
 <nav>
    <ul>
        <li><a href="dashboard.php">Dashboard</a></li>
        <li><a href="logout.php">Logout</a></li>
    </ul>
    <h1>Employee List</h1>
    <button onclick="window.location.href='add_employee.php'">Add Employee</button>
    <form method="POST" action="bulk_actions.php">
        <table border="1">
            <tr>
                <th>Select</th>
                <th>Employee No</th>
                <th>Name</th>
                <th>Department</th>
                <th>Title</th>
                <th>Salary</th>
                <th>Actions</th>
            </tr>
            <?php while ($row = $result->fetch_assoc()) { ?>
            <tr>
                <td><input type="checkbox" name="selected_employees[]" value="<?php echo $row['emp_no']; ?>"></td>
                <td><?php echo htmlspecialchars($row['emp_no']); ?></td>
                <td><?php echo htmlspecialchars($row['first_name'] . " " . $row['last_name']); ?></td>
                <td><?php echo htmlspecialchars($row['dept_name']); ?></td>
                <td><?php echo htmlspecialchars($row['title']); ?></td>
                <td><?php echo htmlspecialchars($row['salary']); ?></td>
                <td>
                    <a href="update_department.php?emp_no=<?php echo $row['emp_no']; ?>">Change Department</a> |
                    <a href="update_title.php?emp_no=<?php echo $row['emp_no']; ?>">Change Title</a> |
                    <a href="update_salary.php?emp_no=<?php echo $row['emp_no']; ?>">Update Salary</a>
                    <a href="fire_employee.php?emp_no=<?php echo urlencode($row['emp_no']); ?>">Fire</a>

</form>


</form>


                    
                     
                </td>
            </tr>
            
            <?php } ?>
        </table>
        
        <br>
        <h3>Bulk Actions</h3>
        <label for="new_department">New Department:</label>
        <select name="new_department" id="new_department">
            <?php while ($dept = $departments->fetch_assoc()) { ?>
                <option value="<?php echo $dept['dept_no']; ?>"><?php echo htmlspecialchars($dept['dept_name']); ?></option>
            <?php } ?>
        </select>
        <br>
        <label for="new_title">New Title:</label>
        <select name="new_title" id="new_title">
            <?php while ($title = $titles->fetch_assoc()) { ?>
                <option value="<?php echo htmlspecialchars($title['title']); ?>"><?php echo htmlspecialchars($title['title']); ?></option>
            <?php } ?>
        </select>
        <br>
        <button type="submit" name="action" value="bulk_update_department">Bulk Update Department</button>
        <button type="submit" name="action" value="bulk_update_title">Bulk Update Title</button>
    </form>
    
    <h2>Reporting</h2>

<div class="reporting-container">
    <div class="table-container">
        <h3>Department Distribution</h3>
        <table border="1">
            <thead>
                <tr>
                    <th>Department Name</th>
                    <th>Count</th>
                </tr>
            </thead>
            <tbody>
                <?php while ($row = $dept_dist->fetch_assoc()) { ?>
                    <tr>
                        <td><?php echo htmlspecialchars($row['dept_name']); ?></td>
                        <td><?php echo htmlspecialchars($row['count']); ?></td>
                    </tr>
                <?php } ?>
            </tbody>
        </table>
    </div>

    <div class="table-container">
        <h3>Title Distribution</h3>
        <table border="1">
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Count</th>
                </tr>
            </thead>
            <tbody>
                <?php while ($row = $title_dist->fetch_assoc()) { ?>
                    <tr>
                        <td><?php echo htmlspecialchars($row['title']); ?></td>
                        <td><?php echo htmlspecialchars($row['count']); ?></td>
                    </tr>
                <?php } ?>
            </tbody>
        </table>
    </div>
</div>

<style>
    
    .reporting-container {
        display: flex;
        justify-content: space-between; /* Adjusts space between tables */
        gap: 20px; /* Space between the tables */
    }
    .table-container {
        width: 48%; /* Controls width of each table */
    }
    table {
        width: 100%; /* Ensures the tables use full width of their container */
        border-collapse: collapse;
    }
    th, td {
        padding: 8px;
        text-align: left;
    }
    th {
        background-color: #f2f2f2;
    }
    /* Specific styles for buttons inside the table */
table button {
    background-color: #3e3e3e; /* Dark, muted gray button for sophistication */
    color: white;
    border: 2px solid #4a4a4a; /* Matching the color of the links for cohesion */
    padding: 6px 12px; /* Smaller padding */
    font-size: 0.9em; /* Smaller font size to fit within the table */
    cursor: pointer;
    text-transform: uppercase; /* Adds formality */
    letter-spacing: 1px;
    transition: background-color 0.3s, border-color 0.3s ease;
    margin: 3px; /* Adjusted margin for spacing between buttons */
}

table button:hover {
    background-color: #c5a300; /* Hover effect with goldish yellow */
    border-color: #c5a300; /* Border matches the hover color */
}

table button:focus {
    outline: none;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.5); /* Soft shadow for focus effect */
}

</style>



    <h3><button onclick="window.location.href='export_data.php'">Export Data</button></h3>
<h3><button onclick="window.location.href='add_review.php'">Add Performance Review</button></h3>


</body>
</html>
