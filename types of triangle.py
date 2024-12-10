def area(a,b,c): # area
    s = 0
    ar = 0
    s = (a + b + c)/2
    ar = (s * (s - a) * (s - b) * (s - c)) ** (1/2)
    return ar
def ang(a,b,c): # cosine rule
    cos = 0
    cos = (a**2 + b**2 - c**2)/(2 * a * b)
    return cos
def types(a,b,c):
    if (a + b > c) and (b + c > a) and (c + a > b):
        if (ang(a,b,c) > 0) and (ang(b,c,a) > 0) and (ang(c,a,b) > 0):
            if (a == b) and (b == c):
                print("It is an equilateral triangle.")
            elif (a == b) or (b == c) or (c == a):
                print("It is an isoceles acute angled triangle.")
            else:
                print("It is a scalene acute angled triangle.")
        elif (ang(a,b,c) < 0) or (ang(b,c,a) < 0) or (ang(c,a,b) < 0):
            if (a == b) or (b == c) or (c == a):
                print("It is an isoceles obtuse angled triangle.")
            else:
                print("It is an scalene obtuse angled triangle.")
        else:
            if (a == b) or (b == c) or (c == a):
                print("It is an isoceles right angled triangle.")
            else:
                print("It is an scalene right angled triangle.")
    else:
        print("It is not a triangle.")
def circumrad(a,b,c): # circumradius
    cr = 0
    cr = (a * b * c)/(4 * area(a,b,c))
    return cr
def inrad(a,b,c): # inradius
    ir = 0
    s = (a + b + c)/2
    ir = (s - a) * (((1 - ang(b,c,a))/(1 + ang(b,c,a))) ** (1/2))
    return ir
while True:
    a = eval(input("Enter a side of a triangle: "))
    b = eval(input("Enter another side of the triangle: "))
    c = eval(input("Enter another side of the triangle: "))
    print(types(a,b,c))
    print("The area of the triangle is: " + str(area(a,b,c)))
    print("The circumradius of the triangle is: " + str(circumrad(a,b,c)))
    print("The inradius of the triangle is: " + str(inrad(a,b,c)))