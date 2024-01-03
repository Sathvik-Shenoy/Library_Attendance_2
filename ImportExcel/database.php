<?php
//$con=mysqli_connect('127.0.0.1','root','mysql123','attendance_management_system');
$con = mysqli_connect("localhost","root","mysql123","attendance_management_system");    if(!$con)
if(mysqli_connect_errno())
{
	echo 'Failed to connect to database'.mysqli_connect_error();
}
?>
