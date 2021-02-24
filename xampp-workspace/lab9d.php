<!DOCTYPE html>

<html>
    <head>
        <title> Database Access </title>
    </head>

    <body>
        Dababase Access <br><br>
    </body>
</html>

<?php

$hostname = 'localhost';
$username = 'root';
$password = '1246';
$dbname   = 'house_db';

$db = new mysqli($hostname, $username, $password, $dbname) or die("Unable to connect");

echo "Query #1<br><br>";

$query1 = "select area, avg(value) from house group by area order by area;";
$result1 = $db->query($query1);

echo "<table border = '1'>";
echo "<tr><td> area </td><td> avg value </td></tr>";
while ($row = mysqli_fetch_array($result1, MYSQLI_ASSOC)) {
$area = $row['area'];
$avgvalue = $row['avg(value)'];
if (empty($area)) $area = "NULL";
if (empty($avgvalue)) $avgvalue = "NULL";
echo "<tr><td>".$area."</td><td>".$avgvalue."</td></tr>";
}
echo "</table>";

echo "<br>Query #2<br><br>";

$query2 = "select h.hid, h.address, h.area, h.value, o.oid, o.pdate from house h left outer join owner o on h.hid = o.hid;";
$result2 = $db->query($query2);

echo "<table border = '1'>";
echo "<tr><td> hid </td><td> address </td><td> area </td><td> value </td><td> oid </td><td> pdate </td></tr>";
while ($row = mysqli_fetch_array($result2, MYSQLI_ASSOC)) {
$hid = $row['hid'];
$address = $row['address'];
$area = $row['area'];
$value = $row['value'];
$oid = $row['oid'];
$pdate = $row['pdate'];
if (empty($hid)) $hid = "NULL";
if (empty($address)) $address = "NULL";
if (empty($area)) $area = "NULL";
if (empty($value)) $value = "NULL";
if (empty($oid)) $oid = "NULL";
if (empty($pdate)) $pdate = "NULL";
echo "<tr><td>".$hid."</td><td>".$address."</td><td>".$area."</td><td>".$value."</td><td>".$oid."</td><td>".$pdate."</td></tr>";
}
echo "</table>";

echo "<br>Query #3<br><br>";

$query3 = "select * from owner where oid in (select oid from owner group by oid having count(*) >= 2);";
$result3 = $db->query($query3);

echo "<table border = '1'>";
echo "<tr><td> oid </td><td> hid </td><td> pdate </td></tr>";
while ($row = mysqli_fetch_array($result3, MYSQLI_ASSOC)) {
$oid = $row['oid'];
$hid = $row['hid'];
$pdate = $row['pdate'];
if (empty($oid)) $oid = "NULL";
if (empty($hid)) $hid = "NULL";
if (empty($pdate)) $pdate = "NULL";
echo "</td><td>".$oid."</td><td>".$hid."</td><td>".$pdate."</td></tr>";
}
echo "</table>";

$db->close();
?>