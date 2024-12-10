def isTrue():
    print("True")
    return True
def isFalse():
    print("False")
    return False
# run isFalse() and isTrue()
# run isTrue() and isFalse()
# in 1st command isFalse() is printing "False" and returning false for which the next function is not working
l1 = [1,2,3]
l2 = l1
l1.append(4)
print(l1)
print(l2)
l1 = [1,2,3]
l2 = l1
l1 = l1 + [4]
print(l1)
print(l2)
s1 = "abc"
s2 = s1
s1 = s1 + "def"
print(s1)
print(s2)
# here append() is not defined for strings.
# append() just modifies the previous value of the variable.
# but '+' creates a new copy of the value after changing with commands.
# so in 1st case for append() the value just changed which was pointed by l1 and l2. so changes came into the output.
# but in 2nd case '+' creates a new changed copy which is not pointed by l2 just pointed by l1. so no change in output.
l1 = [[1,2,3],4]
l2 = l1
l1[0] = l1[0]+[4]
print(l1)
print(l2)
# here l2 points the entire list l1. so doesn't problem if anything inside list changes. 
