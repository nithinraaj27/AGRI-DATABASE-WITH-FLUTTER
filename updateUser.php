<?php
include "config.php";

$name = $_POST['name'];
$crop_name = $_POST['crop_name'];
$crop_weight = $_POST['crop_weight'];
$id = $_POST['id'];

//if($name!="" && $crop_name != ""  && $crop_weight != "")
//{

$sql = "update users set name = '$name', crop_name = '$crop_name', crop_weight = '$crop_weight' where id =$id;";
if($con->query($sql))
{
    echo "true";
}
else
{
    echo "fasle";
}


?>