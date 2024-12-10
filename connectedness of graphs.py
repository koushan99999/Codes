n = eval(input())
l = eval(input())
graph = {}
i = 1
mark = {}
for i in range(1,n+1):
    mark[i] = 0
    graph[i] = []
i = 1
j = 1
m = len(l)
l1 = [1]
while(l1 != []):
    i = l1[0]
    mark[i] = 1
    for j in range(1,n+1):
        if ((i,j) in l or (j,i) in l) and mark[j] == 0:
            mark[j] == 1
            l1.append(j)
    l1.remove(l1[0])
p = 0
i = 1
for i in range(1,n+1):
    if mark[i] == 1:
        p = 1
    else:
        p = 0
        break
if p == 0:
    print("The graph is disconnected")
else:
    print("The graph is connected")