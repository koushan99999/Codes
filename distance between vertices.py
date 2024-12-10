n = eval(input())
l = eval(input())
k = 1
l1 = []
mark = {}
def dist(i,l,l1,dis):
    for k in range(1,n+1):
        if (i,k) in l and mark[k] == 0:
                dis[k] = dis[i] + 1
                mark[k] = 1
                l1.append(k)
        elif (k,i) in l and mark[k] == 0:
            dis[k] = dis[i] + 1
            mark[k] = 1
            l1.append(k)
def distance(i,j,l):
    dis = {}
    for  a in range(1,n+1):
        mark[a] = 0
        dis[a] = 0
    l1 = [i]
    while(l1 != []):
        for b in l1:
            mark[b] = 1
            dist(b,l,l1,dis)
        l1.remove(l1[0])
    if mark[j] == 1:
        return dis[j]
    else:
        return None
p = 0
for i in range(1,n+1):
    for j in range(i+1,n+1):
        p = distance(i,j,l)
        if p != None:
            print(p)
        else:
            print("Infinity")