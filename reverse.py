def reverse (n):
    s = 0
    while (n > 0):
        r = 0
        r = n%10
        s = s * 10 + r
        n = (n - r)/10
    return s
while True:
    n = eval(input("Enter a number: "))
    print ("The reverse of the number is: " + str(reverse (n)))
        
