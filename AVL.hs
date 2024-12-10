module AVL ( 
      AVL, emptyAVL, isEmpty, insertAVL, deleteAVL
    , searchAVL, createAVL, inorder, inorderTree ) where

import Data.List ( intercalate ) 

data AVL a = Nil | Node Int (AVL a) a (AVL a) deriving Eq 

emptyAVL :: AVL a 
emptyAVL    = Nil 

isEmpty :: AVL a -> Bool 
isEmpty Nil = True 
isEmpty _   = False 

height :: AVL a -> Int 
height Nil              = 0 
height (Node h _ _ _)   = h 

slope :: AVL a -> Int 
slope Nil               = 0 
slope (Node _ tl _ tr)  = height tl - height tr 

rotateRight :: AVL a -> AVL a 
rotateRight (Node h (Node hl tll y tlr) x tr) 
        = Node nh tll y (Node nhr tlr x tr) where 
    nh  = 1 + max (height tll) nhr 
    nhr = 1 + max (height tlr) (height tr) 

rotateLeft :: AVL a -> AVL a 
rotateLeft (Node h tl x (Node hr trl y trr)) 
        = Node nh (Node nhl tl x trl) y trr where 
    nh  = 1 + max nhl (height trr)
    nhl = 1 + max (height tl) (height trl)

rebalance :: AVL a -> AVL a 
rebalance t@(Node h tl x tr) 
    | abs st < 2        = t 
    | st == 2           = if stl == -1 then
        rotateRight (Node h (rotateLeft tl) x tr) else 
            rotateRight t
    | st == -2          = if str == 1 then 
        rotateLeft (Node h tl x (rotateRight tr)) else 
            rotateLeft t where 
        (st,stl,str)    = (slope t, slope tl, slope tr) 

insertAVL :: Ord a => a -> AVL a -> AVL a 
insertAVL v Nil         = Node 1 Nil v Nil 
insertAVL v t@(Node h tl x tr)
    | v < x             = rebalance (Node nhl ntl x tr) 
    | v > x             = rebalance (Node nhr tl x ntr) 
    | v == x            = t where 
        (ntl, ntr)      = (insertAVL v tl, insertAVL v tr) 
        nhl             = 1 + max (height ntl) (height tr)
        nhr             = 1 + max (height tl) (height ntr) 

deleteMax :: AVL a -> (a,AVL a)
deleteMax (Node _ tl x Nil) = (x, tl)
deleteMax (Node h tl x tr)  = (y, rebalance (Node nh tl x ty)) where 
    (y,ty)                  = deleteMax tr 
    nh                      = 1 + max (height tl) (height ty)

deleteAVL :: Ord a => a -> AVL a -> AVL a 
deleteAVL v Nil         = Nil 
deleteAVL v t@(Node h tl x tr) 
    | v < x             = rebalance (Node nhl ntl x tr) 
    | v > x             = rebalance (Node nhr tl x ntr) 
    | v == x            = if isEmpty tl then tr else 
        rebalance (Node nhy ty y tr) where 
            (y,ty)      = deleteMax tl 
            (ntl, ntr)  = (deleteAVL v tl, deleteAVL v tr)
            nhy         = 1 + max (height ty) (height tr)
            nhl         = 1 + max (height ntl) (height tr) 
            nhr         = 1 + max (height tl) (height ntr) 

searchAVL :: Ord a => a -> AVL a -> Bool  
searchAVL v Nil             = False 
searchAVL v (Node _ tl x tr) 
    | v == x                = True 
    | v < x                 = searchAVL v tl 
    | v > x                 = searchAVL v tr 

createAVL :: Ord a => [a] -> AVL a 
createAVL   = foldr insertAVL emptyAVL

inorder :: AVL a -> [a] 
inorder t                   = go t [] where 
    go Nil xs               = xs 
    go (Node _ tl x tr) xs  = go tl (x:go tr xs)

inorderTree :: [a] -> AVL a 
inorderTree l       = fst (go (length l) l) where 
    go 0 xs         = (Nil, xs)
    go n xs         = (Node h tl y tr, zs) where 
        m           = n `div` 2 
        (tl,y:ys)   = go m xs 
        (tr,zs)     = go (n-m-1) ys 
        h           = 1 + max (height tl) (height tr)

instance Show a => Show (AVL a) where
    show t = intercalate "\n" (map (map snd) (fst (draw t)))
    
draw :: Show a => AVL a -> ([[(Int,Char)]], Int)
draw Nil    = ([[(1,'*')]], 1)
draw (Node _ Nil x Nil) = 
    let (sx, n, m) = (show x, length sx, n `div` 2) in
    ([zip (replicate m 0 ++ [1] ++ replicate (n-m-1) 2) sx], n)
draw (Node _ tl x tr) = 
    (line1:line2:line3:line4:combine linesl linesr, max n (sl+sr+3))
    where
        (sx, n, m) = (show x, length sx, n `div` 2)
        (linesl, sl) = draw tl
        (linesr, sr) = draw tr
        line1     = replicate (sl+1-m) (0,' ') 
                    ++ zip (replicate m 0 ++ [1] ++ replicate (n-m-1) 2) sx
                    ++ replicate (sr+2-n+m) (2, ' ')
        line2     = replicate (sl+1) (0,' ') ++ [(1,'|')] ++ replicate (sr+1) (2,' ')
        line3     = map (process 0) (head linesl) 
                        ++ [(0,'-'), (1,'+'),(2,'-')] 
                        ++ map (process 2) (head linesr)
        line4     = map follow line3
        follow (t,c) = if (t,c) == (0,'+') then (0,'|') else if (t,c) == (2,'+') then (2,'|') else (t,' ')
        process b (t,_) = (b, if t == 1 then '+' else if b == t then ' ' else '-') 
        combine [] ls = zipWith (++) (repeat (replicate (sl+3) (0,' '))) ls
        combine ks [] = zipWith (++) ks (repeat (replicate (sr+3) (2,' ')))
        combine (k:ks) (l:ls) = (k ++ [(0,' '), (1,' '), (2,' ')] ++ l): combine ks ls