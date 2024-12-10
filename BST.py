class Node:
    def __init__(self, element):
        self.element = element
        self.left = None
        self.right = None
# find an element in BST and return whether it is inside or not
def find(BST, e):
    if BST.element == None:
        return False
    elif BST.element == e:
        return True
    elif BST.element > e:
        if BST.right:
            find(BST.right, e)
        else:
            return False
    elif BST.element < e:
        if BST.left:
            find(BST.left, e)
        else:
            return False
# insert an element maintaning the condition of a BST
def insert(BST, value):
    if BST.element == None:
        BST.element = value
        BST.left = None
        BST.right = None
        return BST
    elif BST.element == value:
        return BST
    elif BST.element > value:
        if BST.left:
            insert(BST.left, value)
        else:
            BST.left = Node(value)
            return BST
    elif BST.element < value:
        if BST.right:
            insert(BST.right, value)
        else:
            BST.right = Node(value)
            return BST
# delete the maximum element from a BST and return the pair of the element and the new BST
def deletemax(BST):
    e = 0
    if BST.element == None:
        return (e, BST)
    elif BST.right == None:
        e = BST.element
        return (e, BST.left)
    else:
        (x,y) = deletemax(BST.right)
        e = x
        BST.right = y
        return (e, BST)
# delete an element from a BST
def delete(BST, e):
    if BST.element == None:
        return BST
    if BST.element > e:
        if BST.right:
            BST.right = delete(BST.right, e)
        else:
            return BST
    if BST.element < e:
        if BST.left:
            BST.left = delete(BST.left, e)
        else:
            return BST
    if BST.element == e:
        if BST.right:
            (x, y) = deletemax(BST.left)
            BST.element = x
            BST.left = y
        else:
            BST.element = BST.left.element
            BST.left = BST.left.left
            BST.right = BST.left.right
# reflection of a BST
def mirror(BST):
    if BST.element == None:
        return BST
    else:
        BST.left = mirror(BST.right)
        BST.right = mirror(BST.left)
        return BST
# height of a BST
def height(BST):
    h = 0
    if BST.element == None:
        return h
    else:
        h = h + 1 + max(height(BST.left), height(BST.right))
        return h
# rotate to right
def rightrotate(BST):
    tree = None
    tree = Node(BST.left.element)
    tree.left = BST.left.left
    tree.right = Node(BST.element)
    tree.right.left = BST.left.right
    tree.right.right = BST.right
    return tree
# rotate to left
def leftrotate(BST):
    tree = None
    tree = Node(BST.right.element)
    tree.left = Node(BST.element)
    tree.left.left = BST.left
    tree.left.right = BST.right.left
    tree.right = BST.right.right
    return tree
# balancing a BST
def slope(BST):
    slope = height(BST.left) - height(BST.right)
    return slope
def balance(BST):
    if BST.element == None:
        return BST
    else:
        if slope(BST) >= 2:
            if slope(BST.left) >= 0:
                rightrotate(BST)
            elif slope(BST.right) <= -1:
                BST.left = leftrotate(BST.left)
                rightrotate(BST)
        elif slope(BST) <= -2:
            if slope(BST.right) <= 0:
                leftrotate(BST)
            elif slope(BST.right) >= 1:
                BST.right = rightrotate(BST.right)
                leftrotate(BST)
        return BST