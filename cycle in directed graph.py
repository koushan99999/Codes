n = eval(input())
l = eval(input())
i = 1
l1 = []
l2 = []
mark ={}
def dfs(i,l):
    mark[i] = 1
    l2 = [i]
    for (i,j) in l:
        if j in l2:
            return True
        elif mark[j] == 0:
            l2.append(j)
            mark[j] = 1
            if dfs(j,l):
                return True
    l2.remove(i)
    return False
p = 0
for i in range(1,n+1):
    mark = {}
    l2 = []
    for j in range(1,n+1):
        mark[j] = 0
    if dfs(i,l) == True:
        p = 1
        break
if p == 1:
    print("The graph has a cycle")
else:
    print("The graph has no cycle")