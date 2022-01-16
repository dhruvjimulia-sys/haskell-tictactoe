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

![image](https://user-images.githubusercontent.com/63531728/149659823-773d4eca-195f-4473-9037-05fe5891b5e0.png)

Make a move by entering a row and column index (separated by a space). As an example we enter `0 1`:

![image](https://user-images.githubusercontent.com/63531728/149659868-b766c200-ddc7-4a27-a373-effecb9f4797.png)

Each player continues making moves until one player wins or we have a draw.

![image](https://user-images.githubusercontent.com/63531728/149659958-a221a954-8021-4ebf-9628-1a49b0fe564e.png)

## Testing

Unit tests for the relevant TicTacToe functions can be run by executing the following command:

`runghc Tests.hs`

## Credits

The test suite `IC/TestSuite.hs` and the skeleton files were provided by Imperial College London.
