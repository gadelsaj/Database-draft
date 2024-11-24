<?php
session_start();
include 'db_connection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $emp_no = $_SESSION['manager']; // Logged-in manager's employee number
    $currentPassword = $_POST['current_password']; // Current password
    $newPassword = $_POST['new_password']; // New password

    // Get the current hashed password from the database
    $sql = "SELECT password FROM deptmanagers WHERE emp_no = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $emp_no);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows > 0) {
        $manager = $result->fetch_assoc();
        
        // Verify current password
        if (password_verify($currentPassword, $manager['password'])) {
            // Hash the new password and update it in the database
            $hashedPassword = password_hash($newPassword, PASSWORD_BCRYPT);

            $sqlUpdate = "UPDATE deptmanagers SET password = ? WHERE emp_no = ?";
            $stmtUpdate = $conn->prepare($sqlUpdate);
            $stmtUpdate->bind_param("si", $hashedPassword, $emp_no);
            
            if ($stmtUpdate->execute()) {
                $message = "Password updated successfully.";
            } else {
                $error = "Error: " . $stmtUpdate->error;
            }
        } else {
            $error = "Current password is incorrect.";
        }
    } else {
        $error = "Manager not found.";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Update Password</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Update Password</h1>
    <form method="POST">
        <label for="current_password">Current Password:</label>
        <input type="password" name="current_password" id="current_password" required>
        <br>
        <label for="new_password">New Password:</label>
        <input type="password" name="new_password" id="new_password" required>
        <br>
        <button type="submit">Update Password</button>
    </form>

    <?php if (isset($message)) echo "<p style='color:green;'>$message</p>"; ?>
    <?php if (isset($error)) echo "<p style='color:red;'>$error</p>"; ?>
</body>
</html>
