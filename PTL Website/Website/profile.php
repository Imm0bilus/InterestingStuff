<!DOCTYPE html>


<?php

session_start();

$server = "localhost";
$database = "ToiletPaper";
$usernameDB = "root";
$passwordDB = "";
$email = $_SESSION['email'];

if (isset($_SESSION['email']))
{
    try
    {
        $connection = new PDO("mysql:host=$server;dbname=$database", $usernameDB, $passwordDB);
        $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        error_log("\nSuccessfully connected to database. (" . $email . ")", 3, "./log/log.log");

        $profile = $connection->prepare("SELECT p.eMail, p.Salutation, p.FirstName, p.LastName, p.Birthdate, p.PhoneNumber, a.Street, a.PostalCode, a.City, a.State, a.Country 
            FROM ToiletPaper.PersonalInfo p INNER JOIN ToiletPaper.Address a ON a.eMail = p.eMail WHERE p.eMail = :eMail");

        $profile->bindParam(':eMail', $email);
        $profile->execute(array('eMail' => $email));

        $profileInfo = $profile->fetch();

        $eMailDB = $profileInfo['eMail'];
        $salutation = $profileInfo['Salutation'];
        $firstName = $profileInfo['FirstName'];
        $lastName = $profileInfo['LastName'];
        $birthdate = $profileInfo['Birthdate'];
        $phoneNumber = $profileInfo['PhoneNumber'];
        $street = $profileInfo['Street'];
        $postalCode = $profileInfo['PostalCode'];
        $city = $profileInfo['City'];
        $state = $profileInfo['State'];
        $country = $profileInfo['Country'];

        $picture = "./files/" . $email . ".png";

        $_SESSION['picture'] = $picture;
        $_SESSION['email'] = $email;

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

<head>
    <meta charset="utf-8" />
    <title>Personalized Toilet Paper</title>
    <link rel="stylesheet" type="text/css" href="./css/index.css">
    <link rel="stylesheet" type="text/css" href="./css/form.css">
    <link rel="stylesheet" type="text/css" href="./css/profile.css">
    <link rel="shortcut icon" type="image/x-icon" href="./images/toiletpaper.ico">
</head>

<body>
    <div id="page-container">
        <div id="footer-placeholder">
            <header>

                <?php if(!isset($_SESSION['email'])) : ?>
                    <img class="join" src="./images/becomeamember.png" alt="become a member" usemap="#join">
                    <map name="join">
                        <area shape="rect" coords="125,0,170,40" alt="join" href="form.php">
                    </map>
                <?php else : ?>
                    <img class="profile" src="<?= $_SESSION['picture']; ?>" alt="profile" usemap="#profile">                    
                    <map name="profile">
                        <area shape="rect" coords="1,1,150,80px" alt="profile" href="profile.php">
                    </map>
                <?php endif; ?>
                
                <img class="logo" src="./images/toiletpaper.png" alt="logo">
                <h1>TOILET.PAPER</h1>
                <p id="slogan">THE BEST WAY TO GET RID OF SUPERFLUOUS MONEY.</p>
            </header>
        
            <nav>
                <ul>
                    <li><a class="ref" href="index.php">HOME</a></li>
                    <li><a class="ref" href="index.php">PRODUCTS</a></li>
                    <li><a class="ref" href="index.php">ABOUT US</a></li>
                    <li><?php if(!isset($_SESSION['email'])) : ?>
                        <a href="login.php">LOGIN</a>
                    <?php else : ?>
                        <a href="logoutUser.php">LOGOUT</a>
                    <?php endif; ?></a></li>
                </ul>
            </nav>
        
            <?php if(!(isset($_GET['edit']) && $_GET['edit'])) : ?>
                <div id="personalInformation">
                    <fieldset id="normal">
                        <legend>PERSONAL INFORMATION</legend>

                        <label id="labelProfile" for="salutation">Salutation:</label>
                        <label id="labelProfileValue" for="salutation"><?= $salutation ?></label>

                        <label id="labelProfile" for="firstName">First name:</label>
                        <label id="labelProfileValue" for="salutation"><?= $firstName ?></label>
                
                        <label id="labelProfile" for="lastName">Last name:</label>
                        <label id="labelProfileValue" for="salutation"><?= $lastName ?></label>

                        <label id="labelProfile" for="birthdate">Birthdate:</label>
                        <label id="labelProfileValue" for="salutation"><?= $birthdate ?></label>
                
                        <label id="labelProfile" for="phoneNumber">Phone number:</label>
                        <label id="labelProfileValue" for="salutation"><?= $phoneNumber ?></label>

                        <label id="labelProfile" for="email">E-Mail:</label>
                        <label id="labelProfileValue" for="salutation"><?= $email ?></label>
                    </fieldset>
                </div>        
                <div id="address">
                    <fieldset id="normal">
                        <legend>ADDRESS</legend>
                
                        <label id="labelProfile" for="street">Street:</label>
                        <label id="labelProfileValue" for="salutation"><?= $street ?></label>

                        <label id="labelProfile" for="zip">Postal code:</label>
                        <label id="labelProfileValue" for="salutation"><?= $postalCode ?></label>

                        <label id="labelProfile" for="city">City:</label>
                        <label id="labelProfileValue" for="salutation"><?= $city ?></label>

                        <label id="labelProfile" for="state">State:</label>
                        <label id="labelProfileValue" for="salutation"><?= $state ?></label>
                        
                        <label id="labelProfile" for="country">Country:</label>
                        <label id="labelProfileValue" for="salutation"><?= $country ?></label>
                    </fieldset>
                </div>
                <div id="change">
                    <div id="changeID">
                        <?php if(!(isset($_GET['edit']) && $_GET['edit'])) : ?>
                            <input type="button" value="EDIT PROFILE" onClick="window.location.href = './profile.php?edit=true'">
                        <?php endif; ?>
                    </div>
                </div>
            <?php else : ?>
                <div>
                    <form action="updateUser.php" method="POST" enctype="multipart/form-data">
                        <div id="personalInformation">
                            <fieldset id="normal">
                                <legend>PERSONAL INFORMATION</legend>
        
                                <label id="labelForm" for="salutation">Salutation:</label>
                                <input type="radio" id="mr" name="salutation" value="Mr"
                                    <?php if($salutation == "Mr") : ?>
                                        checked <?php endif; ?> required />
                                <label for="mr"> Mr</label>
                                <input type="radio" id="mrs" name="salutation" value="Mrs"
                                    <?php if($salutation == "Mrs") : ?>
                                        checked <?php endif; ?> required />
                                <label for="mrs"> Mrs</label>
                                <input type="radio" id="mx" name="salutation" value="Mx"
                                    <?php if($salutation == "Mx") : ?>
                                        checked <?php endif; ?> required />
                                <label for="mx"> Mx</label>
        
                                <label id="labelForm" for="firstName">First name:</label>
                                <input type="text" id="firstName" name="firstName" autofocus value="<?= $firstName ?>" required />
                        
                                <label id="labelForm" for="lastName">Last name:</label>
                                <input type="text" id="lastName" name="lastName" value="<?= $lastName ?>" required />
        
                                <label id="labelForm" for="birthdate">Birthdate:</label>
                                <input type="date" id="birthdate" name="birthdate" value="<?= $birthdate ?>" required />
                        
                                <label id="labelForm" for="phoneNumber">Phone number:</label>
                                <input type="tel" id="phoneNumber" name="phoneNumber" value="<?= $phoneNumber ?>" />
        
                                <label id="labelForm" for="email">E-Mail:</label>
                                <input type="email" id="email" name="email" title="mail@provider.countrycode" value="<?= $eMailDB ?>" required />
        
                                <label id="labelForm" for="password">Password:</label>
                                <input type="password" id="password" name="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
                                title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" placeholder="Please enter a new password..." />
        
                                <label id="labelForm" for="repeatpw">Repeat password:</label>
                                <input type="password" id="repeatpw" name="repeatpw" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
                                title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" placeholder="Please confirm your new password..." />
                            </fieldset>
                        </div>        
                        <div id="address">
                            <fieldset id="normal">
                                <legend>ADDRESS</legend>
                        
                                <label id="labelForm" for="street">Street:</label>
                                <input type="text" id="street" name="street" value="<?= $street ?>" required />
        
                                <label id="labelForm" for="zip">Postal code:</label>
                                <input type="text" id="zip" name="zip" pattern="\d{4}" title="Must contain at least 4 numbers, and a maximum of 5 numbers" value="<?= $postalCode ?>" required />
        
                                <label id="labelForm" for="city">City:</label>
                                <input type="text" id="city" name="city" value="<?= $city ?>" required />
        
                                <label id="labelForm" for="state">State:</label>
                                <select id="state" name="state" required>
                                    <option value="Burgenland">Burgenland</option>
                                    <option value="Kärnten">Kärnten</option>
                                    <option value="Niederösterreich">Niederösterreich</option>
                                    <option value="Oberösterreich">Oberösterreich</option>
                                    <option value="Salzburg">Salzburg</option>
                                    <option value="Steiermark">Steiermark</option>
                                    <option value="Tirol">Tirol</option>
                                    <option value="Vorarlberg">Vorarlberg</option>
                                    <option value="Wien">Wien</option>
                                </select>
                                
                                <label id="labelForm" for="country">Country:</label>
                                <input type="text" id="country" name="country" value="<?= $country ?>" required />
                            </fieldset>
                        </div>
                        <div id="upload">
                            <fieldset id="fieldsetUpload">
                                <legend>UPLOAD A FILE</legend>
                        
                                <label id="labelForm" for="uploadFile">Select a file to upload:</label>
                                <input type="file" id="uploadFile" name="uploadFile" />
                            </fieldset>
                        </div>
                        <div id="submitReset">
                            <div id="divReset">
                                <input type="reset" id="reset" name="reset" value="Reset" />
                            </div>
                            <div id="divSubmit">
                                <input type="submit" id="submit" name="submit" value="Submit" />
                            </div>
                        </div>
                    </form>
                </div>
            <?php endif; ?>
            
            <footer>
                <p>Website made by <b>me</b>. E-Mail: <b>mail@mail.com</b>.</p>
            </footer>
        </div>
    </div>
</body>

</html>
