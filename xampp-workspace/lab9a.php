<!DOCTYPE html>

<html>
    <head>
        <title> Database Creation </title>
    </head>

    <body>
        Dababase Creation <br><br>
    </body>
</html>

<?php

$hostname = 'localhost';
$username = 'root';
$password = '1246';
$dbname   = 'house_db';

$db = new mysqli($hostname, $username, $password, $dbname) or die("Unable to connect");
echo "House database connected!<br>";

$query1 = "create table house (hid int primary key, address varchar(30), area decimal(5,2), value decimal(5,2));";
$result1 = $db->query($query1);

if($result1)
{
	echo "House table created!<br>";
}

else
{
	echo "House table not created!<br>";
}

$query2 = "create table owner (oid int, hid int, pdate date, primary key (oid, hid), foreign key (hid) references house(hid));";
$result2 = $db->query($query2);

if($result2)
{
	echo "Owner table created!<br>";
}

else
{
	echo "Owner table not created!<br>";
}

$db->close();
?>