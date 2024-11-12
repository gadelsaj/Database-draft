<?php
session_start();
include 'db_connection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $emp_ids = $_POST['emp_ids']; // Array of employee IDs
    $new_title = $_POST['new_title'];

    if (!empty($emp_ids) && !empty($new_title)) {
        $placeholders = implode(',', array_fill(0, count($emp_ids), '?'));
        $sql = "UPDATE titles SET title=? WHERE emp_no IN ($placeholders)";
        $stmt = $conn->prepare($sql);

        $params = array_merge([$new_title], $emp_ids);
        $stmt->bind_param(str_repeat('s', count($params)), ...$params);

        if ($stmt->execute()) {
            echo "Title updated for selected employees successfully!";
        } else {
            echo "Error: " . $conn->error;
        }
    } else {
        echo "Please select employees and a title.";
    }
    exit;
}

// Fetch titles and employees
$titles = $conn->query("SELECT DISTINCT title FROM titles");
$employees = $conn->query("SELECT emp_no, first_name, last_name FROM employees");
?>
<!DOCTYPE html>
<html>
<head>
    <title>Bulk Update Title</title>
</head>
<body>
    <h1>Bulk Update Title</h1>
    <form method="POST">
        <h3>Select Employees:</h3>
        <?php while ($row = $employees->fetch_assoc()) { ?>
            <input type="checkbox" name="emp_ids[]" value="<?php echo $row['emp_no']; ?>">
            <?php echo $row['first_name'] . " " . $row['last_name']; ?><br>
        <?php } ?>
        
        <h3>Select New Title:</h3>
        <select name="new_title">
            <?php while ($row = $titles->fetch_assoc()) { ?>
                <option value="<?php echo $row['title']; ?>"><?php echo $row['title']; ?></option>
            <?php } ?>
        </select>
        <button type="submit">Update Title</button>
    </form>
</body>
</html>
