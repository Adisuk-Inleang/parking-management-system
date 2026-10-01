<?php
$host = "localhost";
$user = "root"; 
$pass = ""; 
$dbname = "parking_db";

$conn = new mysqli($host, $user, $pass, $dbname);

if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(["message" => "Database Connection Failed: " . $conn->connect_error]);
    exit();
}

$conn->set_charset("utf8mb4");
?>