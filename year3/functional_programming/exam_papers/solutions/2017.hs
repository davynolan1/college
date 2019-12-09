--1.a
tail' :: [a] -> [a]
tail' [] = error "empty list"
tail' (x:xs) = xs

--1.b
last' :: [a] -> a
last' [] = error "empty list"
last' (x:[]) = x
last' (x:xs) = last'(xs)

--1.c
init' :: [a] -> [a]
init' [] = error "empty list"
init' (x:y:[]) = x:[]
init' (x:xs) = x : init' xs

--1.d 
splitAt' :: Int -> [a] -> ([a], [a])
splitAt' 0 ys     = ([], ys)
splitAt' _ []     = ([], [])
splitAt' n (y:ys)
  | n < 0     = ([], (y:ys))
  | otherwise = ((y:a), b)
  where (a, b) = splitAt' (n - 1) ys

--1.e
replicate' :: Int -> a -> [a]
replicate' 0 c = []
replicate' i c = c : replicate' (i-1) c

--1.f
foldl' :: (a -> b -> a) -> a -> [b] -> a
foldl' f acc []     =  acc
foldl' f acc (x:xs) =  foldl' f (f acc x) xs

foldl1'           :: (a -> a -> a) -> [a] -> a
foldl1' f (x:xs)  =  foldl' f x xs
foldl1' _ []      =  error "Prelude.foldl1: empty list"



f1 [] = 42
f1 (x:xs) = x * f1 xs

hof :: [a] -> [a] -> (a -> a) -> (a -> a) -> (a -> a -> b) -> [b]
hof [] _ _ _ _ = []
hof _ [] _ _ _ = []
hof (x:xs) (y:ys) t1 t2 f = (f ((t1 x) (t2 y))) : (hof xs ys t1 t2 f)


main = do
    print(hof [1,2] [3,4] (\x -> x) (\y -> y) (*))



