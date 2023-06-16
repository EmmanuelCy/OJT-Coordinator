<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../Style/ImportantImport.css">
    <title>Evaluation</title>
</head>

<body>
    <?php include_once '../Components/Sidebar.php'; ?>
    <section class="home">
        <div class="text">Evaluation</div>
        <div class="content d-flex justify-content-center" style="margin: 10px; width: 98%;">
            <?php
            !isset($_GET['id']) ? include_once '../Components/EvaluateData.php' : $stat = "Not Evaluated Yet";
            if (isset($stat)){
                echo $stat;
            }
            ?>
        </div>
    </section>
    <script src="../Script/SidebarScript.js"></script>
    <script src="../Script/Bootstrap_Script/bootstrap.bundle.js
</body>

</html>