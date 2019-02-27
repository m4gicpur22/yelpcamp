--Affner Lefevre
fibList n = go n 1 1 
  where 
   go n f s 
    | f >= n = [] 
    | otherwise = f : go (n - 1) s (f+s)

test1Problem2 n = [x | x <- fibList n, x `mod` 10 == 3]
