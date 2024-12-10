squares :: [(Int,Int)]
squares = [(x,y) | x <- [0..7], y <- [0..7]]
-- Function to insert the pairs in lexicographic order
insert :: (Int,Int) -> [(Int,Int)] -> [(Int,Int)]
insert x [] = [x]
insert x (m:ms)
  |x < m = x:m:ms
  |x == m = m:ms
  |otherwise = m:insert x ms
knightMove :: (Int,Int) -> Int -> [(Int,Int)]
knightMove (x,y) 0 = [(x,y)]
knightMove (x,y) n
  |n <= 6 = f (knightMove (x,y) (n - 1)) []
  |n `mod` 2 == 0 = knightMove (x,y) 6
  |n `mod` 2 == 1 = f (knightMove (x,y) 6) []
-- Function to store the possible moves of every position
f :: [(Int,Int)] -> [(Int,Int)] -> [(Int,Int)]
f [] l = l
f ((x,y):m) l = f m (g [(p,q) | (p,q) <- [(x-2,y-1),(x-2,y+1),(x-1,y-2),(x-1,y+2),(x+1,y-2),(x+1,y+2),(x+2,y-1),(x+2,y+1)], p >= 0 , p <= 7, q >= 0, q <= 7] l)
-- Function for recurrence
g :: [(Int,Int)] -> [(Int,Int)] -> [(Int,Int)]
g [] l = l
g l [] = l
g (x:xs) l = g xs (insert x l)



