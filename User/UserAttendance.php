user_id INT NOT NULL,

<?php
session_start();
@include_once("../../Database/config.php");
@include_once("../Components/PopupAlert.php");
@include_once '../Components/Proccess/AttendanceUpdate.php';
date_default_timezone_set('Asia/Manila');
echo date('h:i:s a');

$_SESSION['SAtheme'] = "light";

if (!isset($_SESSION['DatahasbeenFetched'])) {
    header("Location: ../Login.php");
} elseif ($_SESSION['GlobalProfileCompleted'] == 'false') {
    header("Location: ../User/UserProfile.php");
} else {
    $ShowAlert = true;
}
?>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="./Style/AttendanceStyle.css">
    <link rel="stylesheet" href="../Style/ImportantImport.css">
    <link rel="stylesheet" href="../Style/TestingDashboard.css">
    <script src="../Script/SweetAlert2.js"></script>
    <title>Attendance</title>
</head>

<body>
    <?php
  include_once '../Components/Sidebar.php';
  if (isset($ShowAlert)) {
    echo NewAlertBox();
    $_SESSION['Show'] = false;
  } ?>
    <section class="home">
        <div class="text">Trainee Attendance</div>
        <div style="margin: 10px; width: 98%;">
            <div class="container-lg">
            </div>
            <?php
      //include_once '../Components/Proccess/AttendanceUpdate.php';
      ?>



</body>

<style>
/* Style the form */
body {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;

}

form {
      max-width: 500px;
      margin: 0 auto;
      padding: 5px;
      border: 5px solid #000000;
      border-radius: 10px;
      height: 65vh;
  }

  .clock {
      font-size: 2em;
      text-align: center;
      color: #333;
      border: 2px solid #333;
      border-radius: 10px;
      padding: 20px;
      margin: 20px auto;
      width: fit-content;
      background-color: #f9f9f9;
      box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
  }

  .date {
      font-size: 1em;
      text-align: center;
      color: #333;
      border: 2px solid #333;
      border-radius: 10px;
      padding: 10px;
      margin: 10px auto;
      width: fit-content;
      background-color: #f9f9f9;
      box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
  }

  /* Style the inputs */
  input[type="text"],
  button[type="submit"] {
      width: 100%;
      padding: 12px 20px;
      margin: 8px 0;
      box-sizing: border-box;
      border: 1px solid #ccc;
      border-radius: 4px;
      height: 10vh;
  }

  button[disabled] {
        background-color: #cccccc;
        color: #666666;
        cursor: not-allowed;
    }
    
  /* Style the submit buttons */
  button[type="submit"] {
      background-color: #4CAF50;
      color: white;
      cursor: pointer;
  }

  /* Add spacing between buttons */
  button[type="submit"]+button[type="submit"] {
      margin-top: 25px;
  }

  /* Style error messages */
  .error {
      color: red;
      margin: 10px 0;
  }

  /* Center align paragraphs */
  p {
      text-align: center;
  }

  .parent {
      display: flex;
      justify-content: center;
  }

  #view-btn {
      background-color: #4CAF50;
      border: none;
      color: white;
      padding: 15px 32px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 16px;
      margin: 4px 2px;
      cursor: pointer;
      border-radius: 4px;


  }

  #view-btn:hover {
      background-color: #3e8e41;
  }
</Style>

<!-- original form -->

<form method="post">
    <input type="hidden" name="UID" value="<?php echo $_SESSION['GlobalID']; ?>">


    <div class="container-lg">
        <div id="liveClock" class="clock"></div>
        <p class="date"><?php echo $datenow; ?></p>
        
    </div>

    <form>
        <input type="text" name="UName" value="<?php echo $_SESSION['GlobalName']; ?>" disabled
            style="text-align: center; font-weight: bold;">

        <div class="attendance-info">
            <p>Time In: <b><?php echo date('h:i:s A', strtotime($timein)) ?? 'null'; ?></b></p>
            <p>Time Out: <b><?php echo ($timeout && $timeout != '00:00:00') ? date('h:i:s A', strtotime($timeout)) : '------------'; ?></b></p>
        </div>
        
        <?php if($lastRecord && ($lastRecord['time_out'] == '00:00:00' || $lastRecord['time_out'] == '')){
          echo '<button type="submit" name="time_out" style="background-color: red;">Time Out</button>';
        }else {
          echo '<button type="submit" name="time_in" >Time In</button>';
        } ?> 
        
        
    </form>
    <script>
        function updateClock() {
            var now = new Date();
            var h = now.getHours();
            var m = now.getMinutes();
            var s = now.getSeconds();
            var ampm = h >= 12 ? 'PM' : 'AM';
            h = h % 12;
            h = h ? h : 12; // the hour '0' should be '12'
            m = checkTime(m);
            s = checkTime(s);
            document.getElementById('liveClock').innerHTML = h + ":" + m + ":" + s + " " + ampm;
            var t = setTimeout(updateClock, 500);
            drawClock();
        }

        function checkTime(i) {
            if (i < 10) {
                i = "0" + i
            }; // add zero in front of numbers < 10
            return i;
        }

        updateClock();
        drawClock();
    </script>

    </div>
    </section>
    <script src="../Script/SidebarScript.js"></script>
    <script src="../Script/Bootstrap_Script/bootstrap.bundle.js"></script>