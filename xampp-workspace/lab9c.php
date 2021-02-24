<?php

if(isset($_POST['submit']))
{
    $hostname = "localhost";
    $username = "root";
    $password = "1246";
    $dbname = "house_db";
    
    $oid = $_POST['oid'];
    $hid = $_POST['hid'];
    $pdate = $_POST['pdate'];
    
    $db = new mysqli($hostname, $username, $password, $dbname) or die("Unable to connect");

    if(empty($_POST['pdate']))
        $query = "insert into owner values ('$oid', '$hid', NULL)";
    else
        $query = "insert into owner values ('$oid', '$hid', '$pdate')";
    
    $result = $db->query($query);
    
    $db->close();
}

?>

<!DOCTYPE html>

<html>
    <head>
        <title> Data Entry for Owners </title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>

    <body>
        Data Entry for Owners <br><br>
        <form action="lab9c.php" method="post">
            oid:<br>
            <input type="number" name="oid" required placeholder="oid"><br><br>
            hid:<br>
            <input type="number" name="hid" required placeholder="hid"><br><br>
            pdate:<br>
            <input type="date" name="pdate" placeholder="pdate"><br><br>
            <input type="submit" name="submit" value="submit">
            <input type="reset" name="reset" value="reset">
        </form>
    </body>
</html>
