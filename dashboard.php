<?php
session_start();
include 'db_connection.php';

if (!isset($_SESSION['manager'])) {
    header("Location: login.php");
    exit;
}

$role = $_SESSION['role']; // Use for RBAC

$sql = "SELECT e.emp_no, e.first_name, e.last_name, d.dept_name, t.title, s.salary
        FROM employees e
        LEFT JOIN titles t ON e.emp_no = t.emp_no
        LEFT JOIN salaries s ON e.emp_no = s.emp_no
        LEFT JOIN departments d ON t.dept_no = d.dept_no
        WHERE t.to_date = '9999-01-01'";

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
</head>
<body>
    <h1>Employee Dashboard</h1>
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
                    <?php if ($role === 'admin') { ?>
                    | <a href="fire_employee.php?emp_no=<?php echo $row['emp_no']; ?>">Fire</a>
                    <?php } ?>
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
    <h3>Department Distribution</h3>
    <ul>
        <?php while ($row = $dept_dist->fetch_assoc()) { ?>
            <li><?php echo htmlspecialchars($row['dept_name']) . ": " . htmlspecialchars($row['count']); ?></li>
        <?php } ?>
    </ul>

    <h3>Title Distribution</h3>
    <ul>
        <?php while ($row = $title_dist->fetch_assoc()) { ?>
            <li><?php echo htmlspecialchars($row['title']) . ": " . htmlspecialchars($row['count']); ?></li>
        <?php } ?>
    </ul>

    <h3><a href="export_data.php">Export Data</a></h3>
    <h3><a href="add_review.php">Add Performance Review</a></h3>
</body>
</html>
