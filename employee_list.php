<?php
session_start();
include 'db_connection.php';

if (!isset($_SESSION['manager'])) {
    header("Location: login.php");
    exit;
}

$role = $_SESSION['role']; // Use for RBAC

$sql = "SELECT e.emp_no, e.first_name, e.last_name,
               (SELECT d.dept_name FROM departments d
                JOIN titles t ON t.dept_no = d.dept_no
                WHERE t.emp_no = e.emp_no ORDER BY t.from_date DESC LIMIT 1) AS dept_name,
               (SELECT t.title FROM titles t WHERE t.emp_no = e.emp_no ORDER BY t.from_date DESC LIMIT 1) AS title,
               (SELECT s.salary FROM salaries s WHERE s.emp_no = e.emp_no ORDER BY s.from_date DESC LIMIT 1) AS salary,
               (SELECT pr.review_text FROM performance_reviews pr WHERE pr.emp_no = e.emp_no ORDER BY pr.review_date DESC LIMIT 1) AS review_text
        FROM employees e
        WHERE e.employment_status = 'Active'";




$result = $conn->query($sql);

// Fetch department-wise and title-wise distributions for reporting
$dept_dist = $conn->query("SELECT d.dept_name, COUNT(*) AS count 
                           FROM employees e 
                           LEFT JOIN titles t ON e.emp_no = t.emp_no 
                           LEFT JOIN departments d ON t.dept_no = d.dept_no 
                           WHERE e.employment_status = 'Active' 
                           AND d.dept_name IS NOT NULL AND d.dept_name != ''
                           GROUP BY d.dept_name");


$title_dist = $conn->query("SELECT t.title, COUNT(*) AS count 
                            FROM titles t
                            LEFT JOIN employees e ON t.emp_no = e.emp_no
                            WHERE e.employment_status = 'Active'
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

        <!-- Add Employee Button -->
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
                    <th>Performance Review</th> <!-- New column for performance reviews -->
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
                        <?php 
                        if ($row['review_text']) {
                            echo nl2br(htmlspecialchars($row['review_text'])); 
                        } else {
                            echo "No review available";
                        }
                        ?>
                    </td>
                    <td>
                        <a href="update_department.php?emp_no=<?php echo $row['emp_no']; ?>">Change Department</a> |
                        <a href="update_title.php?emp_no=<?php echo $row['emp_no']; ?>">Change Title</a> |
                        <a href="update_salary.php?emp_no=<?php echo $row['emp_no']; ?>">Update Salary</a> |
                        <a href="fire_employee.php?emp_no=<?php echo $row['emp_no']; ?>">Terminate</a>
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
    <?php while ($row = $dept_dist->fetch_assoc()) { 
        // Skip blank department rows
        if (empty($row['dept_name'])) continue;
    ?>
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
                justify-content: space-between;
                gap: 20px;
            }
            .table-container {
                width: 48%;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
            table button {
                background-color: #3e3e3e;
                color: white;
                border: 2px solid #4a4a4a;
                padding: 6px 12px;
                font-size: 0.9em;
                cursor: pointer;
                text-transform: uppercase;
                letter-spacing: 1px;
                transition: background-color 0.3s, border-color 0.3s ease;
                margin: 3px;
            }
            table button:hover {
                background-color: #c5a300;
                border-color: #c5a300;
            }
            table button:focus {
                outline: none;
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.5);
            }
        </style>

        <h3><button onclick="window.location.href='export_data.php'">Export Data</button></h3>
        <h3><button onclick="window.location.href='add_review.php'">Add Performance Review</button></h3>

    </body>
</html>
