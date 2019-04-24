<?php
/*
* Catch the incoming params form the form & inject guess object
*
*/
// Include performance files
include(__DIR__ . "/config.php");
include(__DIR__ . "/autoloader.php");

// The guess object from the session
// Use: try / throw error
$guessGame = unserialize($_SESSION["theGame"]);

// The guess
$guess = isset($_POST['theGuess']) ? $_POST['theGuess'] : null;

// The guess object is injected with the guess
if ($guess) {
    $guessGame->setGuess($guess);
}

// Save the new object status to the session
$_SESSION["theGame"] = serialize($guessGame);

header("Location:guess.php");
