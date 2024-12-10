import Data.Char(ord)
-- Problem 1
isPOT :: Integer -> Bool
isPOT x = isPOT1 x 0
isPOT1 :: Integer -> Integer -> Bool
isPOT1 m n
   |m > 3^n      = isPOT1 m (n + 1)
   |m < 3^n      = False
   |otherwise    = True
-- Problem 2
isPPOT :: Integer -> Bool
isPPOT x = isPPOT1 x 0
isPPOT1 :: Integer -> Integer -> Bool
isPPOT1 m n
   |m == 3       = False
   |m > 3^n      = isPPOT1 m (n + 1)
   |m < 3^n      = False
   |otherwise    = isPPOT2 n
isPPOT2 :: Integer -> Bool
isPPOT2 p = f (p - 1) p
f :: Integer -> Integer -> Bool
f x y = if y `mod` x == 0 then prime1 x
              else f (x - 1) y
prime1 :: Integer -> Bool
prime1 i = if i == 1 then True
           else False
-- Problem 3
intToOct :: Int -> String
intToOct 0 = "0"
intToOct n = (intToOct (n `div` 8)) ++ (show (n `mod` 8))
-- Problem 4
octToInt1 :: String -> [Int]
octToInt1 = map ord
octToInt :: String -> Int
octToInt "" = 0
octToInt (a:as) = (head(octToInt1 (a:as)) - 48)*8^(length (a:as) - 1) + octToInt as
-- Problem 5
leftRotate :: Integer -> Integer
leftRotate n = (n - (n `div` 10^(intlength1 n - 1))*10^(intlength1 n - 1))*10 + (n `div` 10^(intlength1 n - 1))
intlength1 :: Integer -> Integer
intlength1 n
    |n < 10      = 1
    |otherwise   = 1 + intlength1 (n `div` 10)
-- Problem 6
rightRotate :: Integer -> Integer
rightRotate n
    |n < 10      = n
    |otherwise   = (n `div` 10) + (n `mod` 10)*10^(intlength n - 1)
intlength :: Integer -> Integer
intlength n
    |n < 10      = 1
    |otherwise   = 1 + intlength (n `div` 10)
-- Problem 7
collatz :: Int -> [Int]
collatz n = if n <= 0 then []
            else if n == 1 then [1]
            else [n] ++ collatz (collatz1 n)
collatz1 :: Int -> Int
collatz1 1 = 1
collatz1 n = if (n `mod` 2 == 0) then (n `div` 2)
             else (3 * n + 1)
-- Problem 8
josephus :: Int -> [(Int, Int)]
josephus n = j' 2 1 [1..n] []
j' :: Int -> Int -> [Int] -> [(Int, Int)] -> [(Int, Int)]
j' k i (x:xs) l
   |xs == []  = reverse l
   |i `mod` k == 0 = j' k (i + 1) xs ([(head(reverse(x:xs)), head(x:xs))] ++ l)
   |otherwise = j' k (i + 1) (xs ++ [x]) l
josephusWinner :: Int -> Int
josephusWinner n = jw' 2 1 [1..n] []
jw' :: Int -> Int -> [Int] -> [(Int, Int)] -> Int
jw' k i (x:xs) l
   |xs == []  = x
   |i `mod` k == 0 = jw' k (i + 1) xs ([(head(reverse(x:xs)), head(x:xs))] ++ l)
   |otherwise = jw' k (i + 1) (xs ++ [x]) l