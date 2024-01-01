<?php

include 'database.php';

$uploadfile=$_FILES['uploadfile']['tmp_name'];

require 'PHPExcel/Classes/PHPExcel.php';
require_once 'PHPExcel/Classes/PHPExcel/IOFactory.php';
$uploadfile1="a.xls";

$objExcel=PHPExcel_IOFactory::load($uploadfile1);

/*foreach($objExcel->getWorksheetIterator() as $worksheet)
{
	$highestrow=$worksheet->getHighestRow();

	for($row=0;$row<=$highestrow;$row++)
	{
		$lib_id=$worksheet->getCellByColumnAndRow(0,$row)->getValue();
                $name=$worksheet->getCellByColumnAndRow(1,$row)->getValue();
                $phone=$worksheet->getCellByColumnAndRow(2,$row)->getValue();
                $Em_Contact=$worksheet->getCellByColumnAndRow(3,$row)->getValue();
                $Blood=$worksheet->getCellByColumnAndRow(4,$row)->getValue();
                $address=$worksheet->getCellByColumnAndRow(5,$row)->getValue();
                $usn=$worksheet->getCellByColumnAndRow(6,$row)->getValue();
                $dob=$worksheet->getCellByColumnAndRow(7,$row)->getValue();
                $branch=$worksheet->getCellByColumnAndRow(8,$row)->getValue();
                $type=$worksheet->getCellByColumnAndRow(9,$row)->getValue();
                $photo=$worksheet->getCellByColumnAndRow(10,$row)->getValue();
		$pass=$worksheet->getCellByColumnAndRow(11,$row)->getValue();
                if($lib_id!='')
                {
                        $insertqry1="INSERT INTO `Library_card_index` VALUES ('$lib_id','$usn',NULL,'$pass')";
                        $insertres=mysqli_query($con,$insertqry1);
                        $insertqry2="INSERT INTO `Students` VALUES ('$lib_id','$name','$phone', '$Em_Contact', '$Blood', '$address','$usn', NULL,'$branch','$type','$photo')";
			$insertres=mysqli_query($con,$insertqry2);
		}
	}
}*/
header('Location: index.php');
?>
