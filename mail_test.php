<?php
$to = "jgadelsaid@gmail.com"; // Replace with your email
$subject = "Test Email";
$message = "This is a test email from XAMPP using a local mail server.";
$headers = "From: jgadelsaid@gmail.com"; // Replace with your sender email

if (mail($to, $subject, $message, $headers)) {
    echo "Email sent successfully!";
} else {
    echo "Failed to send email.";
}
?>


<!DOCTYPE html>
<html lang="en">
<head>
    <title>Email Test</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Send Test Email</h1>
    <form method="POST">
        <label for="email">Recipient Email:</label>
        <input type="email" id="email" name="email" required>
        <br><br>
        
        <label for="subject">Subject:</label>
        <input type="text" id="subject" name="subject" required>
        <br><br>
        
        <label for="message">Message:</label>
        <textarea id="message" name="message" required></textarea>
        <br><br>
        
        <button type="submit">Send Email</button>
    </form>
</body>
</html>
