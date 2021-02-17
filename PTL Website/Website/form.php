<!DOCTYPE html>


<?php session_start(); ?>

<head>
    <meta charset="utf-8" />
    <title>Personalized Toilet Paper</title>
    <link rel="stylesheet" type="text/css" href="./css/index.css">
    <link rel="stylesheet" type="text/css" href="./css/form.css">
    <link rel="shortcut icon" type="image/x-icon" href="./images/toiletpaper.ico">
</head>

<body>
    <div id="page-container">
        <div id="footer-placeholder">
            <header>
                <img class="join" src="./images/becomeamember.png" alt="become a member" usemap="#join">
                <map name="join">
                    <area shape="rect" coords="125,0,170,40" alt="join" href="form.php">
                </map>

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
        
            <div>
                <form action="addUser.php" method="POST" enctype="multipart/form-data">
                    <div id="personalInformation">
                        <fieldset id="normal">
                            <legend>PERSONAL INFORMATION</legend>
    
                            <label id="labelForm" for="salutation">Salutation:</label>
                            <input type="radio" id="mr" name="salutation" value="Mr" required />
                            <label for="mr"> Mr</label>
                            <input type="radio" id="mrs" name="salutation" value="Mrs" required />
                            <label for="mrs"> Mrs</label>
                            <input type="radio" id="mx" name="salutation" value="Mx" required />
                            <label for="mx"> Mx</label>
    
                            <label id="labelForm" for="firstName">First name:</label>
                            <input type="text" id="firstName" name="firstName" autofocus placeholder="Please enter your first name..." required />
                    
                            <label id="labelForm" for="lastName">Last name:</label>
                            <input type="text" id="lastName" name="lastName" placeholder="Please enter your last name..." required />
    
                            <label id="labelForm" for="birthdate">Birthdate:</label>
                            <input type="date" id="birthdate" name="birthdate" required />
                    
                            <label id="labelForm" for="phoneNumber">Phone number:</label>
                            <input type="tel" id="phoneNumber" name="phoneNumber" placeholder="Please enter your phone number..." />
    
                            <label id="labelForm" for="email">E-Mail:</label>
                            <input type="email" id="email" name="email" title="mail@provider.countrycode" placeholder="Please enter your e-mail address..." required />
    
                            <label id="labelForm" for="password">Password:</label>
                            <input type="password" id="password" name="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
                            title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" placeholder="Please enter a password..." required />
    
                            <label id="labelForm" for="repeatpw">Repeat password:</label>
                            <input type="password" id="repeatpw" name="repeatpw" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
                            title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" placeholder="Please repeat your password..." required />
                        </fieldset>
                    </div>        
                    <div id="address">
                        <fieldset id="normal">
                            <legend>ADDRESS</legend>
                    
                            <label id="labelForm" for="street">Street:</label>
                            <input type="text" id="street" name="street" placeholder="Please enter the street..." required />
    
                            <label id="labelForm" for="zip">Postal code:</label>
                            <input type="text" id="zip" name="zip" pattern="\d{4}" title="Must contain at least 4 numbers, and a maximum of 5 numbers" placeholder="Please enter the postal code..." required />
    
                            <label id="labelForm" for="city">City:</label>
                            <input type="text" id="city" name="city" placeholder="Please enter the city..." required />
    
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
                            <input type="text" id="country" name="country" placeholder="Please enter the country..." required />
                        </fieldset>
                    </div>
                    <div id="upload">
                        <fieldset id="fieldsetUpload">
                            <legend>UPLOAD A FILE</legend>
                    
                            <label id="labelForm" for="uploadFile">Select a file to upload:</label>
                            <input type="file" id="uploadFile" name="uploadFile" accept="image/*" />
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
                    
            <footer>
                <p>Website made by <b>me</b>. E-Mail: <b>mail@mail.com</b>.</p>
            </footer>
        </div>
    </div>
</body>

</html>
