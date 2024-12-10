module Queue(Queue, enqueue, dequeue, empty, isEmpty, fromList, toList) where 

data Queue a = Queue [a] [a] 
    deriving Eq 

instance Show a => Show (Queue a) where 
    show q = "{" ++ show (toList q) ++ "}"

enqueue :: a -> Queue a -> Queue a 
enqueue x (Queue f b) = Queue f (x:b)

dequeue :: Queue a -> (a, Queue a)
dequeue (Queue [] []) = error "Empty queue"
dequeue (Queue [] b) = (x, Queue f []) where (x:f) = reverse b 
dequeue (Queue (x:f) b) = (x, Queue f b)
 
empty :: Queue a 
empty = fromList []

isEmpty :: Queue a -> Bool
isEmpty (Queue f b) = null f && null b 

fromList :: [a] -> Queue a
fromList xs = Queue xs []

toList :: Queue a -> [a]
toList (Queue f b) = f ++ reverse b 
