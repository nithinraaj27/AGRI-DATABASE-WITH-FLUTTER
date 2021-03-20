<?php
include "config.php";
$id = $_POST['id'];

$sql = "delete from users where id = $id;";
if($con->query($sql))
{
    echo "true";
}
else
{
    echo "fasle";
}


?>