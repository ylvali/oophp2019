<?php

/*
*    Configure php
*
*/

/*
* Report all type of errors
*
*/

error_reporting(-1);              // Report all type of errors
ini_set("display_errors", 1);     // Display all errors


/**
 * Default exception handler.
 */
set_exception_handler(function ($e) {
    echo "<p>Anax: Uncaught exception:</p><p>Line "
        . $e->getLine()
        . " in file "
        . $e->getFile()
        . "</p><p><code>"
        . get_class($e)
        . "</code></p><p>"
        . $e->getMessage()
        . "</p><p>Code: "
        . $e->getCode()
        . "</p><pre>"
        . $e->getTraceAsString()
        . "</pre>";
});


/**
*   Start session
*
*/
session_name("ylsj11");
session_start();
