import Data.List
import Data.Ratio
import Dict (dict)
-- Problem 1
segments :: [a] -> [[a]]
segments [] = [[]]
segments (x:xs) = segments1 0 (length (x:xs)) [[]] (x:xs)
segments1 :: Int -> Int ->[[a]] -> [a] -> [[a]]
segments1 i j l (x:xs)
    |i >= j  = segments1 0 (j - 1) l (drop 1 (x:xs)) 
    |i < j = segments1 (i + 1) j (l ++ [take (i + 1) (x:xs)]) (x:xs)
segments1 _ _ l [] = (drop 1 l) ++ [[]]
-- Problem 2
upRuns :: Ord a => [a] -> [[a]]
upRuns [] = [[]]
upRuns (x:xs) = upRuns1 [[]] [] (x:xs)
upRuns1 :: Ord a => [[a]] -> [a] -> [a] -> [[a]]
upRuns1 l m (x:xs)
    |take 1 xs >= take 1 (x:xs) && length (x:xs) /= 1 = upRuns1 l ([x] ++ m) xs
    |take 1 xs < take 1 (x:xs) && length (x:xs) /= 1 = upRuns1 (l ++ [reverse ([x] ++ m)]) [] xs
    |length (x:xs) == 1 = upRuns1 l ([x] ++ m) []
upRuns1 l m [] = ((drop 1 l) ++ [reverse m])
-- Problem 3
type Game = (String, String, ([Char], [Char], [Char]))
type Solution = [String]
-- Function to calculate number of eliminated letters
x1 :: String -> String -> Int -> Int
x1 (x:xs) (y:ys) i = if elem x (y:ys) == True then x1 xs (y:ys) i
                                              else x1 xs (y:ys) (i + 1)
x1 [] _ i = i
-- Function for checking no repeatation of letters
x2 :: String -> Bool
x2 [] = True
x2 [_] = True
x2 (x:xs) = if elem x xs == True then False
                         else x2 xs
-- Function for checking letters of 1st list
xl1 :: [Char] -> String -> [String] -> Bool
xl1 [] _ _ = True 
xl1 (x:xs) (y:ys) (z:zs)
   |elem x (y:ys) == True && x3 (y:ys) (z:zs) >= 10 = xl1 xs (y:ys) (z:zs)
   |elem x (y:ys) == True && x3 (y:ys) (z:zs) < 10 = False
   |elem x (y:ys) == False = xl1 xs (y:ys) (z:zs)
-- Function for checking letters of 2nd list
xl2 :: [Char] -> String -> [String] -> Bool
xl2 [] _ _ = True 
xl2 (x:xs) (y:ys) (z:zs)
   |elem x (y:ys) == True && x3 (y:ys) (z:zs) >= 18 = xl2 xs (y:ys) (z:zs)
   |elem x (y:ys) == True && x3 (y:ys) (z:zs) < 18 = False
   |elem x (y:ys) == False = xl2 xs (y:ys) (z:zs)
-- Function for checking letters of 3rd list
xl3 :: [Char] -> String -> [String] -> Bool
xl3 [] _ _ = True 
xl3 (x:xs) (y:ys) (z:zs)
   |elem x (y:ys) == True && x3 (y:ys) (z:zs) == 22 = xl3 xs (y:ys) (z:zs)
   |elem x (y:ys) == True && x3 (y:ys) (z:zs) /= 22 = False
   |elem x (y:ys) == False = xl3 xs (y:ys) (z:zs)
-- Function for getting the number of the word in given solution
x3 :: String -> [String] -> Int
x3 (x:xs) (y:ys) = x3' (x:xs) (y:ys) 1
x3' :: String -> [String] -> Int -> Int
x3' _ [] i = i
x3' (x:xs) (y:ys) i
   |(x:xs) == y = i
   |otherwise = x3' (x:xs) ys (i + 1)
-- Function for checking not to have eliminated letters
x4 :: [Char] -> String -> Bool
x4 (x:xs) (y:ys) = if elem x (y:ys) == True then False
                                            else x4 xs (y:ys)
x4 [] _ = True 
-- Function to get the list of eliminated letters
x5 :: String -> String -> [Char] -> [Char]
x5 (x:xs) (y:ys) l = if elem x (y:ys) == True then x5 xs (y:ys) l
                                              else (x : l)
x5 [] _ l = l
checkStack :: Game -> Solution -> Bool
checkStack ((x:xs), (y:ys), (l1, l2, l3)) (m:z:zs) = checkStack' ((x:xs), (y:ys), (l1, l2, l3)) (m:z:zs) (m:z:zs) []
checkStack' :: Game -> Solution -> [String] -> [Char] -> Bool
checkStack' ((x:xs), (y:ys), (l1, l2, l3)) (z:zs) (n:ns) l 
   |elem (x:xs) dict == True && elem (y:ys) dict == True && x2 (x:xs) == True && xl1 l1 (x:xs) (n:ns) == True && xl2 l2 (x:xs) (n:ns) == True && xl3 l3 (x:xs) (n:ns) == True && x2 (y:ys) == True && xl1 l1 (y:ys) (n:ns) == True && xl2 l2 (y:ys) (n:ns) == True && xl3 l3 (y:ys) (n:ns) == True && x4 (l ++ (x5 (x:xs) (y:ys) [])) (head zs) == True && length (z:zs) /= 2 && x1 (x:xs) (y:ys) 0 == 1 = checkStack' ((head zs), head (drop 1 zs), (l1, l2, l3)) zs (n:ns) (l ++ (x5 (x:xs) (y:ys) []))
   |length (z:zs) == 2 && elem z dict == True && elem (head zs) dict == True && xl1 l1 z (n:ns) == True && xl2 l2 z (n:ns) == True && xl3 l3 z (n:ns) == True && x2 (head zs) == True && xl1 l1 (head zs) (n:ns) == True && xl2 l2 (head zs) (n:ns) == True && xl3 l3 (head zs) (n:ns) == True && x4 l (head zs) == True && x1 z (head zs) 0 == 1 = True    
   |otherwise = False
-- Problem 4
cf :: Rational -> [Integer]
cf x = cf1 (fromIntegral (numerator x)) (fromIntegral (denominator x))
cf1 :: Integer -> Integer -> [Integer]
cf1 a 0 = []
cf1 a b = (a `div` b) : cf1 b (a `mod` b)
computeRat :: [Integer] -> Rational
computeRat (x:xs) = c1 1 (last (x:xs)) (reverse (x:xs))
c1 :: Integer -> Integer -> [Integer] -> Rational
c1 a b (x:xs) 
      |length (x:xs) == 1 = (b%a)
      |otherwise = c1 b (b* last (reverse xs) + a) xs
-- Problem 5
phi :: Double
phi = (1 + sqrt 5) / 2
approxGR :: Double -> Rational
approxGR x = ap x [1,1,1,1]
ap :: Double -> [Integer] -> Rational
ap x l
      |abs (phi - computeFrac (computeRat l)) < x = computeRat l
      |abs (phi - computeFrac (computeRat l)) >= x = ap x (l ++ [1]) 
computeFrac :: Rational -> Double
computeFrac x = fromIntegral (numerator x) / fromIntegral (denominator x)