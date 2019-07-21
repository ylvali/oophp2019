<?php
/**
 * Create routes using $app programming style.
 * For the guess game
 */

namespace Anax\Game;

 /**
  *
  * Start the game .
  *
  */
 $app->router->add("guessGame/start", function () use ($app) {


      // Link for starting the game
      $aLink = "<a href='playGame' class='gameBtn'> Start game </a>";


     // Setting the content to send to the view
     $title = "Test";
     $data = [
         "class" => "theGuessGame",
         "gameHeader" => "<h1>The guess game</h1>",
         "content" => "<h2> Let the game begin! </h2> \n Lets play? \n".$aLink,
     ];


     // Adding the view and including the content
     $app->page->add("anax/guessGame/guessGame", $data);


     // Returning the total
     return $app->page->render([
         "title" => $title,
     ]);
 });



 /**
  *
  * Play the game
  * Check for game object in session
  * Initiate new one if none
  * Let user guess using a form
  * Stop after correct answer / 5 guesses
  *
  */
 $app->router->add("guessGame/playGame", function () use ($app) {


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


     $cheatOption ="<form method='get' action=''>
     <input type='submit' class='button1' name='cheat' value='cheat'>
     </form>";


     // Create a reset Session option
     $destroySession = "<a href='reset' class='gameBtn'> Reset </a>";


     // The status of the object shows if there are more guesses or not (boolean)
      $moreGuesses = $guessGame->isActive();


     // If there are more guesses and still not the correct answer,
     // continue to take guesses from the player
     // Use a form that uses route : guessGame/getPost
    if ($moreGuesses) {
          // Instructions for user
          $content = "Guess a nr 1 - 100";

         // Display the form
         $forUser = "<form method='post' action='getPost'>
                   Nr: <input type='number' name='theGuess' class='inputF'><br>
                   <input type='submit' class='button1' value='guess'>
                   </form>";
    } else {
         $corrNr = $guessGame->getCorrectNr();

         //Message for user
         $content = " The fact is that ...";

         // Check if there is a winner
        if ($guessGame->isWinner()) {
             $forUser = "<h2> You won! </h2>";
             $cheatOption = "";
             $forUser .= "The correct number was ".$corrNr."</br>";
        } else {
             $cheatOption = "";
             $forUser = "<h2> There are no more guesses! </h2> <br/>";
             $forUser .= "The correct number was ".$corrNr."</br>";
        }
    }


      // Setting the content to send to the view
     $title = "Test";
     $data = [
           "class" => "theGuessGame",
           "gameHeader" => "<h1>The guess game</h1>",
           "content" => "$content<br/>".$forUser.$cheatOption.$destroySession."</br><br/>".$cheat
        ];


     // Adding the view
     $app->page->add("anax/guessGame/guessGame", $data);


     // Returning the info
     return $app->page->render([
         "title" => $title,
     ]);
 });



 /**
  *
  * Get the guess : post action
  * Set it to the game object (handled by session)
  *
  */
 $app->router->add("guessGame/getPost", function () use ($app) {

      $aLink = "<a href='playGame' class='gameBtn'> Start game </a>";


      // Get incoming POST
      $guess = $app->request->getPost('theGuess');


      // The guess object from the session
      // Use: try / throw error
      $guessGame = unserialize($_SESSION["theGame"]);


     // The guess object is injected with the guess
    if ($guess) {
         $guessGame->setGuess($guess);
    }


     // Get the message from the guess object (higher/lower etc)
     $message = $guessGame->showMessage();


     // Save the new object status to the session
     $_SESSION["theGame"] = serialize($guessGame);


     //  Link for ok-btn & next game
     $okBtn = "<a href='playGame' class='gameBtn'> Ok </a>";


     // Setting the content
     $title = "Test";
     $data = [
         "class" => "theGuessGame",
        "gameHeader" => "<h1>The guess game</h1>",
         "content" => "Your guess is $guess <br/> $message <br/> $okBtn."
     ];


     // Adding the view
     $app->page->add("anax/guessGame/guessGame", $data);


     // Returning the info
     return $app->page->render([
         "title" => $title,
     ]);
 });



 /**
  *
  * Reset the game .
  *
  */

 $app->router->add("guessGame/reset", function () use ($app) {


      // Unset all of the session variables.
      $_SESSION = [];


      // If it's desired to kill the session, also delete the session cookie.
      // Note: This will destroy the session, and not just the session data!
    if (ini_get("session.use_cookies")) {
          $params = session_get_cookie_params();

          setcookie(
              session_name(),
              '',
              time() - 42000,
              $params["path"],
              $params["domain"],
              $params["secure"],
              $params["httponly"]
          );
    }


      // Finally, destroy the session.
      session_destroy();

      $aLink = "<a href='playGame' class='gameBtn'> Yeah </a>";


     // Getting the content
     $title = "Reset";
     $data = [
         "class" => "theGuessGame",
         "gameHeader" => "<h1>The guess game</h1>",
         "content" => "<h1> Game reset </h1> \n Lets play again? \n".$aLink,
     ];


     // Adding the view
     $app->page->add("anax/guessGame/guessGame", $data);


     // Returning the info
     return $app->page->render([
         "title" => $title,
     ]);
 });
