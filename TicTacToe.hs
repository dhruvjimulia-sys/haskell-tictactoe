module TicTacToe where

import Data.Char
import Data.Maybe
import Data.List
import Text.Read
import qualified Control.Monad

-------------------------------------------------------------------
data Player = O | X
            deriving (Eq, Show, Enum)

data Cell = Empty | Taken Player
          deriving (Eq)

instance Show Cell where
  show (Taken p) = show p
  show _         = "-"

type Board = ([Cell], Int)

type Position = (Int, Int)

-------------------------------------------------------------------

--
-- Some useful functions from, or based on, the unassessed problem sheets...
--

-- Preserves Just x iff x satisfies the given predicate. In all other cases
-- (including Nothing) it returns Nothing.
filterMaybe :: (a -> Bool) -> Maybe a -> Maybe a
filterMaybe p m@(Just x)
  | p x = m
filterMaybe p _
  = Nothing

-- Replace nth element of a list with a given item.
replace :: Int -> a -> [a] -> [a]
replace 0 p (c : cs)
  = p : cs
replace _ p []
  = []
replace n p (c : cs)
  = c : replace (n - 1) p cs

-- Returns the rows of a given board.
rows :: Board -> [[Cell]]
rows (cs , n)
  = rows' cs
  where
    rows' []
      = []
    rows' cs
      = r : rows' rs
      where
        (r, rs) = splitAt n cs

-- Returns the columns of a given board.
cols :: Board -> [[Cell]]
cols
  = transpose . rows

-- Returns the diagonals of a given board.
diags :: Board -> [[Cell]]
diags (cs, n)
  = map (map (cs !!)) [[k * (n + 1) | k <- [0 .. n - 1]],
                      [k * (n - 1) | k <- [1 .. n]]]

-------------------------------------------------------------------

gameOver :: Board -> Bool
gameOver b = any (\x -> nub x /= [Empty] && (null . tail . nub) x)
                 (concat [rows b, cols b, diags b])

-------------------------------------------------------------------

--
-- Moves must be of the form "row col" where row and col are integers
-- separated by whitespace. Bounds checking happens in tryMove, not here.
--

parsePosition :: String -> Maybe Position
parsePosition s
  = do [x, y] <- return (words s)
       r <- readMaybe x
       c <- readMaybe y
       return (r, c)

tryMove :: Player -> Position -> Board -> Maybe Board
tryMove p (r, c) (cs, n)
  = do True <- return (r >= 0 && c >= 0 && r < n && c < n)
       Empty <- return (cs !! i)
       return (replace i (Taken p) cs, n)
       where i = r * n + c

-------------------------------------------------------------------
-- I/O Functions

prettyPrint :: Board -> IO ()
prettyPrint b = foldr1 (>>) [putStrLn $ unwords $ map show r | r <- rows b]

-- The following reflect the suggested structure, but you can manage the game
-- in any way you see fit.

-- Repeatedly reads input string and checks if string is valid based on given
-- function. If function returns Nothing, then retries reading input
doParseAction :: (String -> Maybe a) -> IO a
doParseAction f
  = getLine >>= \i ->
      maybe (putStr "Invalid input, try again: " >> doParseAction f) return (f i)

-- Repeatedly read a target board position and invoke tryMove until
-- the move is successful (Just ...).
takeTurn :: Board -> Player -> IO Board
takeTurn b ply
  = putStr ("Player " ++ show ply ++ " make your move (row col):")
      >> doParseAction (parsePosition Control.Monad.>=>
      (\ pos -> tryMove ply pos b))

-- Manage a game by repeatedly: 1. printing the current board, 2. using
-- takeTurn to return a modified board, 3. checking if the game is over,
-- printing the board and a suitable congratulatory message to the winner
-- if so.
playGame :: Board -> Player -> IO ()
playGame b ply
  = do prettyPrint b
       b' <- takeTurn b ply
       if gameOver b'
         then prettyPrint b' >> putStrLn ("Player " ++ show ply ++ " has won!")
         else playGame b' (toEnum (1 - fromEnum ply))

-- Print a welcome message, read the board dimension, invoke playGame and
-- exit with a suitable message.
main :: IO ()
main
  = do putStrLn "Welcome to tic tac toe on an N x N board"
       putStr "Enter the board size (N)"
       s <- doParseAction
         (readMaybe Control.Monad.>=>
           (\ x -> if x > 1 then return x else Nothing))
       playGame (replicate (s * s) Empty, s) X
       putStrLn "Thank you for playing"

-------------------------------------------------------------------

testBoard1, testBoard2, testBoard3 :: Board

testBoard1
  = ([Taken O,Taken X,Empty,Taken O,
      Taken O,Empty,Taken X,Taken X,
      Taken O,Empty,Empty,Taken X,
      Taken O,Taken X,Empty,Empty],
      4)

testBoard2
  = ([Taken X,Empty,
      Empty,Empty],
      2)

testBoard3
  = ([Taken O,Taken X,Empty,Taken O,Taken X,
      Taken O,Empty,Taken X,Taken X,Empty,
      Empty,Empty,Taken X,Taken O,Taken O,
      Taken O,Taken X,Empty,Empty,Taken X,
      Taken X,Empty,Taken O,Empty,Empty],
      5)
