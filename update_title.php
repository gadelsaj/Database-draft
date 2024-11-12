<?php
include 'db_connection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $emp_no = $_POST['emp_no'];
    $new_title = $_POST['new_title'];

    $sql = "UPDATE titles SET title=? WHERE emp_no=?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("si", $new_title, $emp_no);

    if ($stmt->execute()) {
        echo "Title updated successfully! <a href='dashboard.php'>Go back to Dashboard</a>";
    } else {
        echo "Error: " . $conn->error;
    }
    exit;
}

$emp_no = $_GET['emp_no'];
$titles = $conn->query("SELECT DISTINCT title FROM titles");
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Change Title</title>
</head>
<body>
    <h1>Change Title</h1>
    <form method="POST">
        <input type="hidden" name="emp_no" value="<?php echo $emp_no; ?>">
        <label for="new_title">Select New Title:</label>
        <select name="new_title" id="new_title">
            <?php while ($row = $titles->fetch_assoc()) { ?>
                <option value="<?php echo $row['title']; ?>"><?php echo $row['title']; ?></option>
            <?php } ?>
        </select>
        <button type="submit">Update Title</button>
    </form>
</body>
</html>
