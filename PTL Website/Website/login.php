<!DOCTYPE html>


<?php session_start(); ?>

<head>
    <meta charset="utf-8" />
    <title>Personalized Toilet Paper</title>
    <link rel="stylesheet" type="text/css" href="./css/index.css">
    <link rel="stylesheet" type="text/css" href="./css/login.css">
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
                <form action="loginUser.php" method="POST">
                    <div id="login">
                        <fieldset id="normal">
                            <legend>LOGIN</legend>
        
                            <label id="labelForm" for="email">E-Mail:</label>
                            <input type="email" id="email" name="email" title="mail@something.countrycode" placeholder="Please enter your e-mail address..." required />
    
                            <label id="labelForm" for="password">Password:</label>
                            <input type="password" id="password" name="password"
                            title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" placeholder="Please enter a password..." required />
                        </fieldset>
                    </div>
                    <div id="loginReset">
                        <div id="divReset">
                            <input type="reset" id="reset" name="reset" value="Reset" />
                        </div>
                        <div id="divLogin">
                            <input type="submit" id="loginBtn" name="loginBtn" value="Login" />
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
