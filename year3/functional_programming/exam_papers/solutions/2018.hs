--1.a
tail' :: [a] -> [a]
tail' [] = error "empty list"
tail' (x:xs) = xs

--1.b
plusList :: [a] -> [a] -> [a]
plusList [] [] = []
plusList [] ys = ys
plusList (x:xs) ys = x : plusList xs ys

    

--1.c
init' :: [a] -> [a]
init' [] = error "empty list"
init' (x:y:[]) = x:[]
init' (x:xs) = x : (init' xs)



--1.d
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x] -- ++ implemented above



--1.e 
break' :: (a -> Bool) -> [a] -> ([a], [a])
break' _ xs@[]           =  (xs, xs)
break' p xs@(x:xs')
           | p x         =  ([],xs)                                   -- If head satisfies predicate, return empty list with the rest
           | otherwise   =  let (ys,zs) = break' p xs' in (x:ys,zs)   -- Call break' with the tail

filter' :: (a -> Bool) -> [a] -> [a]
filter' f xs = [x | x <- xs, f x]

--1.f
maximum' :: Ord a => [a] -> a
maximum' [] = error "max of empty list"
maximum' [x] = x
maximum' (x:xs) = max' x (maximum' xs)

max' :: Ord a => a -> a -> a
max' a b
  | a > b   = a
  | a < b   = b
  | a == b  = a


main = do
    print(reverse' [1,2,3])
    print(reverse [1,2,3])



