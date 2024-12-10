import Data.List ( intercalate )

data BTree a = Nil | Node (BTree a) a (BTree a)

size :: BTree a -> Int 
size Nil            = 0 
size (Node tl x tr) = 1 + size tl + size tr 

height :: BTree a -> Int 
height Nil              = 0 
height (Node tl x tr)   = 1+ max (height tl) (height tr) 

reflect :: BTree a -> BTree a 
reflect Nil             = Nil 
reflect (Node tl x tr)  = Node (reflect tr) x (reflect tl) 

levels :: BTree a -> [a]
levels                      = concat . levels'
levels' :: BTree a -> [[a]]
levels' Nil                 = []
levels' (Node tl x tr)      = [x]:join (levels' tl) (levels' tr) 
join :: [[a]] -> [[a]] -> [[a]]
join []         yss         = yss 
join xss        []          = xss 
join (xs:xss)   (ys:yss)    = (xs++ys):join xss yss

inorder0 :: BTree a -> [a]
inorder0 Nil = []
inorder0 (Node tl x tr) = inorder0 tl ++ [x] ++ inorder0 tr 

{-
go t l = inorder t ++ l
inorder t = go t []

go Nil l = inorder Nil ++ l = [] ++ l = l 
go (Node tl x tr) l 
    = inorder (Node tl x tr) ++ l 
    = (inorder tl ++ [x] ++ inorder tr) ++ l
    = inorder tl ++ ([x] ++ (inorder tr ++ l))
    = inorder tl ++ ([x] ++ go tr l)
    = inorder tl ++ (x:go tr l)
    = go tl (x:go tr l)
-}

inorder :: BTree a -> [a]
inorder t = go t [] where 
    go Nil l = l 
    go (Node tl x tr) l = go tl (x:go tr l) 

createTree0 :: [a] -> BTree a 
createTree0 []      = Nil 
createTree0 xs      = Node (createTree0 front) x (createTree0 back) where 
    m               = length xs `div` 2
    (front,x:back)  = splitAt m xs 

createTree :: [a] -> BTree a 
createTree l        = fst (go (length l) l) where 
    go :: Int -> [a] -> (BTree a, [a]) 
    go 0 xs         = (Nil, xs) 
    go n xs         = (Node tl y tr, zs) where 
        m           = n `div` 2 
        (tl,y:ys)   = go m xs 
        (tr, zs)    = go (n-m-1) ys     

instance Show a => Show (BTree a) where 
    show                = intercalate "\n" . draw
draw :: Show a => BTree a -> [String] 
draw Nil                = ["*"]
draw (Node Nil x Nil)   = [show x]
draw (Node tl x tr)     = [show x] ++ ["|"] ++ shiftl (draw tl) 
                                    ++ ["|"] ++ shiftr (draw tr) where 
    shiftl              = zipWith (++) ("+-":repeat "| ")
    shiftr              = zipWith (++) ("`-":repeat "  ")
    
tree0, tree1, tree2, tree3 :: BTree Int 
tree0 = Node (Node Nil 1 (Node Nil 2 Nil)) 
        3 (Node (Node Nil 4 Nil) 5 Nil)

tree1 = Node (Node Nil 1 (Node Nil 2 Nil)) 
        0 (Node (Node Nil 4 Nil) 3 (Node Nil 5 Nil))

tree2 = Node (Node (Node (Node Nil 0 Nil) 1 Nil) 2 (Node Nil 3 Nil)) 
        4 (Node (Node Nil 5 Nil) 6 (Node Nil 7 Nil))

tree3 = Node (Node (Node Nil 0 (Node Nil 1 Nil)) 2 (Node Nil 3 Nil))
        4 (Node (Node Nil 5 (Node Nil 7 Nil)) 6 Nil)
