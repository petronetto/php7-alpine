<?php

$dbname   = getenv('POSTGRES_DB');
$user     = getenv('POSTGRES_USER');
$password = getenv('POSTGRES_PASSWORD');
$strConn  = "pgsql:host=database;dbname=$dbname;user=$user;password=$password";

try {
    $conn = new PDO($strConn);
    echo "<p>Database Connection Sucessful!!!</p>";
} catch (PDOException $error) {
    echo "Error:" . $error->getMessage();
    die();
}

echo "<p>See <a href='http://{$_SERVER[HTTP_HOST]}/info.php'> Here</a> for PHP info.</p>";
