<?php


$server = "localhost";
$database = "ToiletPaper";
$usernameDB = "root";
$passwordDB = "";

if ($_POST['password'] == $_POST['repeatpw'])
{
    session_start();

    $_POST['password'] = password_hash($_POST['email'] . $_POST['password'] . $_POST['email'] , PASSWORD_BCRYPT);
    unset($_POST['repeatpw']);

    try
    {
        $connection = new PDO("mysql:host=$server;dbname=$database", $usernameDB, $passwordDB);
        $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        
        error_log("\nSuccessfully connected to database. (" . $_POST['email'] . ")", 3, "./log/log.log");

        $salutation = $_POST['salutation'];
        $firstName = $_POST['firstName'];
        $lastName = $_POST['lastName'];
        $birthdate = $_POST['birthdate'];
        $phoneNumber = $_POST['phoneNumber'];
        $eMail = $_POST['email'];
        $street = $_POST['street'];
        $postalCode = $_POST['zip'];
        $city = $_POST['city'];
        $state = $_POST['state'];
        $country = $_POST['country'];
        $password = $_POST['password'];

        $insertMember = $connection->prepare("INSERT INTO ToiletPaper.Member (eMail, Password)
            VALUES (:eMail, :password)");
            $insertMember->bindParam(':eMail', $eMail);
            $insertMember->bindParam(':password', $password);
        $insertPersonal = $connection->prepare("INSERT INTO ToiletPaper.PersonalInfo (Salutation, FirstName, LastName, Birthdate, PhoneNumber, eMail)
            VALUES (:salutation, :firstName, :lastName, :birthdate, :phoneNumber, :eMail)");
            $insertPersonal->bindParam(':salutation', $salutation);
            $insertPersonal->bindParam(':firstName', $firstName);
            $insertPersonal->bindParam(':lastName', $lastName);
            $insertPersonal->bindParam(':birthdate', $birthdate);
            $insertPersonal->bindParam(':phoneNumber', $phoneNumber);
            $insertPersonal->bindParam(':eMail', $eMail);
        $insertAddress = $connection->prepare("INSERT INTO ToiletPaper.Address (Street, PostalCode, City, State, Country, eMail)
            VALUES (:street, :postalCode, :city, :state, :country, :eMail)");
            $insertAddress->bindParam(':street', $street);
            $insertAddress->bindParam(':postalCode', $postalCode);
            $insertAddress->bindParam(':city', $city);
            $insertAddress->bindParam(':state', $state);
            $insertAddress->bindParam(':country', $country);
            $insertAddress->bindParam(':eMail', $eMail);

        $insertMember->execute();
        $insertPersonal->execute();
        $insertAddress->execute();
    }
    catch (PDOException $e)
    {
        echo "An errror occured: " . $e->getMessage();
        error_log("\nAn errror occured: " . $e->getMessage(), 3, "./log/log.log");
    }
    
    $connection = null;

    //upload file
    if (!empty($_FILES))
    {
        $ext = pathinfo($_FILES['uploadFile']['name'], PATHINFO_EXTENSION);
        
        if ($ext == "png" || $ext == "jpg")
        {
            $picture = "./files/" . $_POST['email'] . ".png";
            imagepng(imagecreatefromstring(file_get_contents($_FILES['uploadFile']['tmp_name'])), $picture);
        }
    }

    $_SESSION['email'] = $_POST['email'];
    $_SESSION['picture'] = $picture;
    header("location: http://localhost/index.php");
}

?>
