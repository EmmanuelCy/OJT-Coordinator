<?php
session_start();
@include_once("../Database/config.php");
@include_once("../Components/PopupAlert.php");

// prevent user from accessing the page without logging in
if (!isset($_SESSION['DatahasbeenFetched'])) {
    header("Location: ../Login.php");
} else {
    $ShowAlert = true;
}

$sql = "SELECT COUNT(UID), COUNT(program), COUNT(completed) FROM tbl_trainee;";
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
    $row = mysqli_fetch_row($result);
    $TotalTrainee = $row[0];
    $Deployed = $row[1];
    $Completed = $row[2];
}

//gender chart
function maleChart()
{
    global $conn;
    $sql = "SELECT COUNT(UID) FROM `tbl_trainee` WHERE `gender` = 'male'";
    $result = mysqli_query($conn, $sql);

    if (mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_row($result);
        return $row[0];
    }
}

function femaleChart()
{
    global $conn;
    $sql = "SELECT COUNT(UID) FROM `tbl_trainee` WHERE `gender` = 'female'";
    $result = mysqli_query($conn, $sql);

    if (mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_row($result);
        return $row[0];
    }
}

function MonthlyChart($month)
{
    global $conn;
    $sql = "SELECT COUNT(UID) FROM tbl_trainee WHERE MONTH(account_Created) = $month";
    $result = mysqli_query($conn, $sql);

    if (mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_row($result);
        return $row[0];
    }
}

?>
<!DOCTYPE html>
<html lang="en, fil">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="../Style/ImportantImport.css">
    <script src="../Script/SidebarScript.js"></script>
    <script src="../Script/SweetAlert2.js"></script>
    <script src="../Script/chart.js"></script>
    <script src="../Script/AdminTables.js"></script>
    <title>Admin Dashboard</title>
</head>

