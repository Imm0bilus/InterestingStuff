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
        
            <article>
                <section class="productSection">
                    <img class="productPicture" src="./images/toiletpaper_big.png" alt="toilet paper image">
                    <img class="addToCart" src="./images/addToCart.png" alt="toilet paper image">
                    <p class="productText">NEW!<br>
                        Toilet paper "Soft"<br>
                        Layers: 4<br>
                        12-pack<br>
                        Cost: 6,99€<br>
                        -> Personalize now!<br>
                    </p>
                    </section>
                <section class="productSection">
                    <img class="productPicture" src="./images/toiletpaper_big.png" alt="toilet paper image">
                    <img class="addToCart" src="./images/addToCart.png" alt="toilet paper image">
                    <p class="productText">NEW!<br>
                        Toilet paper "Premium"<br>
                        Layers: 5<br>
                        12-pack<br>
                        Cost: 7,99€<br>
                        -> Personalize now!<br>
                    </p>
                </section>
                <section class="productSectionBottom">
                    <img class="productPicture" src="./images/toiletpaper_big.png" alt="toilet paper image">
                    <img class="addToCart" src="./images/addToCart.png" alt="toilet paper image">
                    <p class="productText">SALE!<br>
                        Toilet paper "Budget"<br>
                        Layers: 2<br>
                        16-pack<br>
                        Cost: 4,49€<br>
                        -> Personalize now!<br>
                    </p>
                </section>
            </article>
        
            <aside>
                <p>I'm a test of type "aside".</p>
            </aside>
        
            <footer>
                <p>Website made by <b>me</b>. E-Mail: <b>mail@mail.com</b>.</p>
            </footer>
        </div>
    </div>
</body>

</html>
