import Data.Array (listArray, (!))
import Data.Char
chainOrder :: [Int] -> (Int,String)
chainOrder l = if m == 1 then (0,"") else mArr!(1,m) where
  m = length l - 1
  lArr = listArray (0,m) l
  mArr = listArray ((1,1),(m,m)) [ multMemo (i,j) | i <- [1..m], j <- [1..m]]
  multMemo (i,j)
   |i > j = (0,"")
   |i == j = (0,"M" ++ intToString (i-1))
   |otherwise = (minimum eq,"(" ++ snd (mArr!(i,k1)) ++ " * " ++ snd (mArr!(k1+1,j)) ++ ")") where
    k1 = i+snd (minvalindex eq)
    eq = [fst (mArr!(i,k)) + fst (mArr!(k+1,j)) + (lArr!(i-1))*(lArr!k)*(lArr!j) | k <- [i..(j-1)]]
    minvalindex :: [Int] -> (Int,Int)
    minvalindex [x] = (x,0)
    minvalindex (x:xs)
     |x < fst y = (x,0)
     |otherwise = (fst y,snd (y) + 1) where
       y = minvalindex xs
  intToString :: Int -> String
  intToString n
   |n <= 9 = [intToDigit n]
   |otherwise = intToString (n `div` 10) ++ [intToDigit (n `mod` 10)]