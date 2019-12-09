zip' :: [a] -> [b] -> [(a,b)]
zip' [] [] = []
zip' (x:xs) (y:ys) = (x,y) : zip' xs ys




hof :: (a -> a -> b) -> [a] -> [a] -> [b]
hof _ [] _ = []
hof _ _ [] = []
hof fx (x:xs) (y:ys) = (fx x y) : (hof fx xs ys)


f1 = hof (*)
f2 = hof (+)
f3 = hof f3b
   where f3b x y = (x y)
f4 = hof f4b
    where f4b x y = (y,x)
f5 = hof f5b
   where f5b x y = x

main = do
    print(f1 [1,2] [3,4])

