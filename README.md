# chess

A game of chess in Ruby for the console. The game is fairly complete, including the ability to castle. In addition, I implemented a simple chess AI which first attempts to put a king in check, then tries to take the highest-value piece it can, then makes a random possible move. Interesting features include the use of Slideable and Steppable classes to DRY out code and a recursive duplication method which lets the game check moves for validity without changing the board itself.
