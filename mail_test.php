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
