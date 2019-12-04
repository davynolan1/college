import Data.List
import System.IO

sumOfNums = sum [1..10]

num9 = 9 :: Int
sqrtOf9 = sqrt(fromIntegral num9)

--lists
primeNumbers = [3,4,7,11]

-- Concatenate lists (Can be slow if your using a large list)
morePrimes = primeNumbers ++ [13, 17, 19, 23, 29]

-- You can use the cons operator to construct a list
favNums = 2 : 7 : 21 : 66 : []

-- You can make a list of lists
multList = [[3,5,7],[11,13,17]]

-- Quick way to add 1 value to the front of a list
morePrimes2 = 2 : morePrimes

-- Get number of elements in the list
lenPrime = length morePrimes2
 
-- Reverse the list
revPrime = reverse morePrimes2
 
-- return True if list is empty
isListEmpty = null morePrimes2

main = do
    print(revPrime)