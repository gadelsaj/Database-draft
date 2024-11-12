<?php
session_start();
include 'db_connection.php';

if (!isset($_SESSION['manager'])) {
    header("Location: login.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['emp_no']) && isset($_POST['review_text'])) {
    $emp_no = $_POST['emp_no'];
    $review_text = $_POST['review_text'];
    $manager_id = $_SESSION['manager'];

    $sql = "INSERT INTO performance_reviews (emp_no, manager_id, review_text) VALUES (?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("iis", $emp_no, $manager_id, $review_text);

    if ($stmt->execute()) {
        echo "Performance review added successfully! <a href='dashboard.php'>Back to Dashboard</a>";
    } else {
        echo "Error adding review: " . $conn->error;
    }
} else {
    echo "Missing data. <a href='dashboard.php'>Back to Dashboard</a>";
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Add Performance Review</title>
</head>
<body>
    <h1>Add Performance Review</h1>
    <form method="POST">
        <label for="emp_no">Employee Number:</label>
        <input type="text" name="emp_no" id="emp_no" required>
        <br>
        <label for="review_text">Review:</label>
        <textarea name="review_text" id="review_text" required></textarea>
        <br>
        <button type="submit">Submit Review</button>
    </form>
</body>
</html>
