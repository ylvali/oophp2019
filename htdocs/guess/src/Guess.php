<?php
/*
*  Class : Guess
*
*/


/*
*
* Class for handeling the guess game
*
*/

class Guess
{
  /**
  * @var boolean $moreGuesses  Shows if the game has more guesses (max 6)
  * @var int $randomNr The current random nr between 1 - 100
  * @var int $theGuess The current guess;
  * @var int $rounds The nr of rounds
  * @var boolean $winner If the user won, set to true.
  * @var string $message If there is a message to the user
  *
  */
    private $moreGuesses;
    private $randomNr;
    private $theGuess;
    private $rounds;
    private $winner;
    private $message;



  /**
  * Constructor to create a Guess.
  *
  * @param int 0|$rounds The nr of rounds
  * @param boolean $moreGuesses If object has more guesses available.
  *
  */
    public function __construct($mGuess = true, $rounds = 0)
    {
        $this->moreGuesses = $mGuess;
        $this->rounds = $rounds;
        $this->winner = false;
        $this->message = "";
        $this->play();
    }



    /**
    *   Gets the status of object : are there more guesses?
    *
    *   @return boolean
    */
    public function isActive()
    {
        return $this->moreGuesses;
    }



    /**
    *   Generates a random nr between 1 - 100
    *   Counts the nr of rounds
    *   Sets moreGuesses to false after 6 rounds
    *
    *   @return int
    */
    private function play()
    {
        return $this->randomNr = rand(1, 100);
    }



    /**
    *   Gets the random nr
    *
    *   @return int
    */
    public function getRandomNr()
    {
        return $this->randomNr;
    }



    /**
    *   Returns the guess
    *
    *   @return int
    */
    public function getGuess()
    {
        return $this->theGuess;
    }



    /**
    *   - Sets the guess
    *   - Counts the amount of guesses made.
    *   - Sends a message to the user if guess nr out of range
    *   - Sets the moreGuesses property to False after 6 rounds.
    *   - Calls function for checking the result.
    *
    *   @return void
    */
    public function setGuess(int $guess = 0)
    {

        if (!(is_int($guess) && $guess >= 0)) {
            //throw new GuessException("Guess is only allowed to be a positive integer.");
            $this->message = "Positive integers only";
            $this->theGuess = $guess;
        } else {
            $this->message = "";
            $this->rounds += 1;

            if ($this->rounds == 6) {
                $this->moreGuesses = false;
                $this->message = "";
                $this->theGuess = "";
            }

            $this->theGuess = $guess;
            $this->checkResult();
        }
    }



    /**
    *   Checks the result: the guess == the correct nr?
    *   If correct, winner is set to true.
    *   Then, no more guesses are available.
    *   If guess is not correct, user recieves a message.
    *
    *   @return void
    */
    private function checkResult()
    {
        if ($this->randomNr === $this->theGuess) {
            $this->winner = true;
            $this->moreGuesses = false;
            $this->theGuess = "";
        } else if ($this->randomNr < $this->theGuess) {
            $this->message = "The guess is of a too high value";
        } else if ($this->randomNr > $this->theGuess) {
            $this->message = "The guess is of a too low value";
        }
    }



    /**
    *   Returns the correct nr (the randomly chosen one)
    *
    *   @return int
    */
    public function getCorrectNr()
    {
        return $this->randomNr;
    }




    /**
    *   Returns a boolean of winning
    *
    *   @return boolean
    */
    public function isWinner()
    {
        return $this->winner;
    }


    /**
    *   Returns message
    *
    *   @return string
    */
    public function showMessage()
    {
        return $this->message;
    }
}
