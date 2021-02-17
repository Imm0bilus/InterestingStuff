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


        if(!empty($password)) {
            $updateMember = $connection->prepare("UPDATE ToiletPaper.Member 
            SET eMail = :eMail, Password = :password
            WHERE eMail = :eMail");
            $updateMember->bindParam(':eMail', $eMail);
            $updateMember->bindParam(':password', $password);
        } else {
            $updateMember = $connection->prepare("UPDATE ToiletPaper.Member 
            SET eMail = :eMail
            WHERE eMail = :eMail");
            $updateMember->bindParam(':eMail', $eMail);
            $updateMember->bindParam(':password', $password); }
        $updateMember = $connection->prepare("UPDATE ToiletPaper.Member 
            SET eMail = :eMail, Password = :password
            WHERE eMail = :eMail");
            $updateMember->bindParam(':eMail', $eMail);
            $updateMember->bindParam(':password', $password);
        $updatePersonal = $connection->prepare("UPDATE ToiletPaper.PersonalInfo
            SET Salutation = :salutation, FirstName = :firstName, LastName = :lastName, Birthdate = :birthdate, PhoneNumber = :phoneNumber, eMail = :eMail
            WHERE eMail = :eMail");
            $updatePersonal->bindParam(':salutation', $salutation);
            $updatePersonal->bindParam(':firstName', $firstName);
            $updatePersonal->bindParam(':lastName', $lastName);
            $updatePersonal->bindParam(':birthdate', $birthdate);
            $updatePersonal->bindParam(':phoneNumber', $phoneNumber);
            $updatePersonal->bindParam(':eMail', $eMail);
        $updateAddress = $connection->prepare("UPDATE ToiletPaper.Address
            SET Street = :street, PostalCode = :postalCode, City = :city, State = :state, Country = :country, eMail = :eMail
            WHERE eMail = $eMail");
            $updateAddress->bindParam(':street', $street);
            $updateAddress->bindParam(':postalCode', $postalCode);
            $updateAddress->bindParam(':city', $city);
            $updateAddress->bindParam(':state', $state);
            $updateAddress->bindParam(':country', $country);
            $updateAddress->bindParam(':eMail', $eMail);

        $updateMember->execute();
        $updatePersonal->execute();
        $updateAddress->execute();
    }
    catch (PDOException $e)
    {
        echo "An errror occured: " . $e->getMessage();
        error_log("\nAn errror occured: " . $e->getMessage(), 3, "./log/log.log");
    }
    
    $connection = null;

    $_SESSION['email'] = $_POST['email'];
    header("location: http://localhost/index.php");
}

//upload file
if (!empty($_FILES))
{
    $ext = pathinfo($_FILES['uploadFile']['name'], PATHINFO_EXTENSION);
    
    if ($ext == "png" || $ext == "jpg")
    {
        $picture = "./files/" . $_POST['email'] . ".png";

        imagepng(imagecreatefromstring(file_get_contents($_FILES['uploadFile']['tmp_name'])), $picture);
        $_SESSION['picture'] = $picture;
        header("location: http://localhost/profile.php");
    }
}
else
{
    $_SESSION['picture'] = $_SESSION['picture'];
}

?>
