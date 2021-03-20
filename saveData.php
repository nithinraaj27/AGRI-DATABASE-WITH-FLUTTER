<?php
include "config.php";

$name = $_POST['name'];
$crop_name = $_POST['crop_name'];
$crop_weight = $_POST['crop_weight'];

if($name!="" && $crop_name !="" && $crop_weight != "")
{
$sql = "insert into users (name,crop_name,crop_weight) values ('$name','$crop_name','$crop_weight');";

if($con->query($sql))
{
    echo "true";
}
else
{
    echo "fasle";
}

}

?>