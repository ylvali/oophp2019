<?php
/*
* Guess-spelets bas
* Ylvali 2019
*
*
*/

// Include performance files
include(__DIR__ . "/config.php");
include(__DIR__ . "/autoloader.php");


// The guess object is initiated, if it is not existant in the session already.
// If not existant from before:  The guess object is saved in the session.
if (!isset($_SESSION["theGame"])) {
    // Initiate object
    $guessGame = new Guess();

    // Save in session
    $_SESSION["theGame"] = serialize($guessGame);
}

// Place the object in an accesible variable
$guessGame = unserialize($_SESSION["theGame"]);

// If user has pushed 'cheat' - show the cheat nr
$cheat = "";
if (isset($_GET['cheat'])) {
    $cheat = " The correct nr is: ".$guessGame->getCorrectNr()."</br>";
}

// The status of the object shows if there are more guesses or not
$moreGuesses = $guessGame->isActive();


// If there are more guesses and still not the correct answer,
// continue to take guesses from the player
if ($moreGuesses) {
    // Display the form
    $forUser = "<form method='post' action='getNr.php'>
              Nr: <input type='number' name='theGuess' class='inputF'><br>
              <input type='submit' class='button1' value='guess'>
              </form>";
} else {
    $corrNr = $guessGame->getCorrectNr();
    // Check if there is a winner
    if ($guessGame->isWinner()) {
        $forUser = "<h2> You won! </h2>";
        $forUser .= "The correct number was ".$corrNr."</br>";
    } else {
        $forUser = "<h2> No more guesses! </h2> <br/>";
        $forUser .= "The correct number was ".$corrNr."</br>";
    }
}

// The result is displayed for the user
// If there are no more guesses the score will be displayed
// If there are more guesses then the form will be available

?>


<!doctype html>
<html lang="sv">
<head>
    <meta charset="utf-8">
    <title>Ylvas me-plats</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel='shortcut icon' href='img/cellyPic.png'/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.0,">
</head>

<html>
<body>

<h1> Guess-game </h1>
<p> Gissa ett nr emellan 1 - 100 </p>

<?php
echo $forUser;
echo $guessGame->showMessage();
?>
<br/>
<p> <?php echo $guessGame->getGuess()?> </p>
<p> <?php echo $cheat ?> </p>

<br/>
<br/>

<form method='post' action='destroy_session.php'>
<input type='submit' class='button1' value='New game'>
</form>

<form method='get' action=''>
<input type='submit' class='button1' name='cheat' value='cheat'>
</form>

</body>
</html>
