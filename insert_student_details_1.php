<?php
    error_reporting(E_ERROR | E_PARSE);
    
    //$con = mysqli_connect("lib-jss.ct4teqpkgci2.us-east-1.rds.amazonaws.com","admin","mysql123","attendance_management_system");
    //$con = mysqli_connect('127.0.0.1','root','mysql123','attendance_management_system');
    $con = mysqli_connect("lib-jss.ct4teqpkgci2.us-east-1.rds.amazonaws.com","admin","mysql123","attendance_management_system");
    if(!$con)
    {
        echo 'Not connected to the server';
    }

    if(!mysqli_select_db($con, 'attendance_management_system'))
    {
        echo 'Database not selected';
    }

    function gen_random_key() {

        //$conn = mysqli_connect("localhost", "root", "mysql123", "attendance_management_system");
        $conn = mysqli_connect("lib-jss.ct4teqpkgci2.us-east-1.rds.amazonaws.com","admin","mysql123","attendance_management_system");
    if(!$con)
        $key = rand(100000, 999999);
        $result = mysqli_query($con,"SELECT * FROM `Library_card_index` WHERE `lib_id`=$key");
        if(mysqli_num_rows($result) > 0){
            while($data = mysqli_fetch_assoc($result)){
                gen_random_key();
            }
        }else{
            // echo "No Records Found!";
            return $key;          
        }

    }

    //$lib_id = gen_random_key();
    $lib_id=$_POST['SR'];
    $Name = $_POST['name'];
    $PhoneNumber = $_POST['phone'];
    $Em_Phone = $_POST['em_phone'];
    //$Email = $_POST['email'];
    $Branch = $_POST['branch'];
    //$Semester = $_POST['semester'];
    $Blood = $_POST['blood'];
    $Address = $_POST['address'];
    $College_ID = $_POST['college_id'];
    $Password = $_POST['password'];
    $DOB = $_POST['dob'];
    $Type = $_POST['type'];
    $Photo = $_POST['photo'];

    //$sql = ("INSERT INTO Students VALUES ('$College_ID', '$Name', '$DOB','$Branch','$Semester','$Email','$PhoneNumber','$lib_id','$Type')");
    $sql = ("INSERT INTO Students VALUES ('$lib_id', '$Name', '$PhoneNumber', '$Em_Phone', '$Blood', '$Address', '$College_ID', '$DOB','$Branch','$Type','$Photo')");
    $hash=password_hash($Password,PASSWORD_DEFAULT);
    $sql2 = ("INSERT INTO Library_card_index (lib_id, college_id, `password`) VALUES ('$lib_id', '$College_ID', '$Password')");
    
    mysqli_query($con, $sql2);

    if(!mysqli_query($con, $sql))
    {
        ?>
        <html>  
            <head>
                <title> Not Registered </title>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <link rel="stylesheet" type="text/css" href="style.css">
                <link href="https://fonts.googleapis.com/css?family=Nunito:400,600,700,800&display=swap" rel="stylesheet">
            </head>
            <body>
            
            <!-- <div class="topleft">Top Left</div> -->
            <div class="cont">
                <!-- <img src="images/warning_sign.png" alt="Warning" class="center-sign"> -->
                <!-- <img src="images/warning_sign.png" size="10"> -->
                <br>
                <br>
                <br>
                <h1 style="text-align:center"> Failed to register </h1>
                <br>
                <center><img src="images/negative2.png" height="200" width="200"></center>
                <br>
                <p style="text-align:center"> Check the details provided / User might already be registered </p>
                <a style = " white-space:nowrap;" href="index.html"><p class="forgot-pass"> HOME </p></a> 
            </div>

            </body>
        </html>
        <?php
    }
    else 
    {
        ?>
        <html>  
            <head>
            <title> Registered </title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <link rel="stylesheet" type="text/css" href="style.css">
            <link href="https://fonts.googleapis.com/css?family=Nunito:400,600,700,800&display=swap" rel="stylesheet">
        </head>
        <body>
            <div class="cont">
                <br>
                <br>
                <h1 style="text-align:center"> User Successfully Registered  </h1>
                <br>
                <center><img src="images/tick.png"></center>
                <br>
                <h2 style=text-align:center> Please remember your Library ID for login </h2>
                <h3 style="text-align:center"> Your library ID is  <?php echo $lib_id ?> </h3>
            </div>
            </body>
        </html>
        <?php
    }
    
    header("refresh:10; url=index.html");
?>