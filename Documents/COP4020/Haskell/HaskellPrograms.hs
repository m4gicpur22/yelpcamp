
--Lists Fibonnaci sequence
fibList = go n 1 2
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
--lists factorial
factorial n = go n 1
	where
	go n ret
	  | n > 1   = go (n-1) (ret*n)
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


