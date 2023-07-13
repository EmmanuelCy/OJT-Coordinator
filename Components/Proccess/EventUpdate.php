<?php
session_start();
@include_once("../../Database/config.php");
@include_once("../../Components/PopupAlert.php");

if (!isset($_SESSION['DatahasbeenFetched'])) {
    header("Location: ../Login.php");
} else {
    $ShowAlert = true;
}

if ($_SERVER['REQUEST_METHOD'] == "GET") {
    $EventID = $_GET['id'];
    $_SESSION['idngevent'] = $EventID;

    $sql = "SELECT * FROM tbl_events WHERE eventID = '$EventID'";
    $result = mysqli_query($conn, $sql);
    $row = mysqli_fetch_assoc($result);

    $title = $row['eventTitle'];
    $desc = $row['eventDescription'];
    $image = $row['eventImage'];
    $date = $row['eventDate'];
    $formatdate = date("F j, Y", strtotime($date));
    $start = $row['eventStartTime'];
    $formatstart = date("g:i A", strtotime($start));
    $end = $row['eventEndTime'];
    $formatend = date("g:i A", strtotime($end));
    $type = $row['eventType'];
    $comp = $row['eventCompletion'];
    $formatcomp = date("F j, Y", strtotime($comp));
    $ended = $row['eventEnded'];
    $loc = $row['eventLocation'];
    $slot = $row['eventSlots'];
    $org = $row['eventOrganizer'];

    if ($ended == 'true') {
        $status = "Ended";
    } else {
        $status = "Ongoing";
    }
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../../Style/ColorPalette.css">
    <link rel="stylesheet" href="../../Style/Fonts.css">
    <link rel="stylesheet" href="../../Style/Bootstrap_Style/bootstrap.css">
    <script src="../../Script/SweetAlert2.js"></script>
    <script src="../../Script/Bootstrap_Script/bootstrap.bundle.js"></script>
    <title>Update Event</title>
    <style>
        * {
            font-family: 'Poppins';
            box-sizing: border-box;
            scroll-behavior: smooth;
        }

        body {
            background-color: var(--clr-background);
        }

        .listhead {
            background-color: var(--clr-primary);
            background-image: url("../../Image/BGanimated.svg");
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center;
        }

        .bgani {
            background: linear-gradient(147deg, #020304, #445384);
            background-size: 400% 400%;
            animation: AnimationName 25s ease infinite;
        }

        @keyframes AnimationName {
            0% {
                background-position: 10% 0%
            }

            50% {
                background-position: 91% 100%
            }

            100% {
                background-position: 10% 0%
            }
        }

        /*For the scroll bar*/
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: var(--body-color);
            transition: var(--tran-05);
        }

        ::-webkit-scrollbar-thumb {
            background: var(--primary-color);
            border-radius: 5px;
        }

        ::selection {
            background-color: var(--primary-color);
            color: #fff;
        }
    </style>
</head>

<body class="bgani">
    <?php
    if (isset($ShowAlert)) {
        echo NewAlertBox();
        $_SESSION['Show'] = false;
    }
    ?>
    <div class="container-lg">
        <div class="row">
            <div class="col-md-12">
                <h1 class="text-center text-uppercase text-light">Update Event</h1>
                <hr>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <ul class="list-group">
                    <li class="list-group-item listhead text-center">
                        <img src="../<?php if (isset($image)) {
                            echo $image;
                        } ?>" class="img-fluid img-thumbnail m-1" style="height: 256px;" alt="...">
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center text-bg-dark">
                        <span class="fw-bold">Title</span>
                        <span>
                            <?php if (isset($title)) {
                                echo $title;
                            } ?>
                        </span>
                    </li>
                    <li class="list-group-item text-bg-dark">
                        <span class="fw-bold">Description</span>
                        <br>
                        <span style="text-align: justify;">
                            <?php if (isset($desc)) {
                                echo $desc;
                            } ?>
                        </span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center text-bg-dark">
                        <span class="fw-bold">Date</span>
                        <span>
                            <?php if (isset($formatdate)) {
                                echo $formatdate;
                            } ?>
                        </span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center text-bg-dark">
                        <span class="fw-bold">Time</span>
                        <span>
                            <?php if (isset($formatstart)) {
                                echo $formatstart;
                            } ?> -
                            <?php if (isset($formatend)) {
                                echo $formatend;
                            } ?>
                        </span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center text-bg-dark">
                        <span class="fw-bold">Completion</span>
                        <span>
                            <?php if (isset($formatcomp)) {
                                echo $formatcomp;
                            } ?>
                        </span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center text-bg-dark">
                        <span class="fw-bold">Location</span>
                        <span>
                            <?php if (isset($loc)) {
                                echo $loc;
                            } ?>
                        </span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center text-bg-dark">
                        <span class="fw-bold">Type</span>
                        <span>
                            <?php if (isset($type)) {
                                echo $type;
                            } ?>
                        </span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center text-bg-dark">
                        <span class="fw-bold">Organizer</span>
                        <br>
                        <span>
                            <?php if (isset($org)) {
                                echo $org;
                            } ?>
                        </span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center text-bg-dark">
                        <span class="fw-bold">Slots</span>
                        <span>
                            <?php if (isset($slot)) {
                                echo $slot;
                            } ?> Participants
                        </span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center text-bg-dark">
                        <span class="fw-bold">Status</span>
                        <span>
                            <?php if (isset($status)) {
                                echo $status;
                            } ?>
                        </span>
                    </li>
                    <li class="list-group-item text-center text-bg-dark">
                        <div class="hstack gap-3">
                            <a href="../../Admin/AdminEvents.php" class="btn btn-primary w-100">Back</a>
                            <a class="btn btn-danger" id="delete" title="Delete this event"><img
                                    src="../../Image/Delete.svg" alt="trash" style="height: 24px;"></a>
                            <script>
                                const deletebtn = document.getElementById('delete');
                                deletebtn.addEventListener('click', function () {
                                    Swal.fire({
                                        title: 'Are you sure?',
                                        text: "You won't be able to revert this!",
                                        icon: 'warning',
                                        showCancelButton: true,
                                        confirmButtonColor: '#3085d6',
                                        cancelButtonColor: '#d33',
                                        confirmButtonText: 'Yes, delete it!',
                                        background: "#19191a",
                                        color: "#fff"

                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            window.location.href = "../../Components/Proccess/EveDelete.php?id=<?php echo $EventID; ?>";
                                        }
                                    })
                                })
                            </script>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="col-md-6">
                <form method="POST" enctype="multipart/form-data" action="../Proccess/Eupdate.php">
                    <input type="hidden" name="EventID" value="<?php if (isset($EventID)) {
                        echo $EventID;
                    } ?>">
                    <ul class="list-group list-group-flush rounded">
                        <li class="list-group-item bg-transparent text-light">
                            <div class="mb-3">
                                <label for="EventTitle" class="form-label">Event Title</label>
                                <input type="text" class="form-control" id="EventTitle" name="EventTitle" value="<?php if (isset($title)) {
                                    echo $title;
                                } ?>">
                            </div>
                        </li>
                        <li class="list-group-item bg-transparent text-light">
                            <div class="mb-3">
                                <label for="EventDescription" class="form-label">Event Description</label>
                                <textarea class="form-control" id="EventDescription" name="EventDescription" rows="10"><?php if (isset($desc)) {
                                    echo $desc;
                                } ?></textarea>
                            </div>
                        </li>
                        <li class="list-group-item bg-transparent text-light">
                            <div class="mb-3">
                                <label for="EventDate" class="form-label">Event Date</label>
                                <input type="date" class="form-control" id="EventDate" name="EventDate" value="<?php if (isset($date)) {
                                    echo $date;
                                } ?>">
                            </div>
                        </li>
                        <li class="list-group-item bg-transparent text-light">
                            <div class="mb-3">
                                <label for="EventComp" class="form-label">Event Completion</label>
                                <input type="date" class="form-control" id="EventComp" name="EventComp" value="<?php if (isset($comp)) {
                                    echo $comp;
                                } ?>">
                            </div>
                        </li>
                        <li class="list-group-item bg-transparent text-light">
                            <div class="mb-3">
                                <label for="EventStartTime" class="form-label">Event Start Time</label>
                                <input type="time" class="form-control" id="EventStartTime" name="EventStartTime" value="<?php if (isset($start)) {
                                    echo $start;
                                } ?>">
                            </div>
                        </li>
                        <li class="list-group-item bg-transparent text-light">
                            <div class="mb-3">
                                <label for="EventEndTime" class="form-label">Event End Time</label>
                                <input type="time" class="form-control" id="EventEndTime" name="EventEndTime" value="<?php if (isset($end)) {
                                    echo $end;
                                } ?>">
                            </div>
                        </li>
                        <li class="list-group-item bg-transparent text-light">
                            <div class="mb-3">
                                <label for="EventLocation" class="form-label">Event Location</label>
                                <input type="text" class="form-control" id="EventLocation" name="EventLocation" value="<?php if (isset($loc)) {
                                    echo $loc;
                                } ?>">
                            </div>
                        </li>
                        <li class="list-group-item bg-transparent text-light">
                            <div class="mb-3">
                                <label for="EventType" class="form-label">Event Type</label>
                                <select class="form-select" id="EventType" name="EventType"
                                    value="<?php if (isset($type)) ?>">
                                    <option selected hidden>
                                        <?php if (isset($type)) {
                                            echo $type;
                                        } ?>
                                    </option>
                                    <option value="webinar">Webinar</option>
                                    <option value="workshop">Workshop</option>
                                    <option value="seminar">Seminar</option>
                                    <option value="conference">Conference</option>
                                    <option value="other">Other</option>
                                </select>
                            </div>
                        </li>
                        <li class="list-group-item bg-transparent text-light">
                            <div class="mb-3">
                                <label for="EventSlots" class="form-label">Event Slots</label>
                                <input type="text" class="form-control" id="EventOrg" name="EventOrg" value="<?php if (isset($org)) {
                                    echo $org;
                                } ?>">
                            </div>
                        </li>
                        <li class="list-group-item bg-transparent text-light">
                            <div class="mb-3">
                                <label for="EventSlots" class="form-label">Event Slots</label>
                                <input type="number" class="form-control" id="EventSlots" name="EventSlots" value="<?php if (isset($slot)) {
                                    echo $slot;
                                } ?>">
                            </div>
                        </li>
                        <li class="list-group-item bg-transparent text-center">
                            <input type="submit" name="upevent" class="btn btn-success w-50" value="Update Event">
                        </li>
                    </ul>
                </form>
            </div>
        </div>
    </div>
    <br>
</body>

</html>