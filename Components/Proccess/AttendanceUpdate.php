<?php
@include_once("../../Database/config.php");
// Connect to the database 
$conn = mysqli_connect("localhost", "root", "", "ojtcs_database");

date_default_timezone_set('Asia/Manila');
// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}
$u_ID = $_SESSION['GlobalID'];
// Handle form submission
if($_SERVER['REQUEST_METHOD'] == 'POST') {

  // Handle time in
  if(isset($_POST['time_in'])) {
    $timein = date('H:i:s');

    // Insert time in to database
    $sql ="INSERT INTO tbl_timesheet (UID, time_in) VALUES ('$u_ID', '$timein')";
    $result = mysqli_query($conn, $sql);
    $timein = date('h:i:s A');

    // Redirect to prevent form resubmission
    header("Location: UserAttendance.php");
    exit();
  } 

  // Handle time out
  else if(isset($_POST['time_out'])) {
    $timeout = date('H:i:s');
    $datenow = date('Y-m-d');
    
    // Fetch the last record for the user
    $sql = "SELECT * FROM tbl_timesheet WHERE UID = '$u_ID' AND time_out IS NULL ORDER BY TID DESC LIMIT 1";
    $result = mysqli_query($conn, $sql);
    $record = mysqli_fetch_assoc($result);
    $timein = $record['time_in'];

    // Update the last record for the user with the time out
    $sql = "UPDATE tbl_timesheet SET time_out = '$timeout' where UID = '$u_ID' AND time_out IS NULL ORDER BY TID DESC LIMIT 1";
    $result = mysqli_query($conn, $sql);

    // Calculate the rendered time for the current time-in/out
    $renderedMinutes = (strtotime($timeout) - strtotime($timein)) / 60;

    // Check if a record for the current date already exists in tbl_traineerenderedtime
    $sql = "SELECT * FROM tbl_traineerenderedtime WHERE UID = '$u_ID' AND date = '$datenow'";
    $result = mysqli_query($conn, $sql);
    $record = mysqli_fetch_assoc($result);

    if ($record) {
        // If a record for the current date already exists, update it
        $newMinutes = $record['minutes'] + $renderedMinutes;
        $sql = "UPDATE tbl_traineerenderedtime SET minutes = '$newMinutes' WHERE UID = '$u_ID' AND date = '$datenow'";
    } else {
        // If no record for the current date exists, insert a new one
        $sql = "INSERT INTO tbl_traineerenderedtime (UID, date, minutes) VALUES ('$u_ID', '$datenow', '$renderedMinutes')";
    }

    // Execute the query
    if (!mysqli_query($conn, $sql)) {
        echo "Error: " . mysqli_error($conn);
    }

    // Redirect to prevent form resubmission
    header("Location: UserAttendance.php");
    exit();
  }
}

$datenow = date('Y-m-d');
// Fetch the last record for the user
$sql = "SELECT * FROM tbl_timesheet WHERE UID = '$u_ID' ORDER BY TID DESC LIMIT 1";
$result = mysqli_query($conn, $sql);
$lastRecord = mysqli_fetch_assoc($result);
$timein = $lastRecord['time_in'];
$timeout = $lastRecord['time_out'];
// Check if the last record exists and if it has a Time-out
$timeInDisabled = '';
$timeOutDisabled = '';
if ($lastRecord) {
    if (empty($lastRecord['time_out'])) {
        // If the last record doesn't have a Time-out, disable the Time-in button
        $timeInDisabled = 'visible';
    } else {
        // If the last record has a Time-out, disable the Time-out button
        $timeOutDisabled = 'visible';
    }
} else {
    // If there's no last record, disable the Time-out button
    $timeOutDisabled = '';
}

?>