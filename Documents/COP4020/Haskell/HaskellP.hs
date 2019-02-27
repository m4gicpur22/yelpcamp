
--Lists Fibonnaci sequence
fibList n = go n 1 2
   where
    go n f s
     | (f+s) > n = []
     | otherwise = (f+s) : go n s (f+s)
--Lists out sequence of even fibonnaci
evenFib n = go n 1 2
    where
    go n f s
      | (f+s) > n = []
      | otherwise = if (f+s) `mod` 2 == 0 then (f+s) : go n s (f+s) else go n s (f+s)
--Lists out seuqence of odd fibonacci
oddFib n = go n 1 2
    where
    go n f s
        | (f+s) > n = []
        | otherwise = if (f+s) `mod` 2 /= 0 then (f+s) : go n s (f+s) else go n s (f+s) 
--lists factorial
factorial n = go n 1
    where
    go n ret
      | n > 1 = go (n-1) (ret*n)
      | otherwise = ret
--find maximum value in a list
maximum' [] = error "maximum of empty list"
maximum' [x] = x
maximum' (x:xs)
    | x > maxTail = x
    | otherwise = maxTail
    where maxTail = maximum' xs
--Recursively replicating values
replicate' n x
    | n <= 0  = []
    | otherwise = x:replicate' (n-1) x
--Recursively takes values indicated by n(size)**
take' n _
    | n <= 0  = []
take' _ []  = []
take' n (x:xs) = x : take' (n-1) xs
--Recursively reverses a list
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]
--Zips, combines ordered elements from lists
zip' :: [a] -> [b] -> [(a,b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x,y):zip' xs ys
--Recurively checks to see if an element is in the list
elem' :: (Eq a) => a -> [a] -> Bool
elem' a [] = False
elem' a (x:xs)
    | a == x  = True
    | otherwise = a `elem` xs
--
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
    let smallerSorted = quicksort [a | a <- xs, a <= x]
        biggerSorted = quicksort [a | a <- xs, a > x]
    in smallerSorted ++ [x] ++ biggerSorted
--
init' [] = error "This function cannot be applied to empty"
init' [x] = [x]
init' (x:xs) = x : init' xs
--
last' [] = error "empty list given"
last' (x:[]) = x
last' (x:xs) = last' xs
--
countTo n = go n 1
    where
    go n c
     | c > n = []
     | otherwise = c : go n (c+1)
--Tower of Hanoi****
hanoi :: Integer -> a -> a -> a -> [(a, a)]
hanoi 0 _ _ _ = []
hanoi n a b c = hanoi (n-1) a c b ++ [(a,b)] ++ hanoi (n-1) c b a

--
reversedNumber n = (read(reverse(show n))) + 0

checkDigits [] = True
checkDigits (n:ns) = if even ((fromEnum n) - 48) then False else checkDigits ns

--isReversible n = checkDigits(show ((n + (reversedNumber))))

--countReversibles n = [x | x <- [1..(n-1)], isReversible x, x < reversedNumber x]

convertAsciitoInegerList [] = []
convertAsciitoInegerList (x:xs) = ((fromEnum x) - 48) : convertAsciitoInegerList xs

getSumofDigitSquares n = sum (map (^2) (convertAsciitoInegerList(show n)))

endsin89 n 
  | n == 89 = True
  | n == 1 = False
  |otherwise = endsin89 (getSumofDigitSquares n)

countEndsin89 n = length [x | x <- [1..n], endsin89 x]
--you can indicate type definitions by function ":t myFunction name"

---------------------------------------Have not reviewed bottom functions----------------------
isDivisible number divisor = number `mod` divisor == 0

isDivisibleByList number [] = True
isDivisibleByList number (x:xs)
 | isDivisible number x == False = False
 | otherwise = isDivisibleByList number xs

smallestNumber xs = go xs 1
 where go xs n
  | isDivisibleByList n xs = n
  | otherwise = go xs (n+1)

sumOfSquares n = sum [x^2 | x <- [1..n]]
squareOfSums n = (sum [x | x <- [1..n]]) ^ 2

difference n = (squareOfSums n) - (sumOfSquares n)

factorList n = [x | x <- [1..n], isDivisible n x]

isqrt :: Integral i => i -> i
isqrt = floor . sqrt . fromIntegral

isPrime n = ip n [2..(isqrt n)]
 where
 ip _ [] = True
 ip n (x:xs)
 | n `mod` x == 0 = False
 | otherwise = ip n xs

primeFactorList n = [x | x <- [2..n], isDivisible n x, isPrime x]

getCountedListOfPrimes n = go n 2
 where go n count
 | n <= 0 = []
 | isPrime count = count : go (n-1) (count+1)
 | otherwise = go n (count+1)

getLastPrime n = last (getCountedListOfPrimes n)

triangleNumber n = sum [1..n]

howManyFactors n = [length (factorList (triangleNumber x)) | x <- [1..n]]

firstTriangleWithMoreThan500Divisors = go 1
 where go count
 | triangleNumber count > 500 = triangleNumber count
 | otherwise = go (count+1)

chain :: (Integral a) => a -> [a]  
chain 1 = [1]  
chain n  
    | even n =  n:chain (n `div` 2)  
    | odd n  =  n:chain (n*3 + 1)  

numLongChains :: Int  
numLongChains = length (filter isLong (map chain [1..100]))  
    where isLong xs = length xs > 15