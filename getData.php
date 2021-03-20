<?php
include "config.php";

$sql = " select * from users order by name ";
$result = array();
$res = $con->query($sql);

//print_r($res);

if($res->num_rows>0)
{
    while($row = $res->fetch_assoc())
    {
        $result[] = $row;
    }
}

echo json_encode($result);
?>