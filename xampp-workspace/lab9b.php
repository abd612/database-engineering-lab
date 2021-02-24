<?php

if(isset($_POST['submit']))
{
    $hostname = "localhost";
    $username = "root";
    $password = "1246";
    $dbname = "house_db";
    
    $hid = $_POST['hid'];
    $address = $_POST['address'];
    $area = $_POST['area'];
    $value = $_POST['value'];

    
    $db = new mysqli($hostname, $username, $password, $dbname) or die("Unable to connect");

    if(empty($_POST['address']) && empty($_POST['area']) && empty($_POST['value']))
        $query = "insert into house values ('$hid', NULL, NULL, NULL)";
    else if(empty($_POST['address']) && !empty($_POST['area']) && !empty($_POST['value']))
        $query = "insert into house values ('$hid', NULL, '$area, '$value')";
    else if(!empty($_POST['address']) && empty($_POST['area']) && !empty($_POST['value']))
        $query = "insert into house values ('$hid', '$address', NULL, '$value')";
    else if(!empty($_POST['address']) && !empty($_POST['area']) && empty($_POST['value']))
        $query = "insert into house values ('$hid', '$address', '$area', NULL)";
    else if(empty($_POST['address']) && empty($_POST['area']) && !empty($_POST['value']))
        $query = "insert into house values ('$hid', NULL, NULL, '$value')";
    else if(empty($_POST['address']) && !empty($_POST['area']) && empty($_POST['value']))
        $query = "insert into house values ('$hid', NULL, '$area', NULL)";
    else if(!empty($_POST['address']) && empty($_POST['area']) && empty($_POST['value']))
        $query = "insert into house values ('$hid', '$address', NULL, NULL)";
    else
        $query = "insert into house values ('$hid', '$address', '$area', '$value')";

    $result = $db->query($query);

    $db->close();
}

?>

<!DOCTYPE html>

<html>
    <head>
        <title> Data Entry for Houses </title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>

    <body>
        Data Entry for Houses <br><br>
        <form action="lab9b.php" method="post">
            hid:<br>
            <input type="number" name="hid" required placeholder="hid"><br><br>
            address:<br>
            <input type="text" name="address" placeholder="address"><br><br>
            area:<br>
            <input type="number" name="area" step="any" placeholder="area"><br><br>
            value:<br>
            <input type="number" name="value" step="any" placeholder="value"><br><br>
            <input type="submit" name="submit" value="submit">
            <input type="reset" name="reset" value="reset">
        </form>
    </body>
</html>
