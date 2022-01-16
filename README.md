# Haskell Tic Tac Toe

## Prerequisites

To run the program, you will need to install the Glasgow Haskell Compiler. This can be installed by following the instructions in the site below.

https://www.haskell.org/downloads/

## Getting Started

Clone the repository. In the project directory, start the tic tac toe program by running the command:
```
$ runghc TicTacToe.hs
```

Initialize the board by entering a board size, which can be any positive integer. For example, we enter `3`:

Make a move by entering a row and column index (separated by a space). As an example we enter `0 1`:

Each player continues making moves until one player wins or we have a draw.

## Testing

Unit tests for the relevant TicTacToe functions can be run by executing the following command:

`runghc Tests.hs`

## Credits

The test suite `IC/TestSuite.hs` and the skeleton files were provided by Imperial College London.