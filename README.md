Per6-Sapozhnikov-Taft-Polomony
==============================

*written with Brian Sapozhnikov (bsapozhnikov) as a final project for the Spring term of A.P. Computer Science (Spring 2014)*

Attempt at making a Monopoly-like board game using Processing.  To run, open the Board file in a Processing window and hit the play button.*  To play, enter the number of players (between 2 and 4), enter the players' names, then roll the dice to get started.  All instructions and messages are printed in the terminal (inside the Processing window) during the game.  Players' tokens move around the board along with gameplay, but they move so quickly you only see their new positions.  (Sorry 'bout that.)

*the library ControlP5 must be imported to run Board

### Features: ###
* click on a Square, and information about it will be printed in the terminal
* (I actually think that's the extent of the features)

### Improvements that could be made (a few out of many): ###
* slow down token movement to make it visible
* make a shuffle method in LL (Linked List) to shuffle the decks of cards for each play
* implement auctioning
* figure out and fix the Timeout Error / infinite loop that occurs for a reason yet unknown to me