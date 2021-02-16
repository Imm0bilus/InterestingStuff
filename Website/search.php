<!--

@file: Search page
@author: Jonas E. (& Jürgen Hechenberger)
@date: 2020/11/08
@version: 1.0.0

-->

<?php
    require_once('./templates/config.php');

    $searchTerms = null;

    if(isset($_POST['submit']) && isset($_POST['search'])){
        $connectionString = "mysql:host=" . Config::$HOST . ";dbname=" . Config::$DB_NAME;

        try {
            $connection = new PDO($connectionString, Config::$USERNAME, Config::$PASSWORD);
            $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $searchTerms = $connection->query('SELECT * FROM terms WHERE Name LIKE \'%' . $_POST["search"] . '%\'');
        } catch(PDOException $e){ }
    }

?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <?php include('./templates/includes.php') ?>
    <link rel="stylesheet" href="./resources/styles/search.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>IT-Begriffe</title>
</head>
<script>
    function openDescription(desc){
        overlayOn(desc);
    }

    function overlayOn(desc) {
        document.getElementById("overlay").style.display = "block";
        document.getElementById("text").innerHTML = desc;
    }
    function overlayOff() {
        document.getElementById("overlay").style.display = "none";
    }
</script>
<body>

    <div id="overlay">
        <div id="text"></div>
        <div id="close" onclick="overlayOff()"></div>
        <div id="closeText" onclick="overlayOff()">Zum Schließen bitte im unteren Bereich klicken.</div>
    </div>

    <div id="main">
        <?php include('./templates/header.php') ?>
        <div id="content">
            <div class="container">
                <div class="heading">SUCHE</div>
                <div class="search-container">
                    <form action="search.php" method="POST">
                        <input type="text" autofocus placeholder="Suche..." name="search">
                        <button type="submit" name="submit"><i class="fa fa-search"></i></button>
                    </form>
                </div>
                <div class="term-container">
                    <?php if($searchTerms != null) : ?>
                        <?php foreach($searchTerms as $term) { ?>
                            <div class="term" onclick="openDescription('<?php echo $term['Description']; ?>')">
                                <div class="name">
                                    <?php echo $term['Name']; ?>
                                </div>
                            </div>
                        <?php } ?>
                    <?php endif; ?>
                </div>
            </div>
        </div>
        <?php include('./templates/footer.php') ?>
    </div>
</body>
</html>