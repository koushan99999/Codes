module Stack( Stack(), push, pop, empty, isEmpty, fromList, toList ) where
-- export the functions push, pop, empty, isEmpty 
-- along with the type constructor Stack, 
-- **but not the value constructor**

import Data.List ( intercalate )

data Stack a = Stack [a]
instance Show a => Show (Stack a) where 
    show (Stack l) = (intercalate "->") $ map show l 

push :: a -> Stack a -> Stack a
push x (Stack xs) = Stack (x:xs)

pop :: Stack a -> (a, Stack a)
pop (Stack []) = error "Empty stack" 
pop (Stack (x:xs)) = (x, Stack xs)

fromList :: [a] -> Stack a 
fromList = Stack 

toList :: Stack a -> [a] 
toList (Stack l) = l 

empty :: Stack a
empty = fromList [] 

isEmpty :: Stack a -> Bool
isEmpty (Stack xs) = null xs 