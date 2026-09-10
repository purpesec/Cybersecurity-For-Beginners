<?php

$server = "localhost";
$username = "appuser";
$password = "appuser123";
$database = "tienda";

$conn = new mysqli($server, $username, $password, $database);

$id = isset($_GET['id']) ? $_GET['id'] : '';

$data = mysqli_query(
    $conn,
    "SELECT username FROM users WHERE id = '$id'"
) or die(mysqli_error($conn));

$response = mysqli_fetch_array($data);

if ($response) {
    echo $response['username'];
}

?>