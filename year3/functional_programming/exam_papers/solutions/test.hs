last' :: [a] -> a
last' [] = error "empty list"
last' [x] = x
last' (x:xs) = last' xs

init' :: [a] -> [a]
init' [] = error "empty list"
init' (x:y:[]) = [x]
init' (x:xs) = x : init' xs

plus' :: [a] -> [a] -> [a]
plus' [] [] = []
plus' [] ys = ys
plus' (x:xs) ys = x : (plus' xs ys)

find' :: [a] -> Int -> a
find' [] _ = error "empty list"
find' (x:_) 0 = x
find' (x:xs) n
    | n < 0     = error "n cant be negative"
    | otherwise = find' xs (n-1) 

find2' :: [a] -> Int -> a
find2' (x:xs) a
    | a == 0    = x
    | otherwise = find2' xs (a-1)

max' :: Ord a => [a] -> a
max' [x] = x
max' (x:y:xs)
    | x > y     = max' (x:xs)
    | otherwise = max' (y:xs)

foldl1' :: (a -> a -> a) -> [a] -> a
foldl1' _ [x] = x
foldl1' op (x:xs) = op x (foldl1' op xs)

span' :: (a -> Bool) -> [a] -> ([a],[a])
span' _ [] = ([],[])
span' p (x:xs) 
    | p x       = (x:a, b)
    | otherwise = ([], x:xs)
    where (a,b) = span' p xs

main = do
    print(span' (==1) [1,1,1,2,3,4])