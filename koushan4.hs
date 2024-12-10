import Data.Array (listArray, (!))
editDistance :: String -> String -> (Int, String)
editDistance as bs = eDArr!(0,0) where
 (m,n) = (length as, length bs)
 aArr = listArray (0,m) as
 bArr = listArray (0,n) bs
 eDArr = listArray ((0,0),(m,n))
    [eDMemo (i,j) | i <- [0..m], j <- [0..n]]
 eDMemo (i,j)
  |i == m && j == n = (0,"")
  |i == m && j /= n = (2+l1, 'i':s1)
  |i /= m && j == n = (2+l2, 'd':s2)
  |aArr!i == bArr!j = (l,'-':s)
  |l3 <= l4 && l3 <= l5 = (1+l, 'm':s)
  |l4 <= l3 && l4 <= l5 = (2+l1, 'i':s1)
  |l5 <= l3 && l5 <= l4 = (2+l2, 'd':s2) where
   (l,s) = eDArr!(i+1,j+1)
   (l1,s1) = eDArr!(i,j+1)
   (l2,s2) = eDArr!(i+1,j)
   (l3,s3) = (1+l, s)
   (l4,s4) = (2+l1, s1)
   (l5,s5) = (2+l2, s2)
-- (l3,s3) : modify
-- (l4,s4) : insert
-- (l5,s5) : delete