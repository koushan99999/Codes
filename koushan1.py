def mini(a,b):
    if a == 0:
        return b
    elif b == 0:
        return a
    else:
        return min(a,b)
class TreeNode(object):
    def __init__(self, value):
        self.data = value
        self.left = None
        self.right = None
        self.height = 1
        self.list = [0,0]
        self.minmax = [0,0]
    # Function to insert a node
    def insert_node(self, t):
        root = self
        x = t[0]
        y = t[1]
        z = t[2]
        # Find the correct location and insert the node
        if self.data == 0:
            self.data = x
            self.list[z] = y
            self.minmax[z] = y
        elif x == self.data:
            if z == 0:
                self.minmax[0] = mini(y,self.minmax[0])
                self.list[0] = mini(y,self.list[0])
            else:
                self.minmax[1] = max(y,self.minmax[1])
                self.list[1] = max(y,self.list[1])
        elif x < self.data:
            if z == 0:
                self.minmax[0] = mini(y,self.minmax[0])
            else:
                self.minmax[1] = max(y,self.minmax[1])
            if self.left:
                self.left = self.left.insert_node(t)
            else:
                self.left = TreeNode(x)
                self.left.list[z] = y
                self.left.minmax[z] = y
        else:
            if z == 0:
                self.minmax[0] = mini(y,self.minmax[0])
            else:
                self.minmax[1] = max(y,self.minmax[1])
            if self.right:
                self.right = self.right.insert_node(t)
            else:
                self.right = TreeNode(x)
                self.right.list[z] = y
                self.right.minmax[z] = y
        root.height = 1 + max(self.h(root.left),self.h(root.right))
        slope = self.h(root.left) - self.h(root.right)
        if slope > 1:
            if x < root.left.data:
                return self.rightRotate(root)
            else:
                root.left = self.leftRotate(root.left)
                return self.rightRotate(root)
        elif slope < -1:
            if x > root.right.data:
                return self.leftRotate(root)
            else:
                root.right = self.rightRotate(root.right)
                return self.leftRotate(root)
        else:
            return root
    def leftRotate(self, tree):
        y = tree.right
        tree2 = y.left
        y.left = tree
        tree.right = tree2
        tree.height = 1 + max(self.h(tree.left),self.h(tree.right))
        y.height = 1 + max(self.h(y.left),self.h(y.right))
        y.minmax = y.left.minmax[:]
        if y.left.left != None and y.left.right != None:
            y.left.minmax[0] = mini(y.left.list[0],mini(y.left.left.minmax[0],y.left.right.minmax[0]))
            y.left.minmax[1] = max(y.left.list[1],y.left.left.minmax[1],y.left.right.minmax[1])
        elif y.left.left != None:
            y.left.minmax[0] = mini(y.left.list[0],y.left.left.minmax[0])
            y.left.minmax[1] = max(y.left.list[1],y.left.left.minmax[1])
        elif y.left.right != None:
            y.left.minmax[0] = mini(y.left.list[0],y.left.right.minmax[0])
            y.left.minmax[1] = max(y.left.list[1],y.left.right.minmax[1])
        else:
            y.left.minmax = y.left.list[:]
        return y
    def rightRotate(self, tree):
        y = tree.left
        tree2 = y.right
        y.right = tree
        tree.left = tree2
        tree.height = 1 + max(self.h(tree.left),self.h(tree.right))
        y.height = 1 + max(self.h(y.left),self.h(y.right))
        y.minmax = y.right.minmax[:]
        if y.right.left != None and y.right.right != None:
            y.right.minmax[0] = mini(y.right.list[0],mini(y.right.left.minmax[0],y.right.right.minmax[0]))
            y.right.minmax[1] = max(y.right.list[1],y.right.left.minmax[1],y.right.right.minmax[1])
        elif y.right.left != None:
            y.right.minmax[0] = mini(y.right.list[0],y.right.left.minmax[0])
            y.right.minmax[1] = max(y.right.list[1],y.right.left.minmax[1])
        elif y.right.right != None:
            y.right.minmax[0] = mini(y.right.list[0],y.right.right.minmax[0])
            y.right.minmax[1] = max(y.right.list[1],y.right.right.minmax[1])
        else:
            y.right.minmax = y.right.list[:]
        return y
    def h(self, root):
        if root == None:
            return 0
        else:
            return root.height
    def restrict(self,l,r):
        m = 0
        m1 = 0
        t = (0,0)
        if l <= self.data <= r:
            m = self.list[0]
            m1 = self.list[1]
            if self.right:
                if l <= self.right.data <= r:
                    m = mini(m,self.right.list[0])
                    m1 = max(m1,self.right.list[1])
                    if self.right.left:
                        m = mini(m,self.right.left.minmax[0])
                        m1 = max(m1,self.right.left.minmax[1])
                    if self.right.right:
                        t = self.right.right.restrict(l,r)
                        m = mini(m,t[0])
                        m1 = max(m1,t[1])
                else:
                    t = self.right.restrict(l,r)
                    m = mini(m,t[0])
                    m1 = max(m1,t[1])
            if self.left:
                t = self.left.restrict(l,r)
                m = mini(m,t[0])
                m1 = max(m1,t[1])
            return (m,m1)
        elif l > self.data:
            if self.right:
                return self.right.restrict(l,r)
            else:
                return (0,0)
        else:
            if self.left:
                return self.left.restrict(l,r)
            else:
                return (0,0)
    def maximum(self,l,r):
        if self == TreeNode(0):
            return "NULL"
        else:
            t = self.restrict(l,r)
            if t[0] == 0 or t[1] == 0:
                return "NULL"
            else:
                return (t[1]-t[0])
i = 0
l0 = TreeNode(0)
l = []
n = eval(input())
for i in range(0,n):
    p = input().split()
    if p[0] == 'ADD':
        l0 = l0.insert_node((eval(p[1]),eval(p[2]),eval(p[3])))
    else:
        l.append(l0.maximum(eval(p[1]),eval(p[2])))
for i in l:
    print(i)