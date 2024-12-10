def gcd (m,n):
 mdiv = divisors (m)
 ndiv = divisors (n)
 idiv = intersection (mdiv, ndiv)
 return idiv[-1]
def divisors (a):
 divisorslist = []
 for x in range(1, a+1):
  if a%x == 0: # a mod x = 0 <=> x|a
   divisorslist = divisorslist + [x]
 return divisorslist
def intersection (alist, blist):
    a=0
    b=0
    ilist = []
    while (a < len(alist)) and (b < len(blist)):
        if alist[a] == blist[b]:
            ilist.append(alist[a])
            a = a+1
            b = b+1
        elif alist[a] < blist[b]:
            a = a+1
        else:
            b = b+1
        if a == len(alist) or b == len(blist):
            break
    return ilist

while True:
    alist=eval(input("Enter list 1: "))
    blist=eval(input("Enter list 2: "))
    print(intersection(alist,blist))
