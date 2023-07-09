<?php
session_start();
@include_once("../Database/config.php");

if (!isset($_SESSION['DatahasbeenFetched'])) {
    header("Location: ../Login.php");
} else {
    $ShowAlert = true;
}

if (isset($_POST['searchEvent']) && !empty($_POST['searchEvent'])) {
    $search = $_POST['searchEvent'];
    $sql = "SELECT * FROM tbl_programs WHERE eventTitle LIKE '%$search%'";
} else if (isset($_POST['resetEvent'])) {
    $sql = "SELECT * FROM tbl_programs";
} else {
    $sql = "SELECT * FROM tbl_programs";
}
$result = mysqli_query($conn, $sql);
unset($_POST['searchEvent']);
unset($_POST['resetEvent']);

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../Style/ImportantImport.css">
    <script src="../Script/SidebarScript.js"></script>
    <script src="../Script/SweetAlert2.js"></script>
    <script src="../Script/Bootstrap_Script/bootstrap.bundle.js"></script>
    <title>Programs</title>
</head>

<body class="dark adminuser" style="min-width: 1080px;">
    <?php
    @include_once '../Components/AdminSidebar.php';
    @include_once '../Components/Modals/ProgtamsModals.php';
    @include_once '../Components/PopupAlert.php';
    if (isset($ShowAlert)) {
        echo NewAlertBox();
        $_SESSION['Show'] = false;
    }
    ?>
    <section class="home">
        <div class="text">Programs</div>
        <div class="container-fluid" style="width: 98%;">
            <div class="container-xl my-1 table-responsive">
                <button class="btn btn-primary p-2 bg-gradient" type="button" data-bs-toggle="collapse"
                    data-bs-target="#EventForm" aria-expanded="false" aria-controls="EventForm">
                    <img src="../Image/Create.svg" alt="" class="me-2" width="24" height="24">
                    <span class="m-2">Create Program</span>
                </button>
                <div class="collapse" id="EventForm">
                    <form class="row g-3 rounded mt-1" method="POST" action="../Components/Proccess/EventInsert.php"
                        enctype="multipart/form-data">
                        <div class="col-md-6">
                            <div class="form-floating mb-3 text-light">
                                <input type="text" class="form-control text-bg-dark" id="EventTitle" name="EventTitle"
                                    placeholder="Event Name">
                                <label for="EventTitle">Event Name</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-floating mb-3 text-light">
                                <input type="text" class="form-control text-bg-dark" id="EventLocation"
                                    name="EventLocation" placeholder="Event Location">
                                <label for="EventLocation">Event Location</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-floating mb-3 text-light">
                                <input type="date" class="form-control text-bg-dark" id="EventDate" name="EventDate"
                                    placeholder="Event Date">
                                <label for="EventDate">Event Date</label>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-floating mb-3 text-light">
                                <input type="time" class="form-control text-bg-dark" id="EventStart" name="EventStart"
                                    placeholder="Event Start Time">
                                <label for="EventStart">Event Start Time</label>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-floating mb-3 text-light">
                                <input type="time" class="form-control text-bg-dark" id="EventEnd" name="EventEnd"
                                    placeholder="Event End Time">
                                <label for="EventEnd">Event End Time</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-floating mb-3 text-light">
                                <select class="form-select text-bg-dark" name="EventType" id="EventType"
                                    aria-label="Events Type">
                                    <option selected hidden>Choose...</option>
                                    <option value="webinar">Webinar</option>
                                    <option value="workshop">Workshop</option>
                                    <option value="seminar">Seminar</option>
                                    <option value="conference">Conference</option>
                                    <option value="other">Other</option>
                                </select>
                                <label for="floatingSelect">Event Type</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-floating mb-3 text-light">
                                <input type="date" class="form-control text-bg-dark" id="EventCompletion"
                                    name="EventCompletion" placeholder="Event Completion Date">
                                <label for="EventCompletion">Event Completion Date</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-floating mb-3 text-light">
                                <input type="text" class="form-control text-bg-dark" id="EventOrganizer"
                                    name="EventOrganizer" placeholder="Event Organizer">
                                <label for="EventOrganizer">Event Organizer</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-floating mb-3 text-light">
                                <input type="number" max="50" min="5" class="form-control text-bg-dark" id="EventSlot"
                                    name="EventSlot" placeholder="Event Slot">
                                <label for="EventOrganizer">Event Slots</label>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="input-group mb-3 text-bg-dark">
                                <input type="file" class="form-control text-bg-dark" id="EventImage" name="EventImage">
                            </div>
                        </div>
                        <div class="col-md-12">,
                            <div class="form-floating mb-3 text-light">
                                <textarea class="form-control text-bg-dark" placeholder="Event Description"
                                    id="EventDescription" name="EventDescription" style="height: 150px"
                                    minlength="256"></textarea>
                                <label for="EventDescription">Event Description</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <input type="submit" class="btn btn-primary mb-1 w-50 bg-gradient" name="addEvent"
                                id="addEvent" value="Submit">
                            <input type="reset" class="btn btn-danger w-50 bg-gradient" name="resetEvent"
                                id="resetEvent" value="Reset">
                        </div>
                        <div class="col">
                            <script>
                                //form validation
                                document.addEventListener("DOMContentLoaded", function () {
                                    let EventTitle = document.getElementById("EventTitle");
                                    let EventLocation = document.getElementById("EventLocation");
                                    let EventDate = document.getElementById("EventDate");
                                    let EventStart = document.getElementById("EventStart");
                                    let EventEnd = document.getElementById("EventEnd");
                                    let EventType = document.getElementById("EventType");
                                    let EventCompletion = document.getElementById("EventCompletion");
                                    let EventOrganizer = document.getElementById("EventOrganizer");
                                    let EventSlot = document.getElementById("EventSlot");
                                    let EventDescription = document.getElementById("EventDescription");
                                    let error = document.querySelector(".error");

                                    error.innerHTML = "";

                                    // check if date is grater than completion date
                                    EventDate.addEventListener("change", function () {
                                        let date = new Date(EventDate.value);
                                        let completion = new Date(EventCompletion.value);
                                        if (date > completion) {
                                            error.innerHTML = "Event date cannot be greater than completion date";
                                            EventDate.value = "";
                                        } else {
                                            error.innerHTML = "";
                                        }
                                    });

                                    // check if completion date is less than date
                                    EventCompletion.addEventListener("change", function () {
                                        let date = new Date(EventDate.value);
                                        let completion = new Date(EventCompletion.value);
                                        if (completion < date) {
                                            error.innerHTML = "Completion date cannot be less than event date";
                                            EventCompletion.value = "";
                                        } else {
                                            error.innerHTML = "";
                                        }
                                    });

                                    // check if end time is greater than start time
                                    EventEnd.addEventListener("change", function () {
                                        let start = EventStart.value;
                                        let end = EventEnd.value;
                                        if (end < start) {
                                            error.innerHTML = "End time cannot be less than start time";
                                            EventEnd.value = "";
                                        } else {
                                            error.innerHTML = "";
                                        }
                                    });
                                });
                            </script>
                            <p class="text-danger error">
                                this is for error message
                            </p>
                        </div>
                    </form>
                </div>
                <hr class="mt-4 mb-4" style="background-color: white; height: 5px; border-radius: 5px;">

                <!-- search bar -->
                <form action="AdminPrograms.php" method="POST" id="searchForm">
                    <div class="input-group mb-3">
                        <input type="text" class="form-control text-bg-dark" placeholder="Search Event Title"
                            aria-label="Search Event" aria-describedby="button-addon2" name="searchEvent"
                            id="searchEvent">
                        <input type="submit" value="Reset" class="btn btn-outline-danger" id="resetEvent"
                            name="resetEvent">
                    </div>
                </form>
                <?php
                if (mysqli_num_rows($result) > 0) {
                    $i = 1;
                    while ($row = mysqli_fetch_assoc($result)) {

                        $start = date("g:i A", strtotime($row['start_date']));
                        $end = date("g:i A", strtotime($row['end_date']));
                        $date = date("F j, Y", strtotime($row['start_time']));

                        if ($row['closed'] == 1) {
                            $status = 'Ended';
                        } else {
                            $status = 'Ongoing';
                        }

                        $output = '
            <div class="col">
                <div class="card h-100 text-bg-dark">
                   
                    <div class="card-body">
                        <h5 class="card-title">' . $row['title'] . '</h5>
                        <p class="card-text">' . $date . '</p>
                        
                        <p class="card-text" style="font-size: 14px;">' . $row['description'] . '</p>
                        <small class="text-muted">Time: ' . $start . ' - ' . $end . ' | Available Seats: ' . $row['slots'] . '</small>
                    </div>
                    <div class="card-footer text-center">
                        <a id="viewEvent' . $i . '" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#ViewEvent" style="width: 100%;">View</a>
                    </div>
                </div>
            </div>
            <script>
                let viewEvent' . $i . ' = document.querySelector("#viewEvent' . $i . '");

                viewEvent' . $i . '.addEventListener("click", () => {
                    let EventTitle = document.querySelector("#title");
                
                    let EventDesc = document.querySelector("#description");
                    let EventDate = document.querySelector("#start_date");
                    let EventTime = document.querySelector("#start_time");
                    
                
                    let EventStat = document.querySelector("#Mstat");
                 
                    let EventUp = document.querySelector("#end_date");

                    EventTitle.innerHTML = "' . $row['title'] . '";
                    
                    EventDesc.innerHTML = "' . $row['description'] . '";
                    EventDate.innerHTML = "' . $row['start_date'] . '";
                    EventTime.innerHTML = "' . $row['start_time'] . $end . '";
                   
 
                    EventStat.innerHTML = "' . $status . '";
                    
                    EventUp.href = "AdminUpdateEvent.php?id=' . $row['progID'] . '";
                    });
                    </script>';
                        echo '<div class="row row-cols-1 row-cols-md-3 g-4">';
                        echo $output;
                        echo '</div>';
                        $i++;
                    }
                } else {
                    @include_once '../Components/Placeholders/CardPlaceholder.php';
                }
                ?>
            </div>
            <br>
        </div>
    </section>
</body>

</html>