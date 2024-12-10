class TrieNode(object):
    def __init__(self, char):
        self.data = char
        self.next = []
        self.word = char
def inser(self,word):
    node = self
    for char in word:
        datafind = False
        for child in node.next:
            if char == child.data:
                node = child
                datafind = True
                break
        if datafind == False:
            n = len(node.next)
            if n == 0:
                newnode = TrieNode(char)
                newnode.word = node.word + char
                node.next.append(newnode)
                node = newnode
                datafind = True
            else:
                for i in range(0,n):
                    if char < (node.next[i]).data:
                        newnode = TrieNode(char)
                        newnode.word = node.word + char
                        node.next.insert(i,newnode)
                        node = newnode
                        datafind = True
        if datafind == False:
            newnode = TrieNode(char)
            newnode.word = node.word + char
            node.next.append(newnode)
            node = newnode
            datafind = True
def sorted(self):
    l = []
    node = self
    n = len(node.next)
    if n == 0:
        return [node.word]
    else:
        for i in range(0,n):
            l += sorted(node.next[i])
    return l
p = TrieNode('')
inser(p,"messi")
inser(p,"ronaldo")
inser(p,"salah")
inser(p,"mane")
inser(p,"sane")
inser(p,"sancho")
inser(p,"mbappe")
inser(p,"veratti")
print(sorted(p))