f1 p [] = p
f1 p (x:xs) = f1 (p*x) xs

f2 ell [] = ell
f2 ell (x:xs) = f2 (ell+1) xs

main = do
    print(f2 3 [1,2,3])