
--Affner Lefevre

factors n = [x | x <- [1..n], n `mod` x == 0]
factors3 n = length(factors n)

test1Problem3 n = [x | x <- [1..n], x `mod` 5 == 0 || (factors3 x) == 3]