<body class="dark adminuser" style="min-width: 1080px;">
    <?php
    @include_once '../Components/AdminSidebar.php';
    if (isset($ShowAlert)) {
        echo NewAlertBox();
        $_SESSION['Show'] = false;
    }
    ?>
    <section class="home">
        <div class="text">
            <h1 class="text-warning">Dashboard</h1>
        </div>
        <div class="container-fluid" style="width: 98%;">
            <div class="row row-cols-1 row-cols-md-4 g-4">
                <div class="col">
                    <div class="card h-100 text-bg-dark">
                        <div class="card-body">
                            <h5 class="card-title text-uppercase d-block text-truncate">Total Trainee's</h5>
                            <h1 class="card-text text-center fw-bold text-warning">
                                <?php echo $TotalTrainee; ?>
                            </h1>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 text-bg-dark">
                        <div class="card-body">
                            <h5 class="card-title text-uppercase d-block text-truncate">Deployed</h5>
                            <h1 class="card-text text-center fw-bold text-warning">
                                <?php echo $Deployed; ?>
                            </h1>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 text-bg-dark">
                        <div class="card-body">
                            <h5 class="card-title text-uppercase d-block text-truncate">Completed</h5>
                            <h1 class="card-text text-center fw-bold text-warning">
                                <?php echo $Completed; ?>
                            </h1>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 text-bg-dark">
                        <div class="card-body">
                            <h5 class="card-title text-uppercase d-block text-truncate">Total Program</h5>
                            <h1 class="card-text text-center fw-bold text-warning">100</h1>
                        </div>
                    </div>
                </div>
            </div>
            <br>
            <div class="row row-cols-1 row-cols-md-2 g-4">
                <div class="col">
                    <div class="card text-bg-dark" style="min-width: 380px;">
                        <div class="card-body">
                            <h5 class="card-title text-uppercase d-block text-truncate">Gender</h5>
                            <canvas id="gender"></canvas>
                            <?php include_once '../Components/Chart/GenderChart.php'; ?>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card text-bg-dark" style="min-width: 380px;">
                        <div class="card-body">
                            <h5 class="card-title text-uppercase d-block text-truncate">Monthly Registered Trainee's
                            </h5>
                            <canvas id="Monthly"></canvas>
                            <?php @include_once '../Components/Chart/MonthlyChart.php';
                            ?>
                        </div>
                    </div>
                </div>
            </div>

            <hr class="mt-4 mb-4" style="background-color: white; height: 5px; border-radius: 5px;">

            <div class="container-fluid table-responsive-md">
                <table class="table table-dark table-striped table-hover caption-top" id="Trainee-Table">
                    <caption style="min-width: 600px;">
                        <nav class="navbar navbar-dark navbar-expand-lg bg-body-tertiary">
                            <div class="container-fluid">
                                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#TraineeTable" aria-controls="TraineeTable" aria-expanded="false"
                                    aria-label="Toggle navigation">
                                    <span class="navbar-toggler-icon"></span>
                                </button>
                                <div class="collapse navbar-collapse" id="TraineeTable">
                                    <div class="container-fluid">
                                        <a class="navbar-brand text-light text-muted">Trainee list
                                        </a>
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <div>
                                                    <div class="input-group mb-3">
                                                        <input type="search" id="TL" class="form-control text-bg-dark"
                                                            placeholder="Filter by Name Only">
                                                        <a href="#" class="btn btn-outline-primary">Show more</a>
                                                    </div>
                                                </div>
                                            </div>
                                            <nav class="ms-3 mt-1">
                                                <ul class="pagination pagination-sm">
                                                    <li class="page-item">
                                                        <a class="page-link text-bg-dark"
                                                            aria-label="Previous" id="previousPage">
                                                            <span aria-hidden="true">&laquo;</span>
                                                        </a>
                                                    </li>
                                                    <li class="page-item">
                                                        <a class="page-link text-bg-dark" id="nextPage" aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </nav>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </nav>
                    </caption>
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Name</th>
                            <th scope="col">Department</th>
                            <th scope="col">Program</th>
                            <th scope="col">Status</th>
                        </tr>
                    </thead>
                    <tbody class="table-group-divider">
                        <tr>
                            <th scope="row">1</th>
                            <td>Lorenzo Asis</td>
                            <td>BSIT</td>
                            <td>Web Development</td>
                            <td><span class="badge text-bg-danger">Pending</span></td>
                        </tr>
                        <tr>
                            <th scope="row">2</th>
                            <td>Mark Otto</td>
                            <td>BSCS</td>
                            <td>IT Support</td>
                            <td><span class="badge text-bg-warning">On-Going</span></td>
                        </tr>
                        <tr>
                            <th scope="row">3</th>
                            <td>Thomas Aquinas</td>
                            <td>BSIT</td>
                            <td>Web Development</td>
                            <td><span class="badge text-bg-success">Completed</span></td>
                        </tr>
                        <tr>
                            <th scope="row">4</th>
                            <td>Thomas Aquinas</td>
                            <td>BSIT</td>
                            <td>Web Development</td>
                            <td><span class="badge text-bg-success">Completed</span></td>
                        </tr>
                        <tr>
                            <th scope="row">5</th>
                            <td>Thomas Aquinas</td>
                            <td>BSIT</td>
                            <td>Web Development</td>
                            <td><span class="badge text-bg-success">Completed</span></td>
                        </tr>
                        <tr>
                            <th scope="row">6</th>
                            <td>Thomas Aquinas</td>
                            <td>BSIT</td>
                            <td>Web Development</td>
                            <td><span class="badge text-bg-success">Completed</span></td>
                        </tr>
                        <tr>
                            <th scope="row">7</th>
                            <td>Lorenzo Asis</td>
                            <td>BSIT</td>
                            <td>Web Development</td>
                            <td><span class="badge text-bg-danger">Pending</span></td>
                        </tr>
                        <tr>
                            <th scope="row">8</th>
                            <td>Mark Otto</td>
                            <td>BSCS</td>
                            <td>IT Support</td>
                            <td><span class="badge text-bg-warning">On-Going</span></td>
                        </tr>
                        <tr>
                            <th scope="row">9</th>
                            <td>Thomas Aquinas</td>
                            <td>BSIT</td>
                            <td>Web Development</td>
                            <td><span class="badge text-bg-success">Completed</span></td>
                        </tr>
                        <tr>
                            <th scope="row">10</th>
                            <td>Thomas Aquinas</td>
                            <td>BSIT</td>
                            <td>Web Development</td>
                            <td><span class="badge text-bg-success">Completed</span></td>
                        </tr>
                        <tr>
                            <th scope="row">11</th>
                            <td>Thomas Aquinas</td>
                            <td>BSIT</td>
                            <td>Web Development</td>
                            <td><span class="badge text-bg-success">Completed</span></td>
                        </tr>
                        <tr>
                            <th scope="row">12</th>
                            <td>Thomas Aquinas</td>
                            <td>BSIT</td>
                            <td>Web Development</td>
                            <td><span class="badge text-bg-success">Completed</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <hr class="mt-4 mb-4" style="background-color: white; height: 5px; border-radius: 5px;">

            <div class="container-fluid table-responsive-md">
                <table class="table table-dark table-striped table-hover caption-top">
                    <caption style="min-width: 600px;">
                        <nav class="navbar navbar-dark navbar-expand-lg bg-body-tertiary">
                            <div class="container-fluid">
                                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#ProgramTable" aria-controls="ProgramTable" aria-expanded="false"
                                    aria-label="Toggle navigation">
                                    <span class="navbar-toggler-icon"></span>
                                </button>
                                <div class="collapse navbar-collapse" id="ProgramTable">
                                    <div class="container-fluid">
                                        <a class="navbar-brand text-light text-muted">Program list</a>
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <div>
                                                    <div class="input-group mb-3">
                                                        <input type="search" id="PL" class="form-control text-bg-dark"
                                                            placeholder="Filter">
                                                        <a href="#" class="btn btn-outline-primary">Show more</a>
                                                    </div>
                                                </div>
                                            </div>
                                            <nav class="ms-3 mt-1">
                                                <ul class="pagination pagination-sm">
                                                    <li class="page-item">
                                                        <a class="page-link text-bg-dark" href="#"
                                                            aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                        </a>
                                                    </li>
                                                    <li class="page-item"><a class="page-link text-bg-dark"
                                                            href="#">1</a></li>
                                                    <li class="page-item"><a class="page-link text-bg-dark"
                                                            href="#">2</a></li>
                                                    <li class="page-item"><a class="page-link text-bg-dark"
                                                            href="#">3</a></li>
                                                    <li class="page-item">
                                                        <a class="page-link text-bg-dark" href="#" aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </nav>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </nav>
                    </caption>
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Program Name</th>
                            <th scope="col">Department</th>
                            <th scope="col">Applied</th>
                            <th scope="col">Slots</th>
                            <th scope="col">Status</th>
                        </tr>
                    </thead>
                    <tbody class="table-group-divider">
                        <tr>
                            <th scope="row">1</th>
                            <td>Web Development</td>
                            <td>BSIT</td>
                            <td>100</td>
                            <td>100</td>
                            <td><span class="badge text-bg-danger">Full</span></td>

                        </tr>
                        <tr>
                            <th scope="row">2</th>
                            <td>IT Support</td>
                            <td>BSCS</td>
                            <td>100</td>
                            <td>50</td>
                            <td><span class="badge text-bg-success">Active</span></td>
                        </tr>
                        <tr>
                            <th scope="row">3</th>
                            <td>Graphic Design</td>
                            <td>BSCS</td>
                            <td>100</td>
                            <td>50</td>
                            <td><span class="badge text-bg-success">Active</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <hr class="mt-4 mb-4" style="background-color: white; height: 5px; border-radius: 5px;">

            <div class="container-fluid table-responsive-md">
                <table class="table table-dark table-striped table-hover caption-top">
                    <caption style="min-width: 600px;">
                        <nav class="navbar navbar-dark navbar-expand-lg bg-body-tertiary">
                            <div class="container-fluid">
                                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#EventTable" aria-controls="EventTable" aria-expanded="false"
                                    aria-label="Toggle navigation">
                                    <span class="navbar-toggler-icon"></span>
                                </button>
                                <div class="collapse navbar-collapse" id="EventTable">
                                    <div class="container-fluid">
                                        <a class="navbar-brand text-light text-muted">Event list</a>
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <div>
                                                    <div class="input-group mb-3">
                                                        <input type="search" id="EL" class="form-control text-bg-dark"
                                                            placeholder="Filter">
                                                        <a href="#" class="btn btn-outline-primary">Show more</a>
                                                    </div>
                                                </div>
                                            </div>
                                            <nav class="ms-3 mt-1">
                                                <ul class="pagination pagination-sm">
                                                    <li class="page-item">
                                                        <a class="page-link text-bg-dark" href="#"
                                                            aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                        </a>
                                                    </li>
                                                    <li class="page-item"><a class="page-link text-bg-dark"
                                                            href="#">1</a></li>
                                                    <li class="page-item"><a class="page-link text-bg-dark"
                                                            href="#">2</a></li>
                                                    <li class="page-item"><a class="page-link text-bg-dark"
                                                            href="#">3</a></li>
                                                    <li class="page-item"><a class="page-link text-bg-dark"
                                                            href="#">4</a></li>
                                                    <li class="page-item"><a class="page-link text-bg-dark"
                                                            href="#">5</a></li>
                                                    <li class="page-item">
                                                        <a class="page-link text-bg-dark" href="#" aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </nav>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </nav>
                    </caption>
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Event Name</th>
                            <th scope="col">Date</th>
                            <th scope="col">Type</th>
                            <th scope="col">Status</th>
                        </tr>
                    </thead>
                    <tbody class="table-group-divider">
                        <tr>
                            <th scope="row">1</th>
                            <td>Web Development</td>
                            <td>January 1, 2021</td>
                            <td>Seminars</td>
                            <td><span class="badge text-bg-warning">Pending</span></td>
                        </tr>
                        <tr>
                            <th scope="row">2</th>
                            <td>IT Support</td>
                            <td>January 1, 2021</td>
                            <td>Workshop</td>
                            <td><span class="badge text-bg-success">Completed</span></td>
                        </tr>
                        <tr>
                            <th scope="row">3</th>
                            <td>Graphic Design</td>
                            <td>January 1, 2021</td>
                            <td>Webinar</td>
                            <td><span class="badge text-bg-success">Completed</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <hr class="mt-4 mb-4" style="background-color: white; height: 5px; border-radius: 5px;">

    </section>
    <script src="../Script/Bootstrap_Script/bootstrap.js"></script>
</body>

</html>