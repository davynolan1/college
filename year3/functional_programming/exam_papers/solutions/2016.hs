init' :: [a] -> [a]
init' [] = error "empty list"
init' (x:[]) = []
init' (x:xs) = x : init' xs

last' :: [a] -> a
last' [] = error "empty list"
last' (x:[]) = x
last' (_:xs) = last' xs

span' :: (a -> Bool) ->[a] -> ([a],[a])
span' bool [] = ([],[])
span' bool (x:xs)
   | bool x = let(d,e) = span' bool xs in (x:d,e)
   | otherwise = ([],(x:xs))

find' :: [a] -> Int -> a
find' (x:xs) a
    | a == 0 = x
    | otherwise = find' xs (a-1)
    


foldl1' :: (a -> a -> a) -> [a] -> a
foldl1' _ [x] = x
foldl1' op (x:xs) = op x (foldl1' op xs)
    


reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]

main = do
    print(find' [6,2,9,3,1] 0)