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
    </ul>

    <!-- Banner -->
    <header>
        <h1>Employee Dashboard</h1>
        <p>Welcome, <?php echo $employee['first_name'] . ' ' . $employee['last_name']; ?>!</p>
    </header>

    <!-- Employee Information -->
    <section class="employee-info">
        <h2>Employee Information</h2>
        <table>
            <tr>
                <td>Birthdate:</td>
                <td><?php echo $employee['birth_date']; ?></td>
            </tr>
            <tr>
                <td>Department:</td>
                <td><?php echo $employee['dept_name']; ?></td>
            </tr>
            <tr>
                <td>Department Start Date:</td>
                <td><?php echo $employee['dept_start']; ?></td>
            </tr>
            <tr>
                <td>Department End Date:</td>
                <td><?php echo $employee['dept_end']; ?></td>
            </tr>
            <tr>
                <td>Current Title:</td>
                <td><?php echo $employee['title']; ?></td>
            </tr>
            <tr>
                <td>Title Start Date:</td>
                <td><?php echo $employee['title_start']; ?></td>
            </tr>
            <tr>
                <td>Title End Date:</td>
                <td><?php echo $employee['title_end']; ?></td>
            </tr>
            <tr>
                <td>Manager:</td>
                <td><?php echo $employee['manager_first'] . ' ' . $employee['manager_last']; ?></td>
            </tr>
            <tr>
                <td>Average Salary:</td>
                <td><?php echo '$' . number_format($employee['avg_salary'], 2); ?></td>
            </tr>
        </table>
    </section>

    <!-- Action Buttons -->
    <section class="actions">
        <button onclick="window.location.href='update_department.php'">Change Department</button>
        <button onclick="window.location.href='update_title.php'">Change Title</button>
        <button onclick="window.location.href='update_salary.php'">Change Salary</button>
        <button onclick="window.location.href='fire_employee.php'">Fire Employee</button>
    </section>

</body>
</html>
