-- Name: Davy Nolan,  Username: dnolan5
module Ex01 where
import Data.Char (toUpper) -- needed for Part 1


{- Part 1

Write a function 'raise' that converts a string to uppercase

Function 'toUpper :: Char -> Char' converts a character to uppercase
if it is lowercase. All other characters are unchanged

-}
raise [] = []
raise all@(x:xs) = map toUpper all

{- Part 2

Write a function 'nth' that returns the nth element of a list

-}
nth :: Int -> [a] -> a
nth n (x:xs) = (x:xs)!!(n-1)

{- Part 3

write a function commonLen that compares two sequences
and reports the length of the prefix they have in common.

-}

commonLen :: Eq a => [a] -> [a] -> Int
commonLen (x:xs) (y:ys) 
    | x == y = 1 + commonLen xs ys
commonLen _ _ = 0