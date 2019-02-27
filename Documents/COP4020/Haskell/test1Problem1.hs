--Affner Lefevre
factors :: Int -> [Int]
listOfPrimes = [x | x <- [1..1000000], x `mod` 2 /= 0 && x `mod` 3/= 0]
test1Problem1 n = take n listOfPrimes