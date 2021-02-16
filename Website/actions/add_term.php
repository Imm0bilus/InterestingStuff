<!--

@file: Add new term
@author: Jürgen Hechenberger
@date: 2020/11/08
@version: 1.0.0

-->

<?php
    require_once('../templates/config.php');

    $connectionString = "mysql:host=" . Config::$HOST . ";dbname=" . Config::$DB_NAME;

    print_r($_POST);

    if(isset($_POST['add'])) {

        try {
            $connection = new PDO($connectionString, Config::$USERNAME, Config::$PASSWORD);
            $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            $stmt = $connection->prepare("CALL AddNewTerm(:term,:description,:group)");

            $term = $_POST['term'];
            $description = $_POST['description'];
            $group = $_POST['group'];

            $stmt->bindParam(':term', $term);
            $stmt->bindParam(':description', $description);
            $stmt->bindParam(':group', $group);

            $stmt->execute();

        } catch(PDOException $e) {

            echo "An errror occured: " . $e->getMessage();
        }

        header("Location: ../add.php");
        exit();
    }
?>
