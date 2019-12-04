main = do
    let number = 0

    if number == 0
        then putStrLn "Error! Number is zero!"

    else if number `rem` 2 == 0
        then putStrLn "This number is even."

    else 
        putStrLn "This number is odd"
