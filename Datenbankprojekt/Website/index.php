

<?php
    require_once('./templates/config.php');

    $connectionString = "mysql:host=" . Config::$HOST . ";dbname=" . Config::$DB_NAME;

    try {
        $connection = new PDO($connectionString, Config::$USERNAME, Config::$PASSWORD);
        $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $dbTerms = $connection->query('SELECT * FROM group_datenbank');
        $nwTerms = $connection->query('SELECT * FROM group_netzwerktechnik');
        $ptTerms = $connection->query('SELECT * FROM group_programmiertechnik');
        $krTerms = $connection->query('SELECT * FROM group_kryptographie');
    } catch(PDOException $e){ }
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <?php include('./templates/includes.php') ?>
    <link rel="stylesheet" href="./resources/styles/terms.css">
    <title>IT-Begriffe</title>
</head>
<script>
    window.addEventListener('DOMContentLoaded', (event) => {
        document.getElementById("datenbank-tab-btn").click();
    });
    
    function openTab(evt, tabName) {
        evt.preventDefault();

        var i, tabcontent, tablinks;
        tabcontent = document.getElementsByClassName("tabcontent");
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }
        document.getElementById(tabName).style.display = "block";
        evt.currentTarget.className += " active";
    }

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
                <div class="heading">BEGRIFFE</div>
                <div id="group-box">
                    <div class="tab">
                        <button class="tablinks" id="datenbank-tab-btn" onclick="openTab(event, 'Datenbank')">Datenbank</button>
                        <button class="tablinks" id="netzwerktechnik-tab-btn" onclick="openTab(event, 'Netzwerktechnik')">Netzwerktechnik</button>
                        <button class="tablinks" id="programmiertechnik-tab-btn" onclick="openTab(event, 'Programmiertechnik')">Programmiertechnik</button>
                        <button class="tablinks" id="kryptographie-tab-btn" onclick="openTab(event, 'Kryptographie')">Kryptographie</button>
                    </div>

                    <div id="Datenbank" class="tabcontent">
                        <div class="term-container">
                            <?php foreach($dbTerms as $term) { ?>
                                <div class="term" onclick="openDescription('<?php echo $term['Description']; ?>')">
                                    <div class="name">
                                        <?php echo $term['Name']; ?>
                                    </div>
                                </div>
                            <?php } ?>
                        </div>
                    </div>

                    <div id="Netzwerktechnik" class="tabcontent">
                        <div class="term-container">
                            <?php foreach($nwTerms as $term) { ?>
                                <div class="term" onclick="openDescription('<?php echo $term['Description']; ?>')">
                                    <div class="name">
                                        <?php echo $term['Name']; ?>
                                    </div>
                                </div>
                            <?php } ?>
                        </div>
                    </div>

                    <div id="Programmiertechnik" class="tabcontent">
                        <div class="term-container">
                            <?php foreach($ptTerms as $term) { ?>
                                <div class="term" onclick="openDescription('<?php echo $term['Description']; ?>')">
                                    <div class="name">
                                        <?php echo $term['Name']; ?>
                                    </div>
                                </div>
                            <?php } ?>
                        </div>
                    </div>

                    <div id="Kryptographie" class="tabcontent">
                        <div class="term-container">
                            <?php foreach($krTerms as $term) { ?>
                                <div class="term" onclick="openDescription('<?php echo $term['Description']; ?>')">
                                    <div class="name">
                                        <?php echo $term['Name']; ?>
                                    </div>
                                </div>
                            <?php } ?>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <?php include('./templates/footer.php') ?>
    </div>
</body>
</html>