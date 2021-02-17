<?php


session_start();

$server = "localhost";
$database = "ToiletPaper";
$usernameDB = "root";
$passwordDB = "";
$email = $_POST['email'];
$password = $_POST['email'] . $_POST['password'] . $_POST['email'];
 
if (isset($email) AND isset($password))
{
   try
   {
      $connection = new PDO("mysql:host=$server;dbname=$database", $usernameDB, $passwordDB);
      $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

      error_log("\nSuccessfully connected to database. (" . $email . ")", 3, "./log/log.log");

      $selectMember = $connection->prepare("SELECT * FROM ToiletPaper.Member WHERE eMail = :eMail");

      $selectMember->execute(array('eMail' => $email));

      if (!empty($row))
      {
         while($row = $selectMember->fetch())
         {
            if (password_verify($password, $row['Password']))
            {
               $picture = "./files/" . $email . ".png";
   
               $_SESSION['picture'] = $picture;
               $_SESSION['email'] = $email;
               header("location: http://localhost/index.php");
            }
            else
            {
               header("location: http://localhost/login.php");
            }
         }
      }
      else
      {
         header("location: http://localhost/login.php");
      }
   }
   catch (PDOException $e)
   {
      echo "An errror occured: " . $e->getMessage();
      error_log("\nAn errror occured: " . $e->getMessage(), 3, "./log/log.log");
   }
   finally
   {
      $connection = null;
   }
}

?>
