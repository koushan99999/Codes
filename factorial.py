def factorial(n):
    f = 1
    if (n > 0):
        while (n > 0):
            f = f * n
            n = n - 1
    else:
        while (n < 0):
            f = f * (- n)
            n = n + 1
    return f
while True:
    n = eval(input("Enter a number: "))
    print (factorial (n))
