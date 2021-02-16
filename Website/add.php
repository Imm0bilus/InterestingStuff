<!--

@file: Add page
@author: Jürgen Hechenberger
@date: 2020/11/08
@version: 1.0.0

-->

<?php
    require_once('./templates/config.php');

    $connectionString = "mysql:host=" . Config::$HOST . ";dbname=" . Config::$DB_NAME;

    try {
        $connection = new PDO($connectionString, Config::$USERNAME, Config::$PASSWORD);
        $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $groups = $connection->query('SELECT * FROM groups');
    } catch(PDOException $e){ }
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <?php include('./templates/includes.php') ?>
    <link rel="stylesheet" href="./resources/styles/terms.css">
    <link rel="stylesheet" href="./resources/styles/add.css">
    <title>IT-Begriffe</title>
</head>
<body>
    <div id="main">
        <?php include('./templates/header.php') ?>
        <div id="content">
            <div class="container">
                <div class="heading">BEGRIFF HINZUFÜGEN</div>
                <div id="group-box">
                
                    <form action="./actions/add_term.php" method="POST" enctype="multipart/form-data">
                        <div class="form-container">        
                            <label id="form-label" for="term">Begriff:</label>
                            <input type="text" id="term" name="term" maxlength="50" autofocus placeholder="Begriff..." required />
                    
                            <label id="form-label" for="description">Beschreibung:</label>
                            <textarea type="text" id="description" name="description" maxlength="800" placeholder="Beschreibung..." required></textarea>
            
                            <label id="form-label" for="group">Kategorie:</label>
                            <select id="group" name="group" required>
                                <option value="-1" selected>-</option>
                                <?php foreach($groups as $group): ?>
                                    <option value="<?= $group['ID']; ?>"><?= $group['Name']; ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>

                        <script type="text/javascript">
                            function Validate() {
                                var group = document.getElementById("group");
                                    if (group.value == "-1")
                                    {
                                        alert("Bitte Kategorie wählen!");
                                        return false;
                                    }
                                return true;
                            }
                        </script>

                        <div id="AddResetContainer">
                            <div id="AddReset">
                                <div class="reset">
                                    <input type="reset" id="reset" name="reset" value="Zurücksetzen" />
                                </div>
                                <div class="add">
                                    <input type="submit" id="add" name="add" value="Hinzufügen" onclick="return Validate()" />
                                </div>
                            </div>
                        </div>
                    </form>

                </div>
            </div>
        </div>
        <?php include('./templates/footer.php') ?>
    </div>
</body>
</html>