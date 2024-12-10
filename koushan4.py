def prime(p):
    div = [x for x in range(2,p-1) if p%x == 0]
    if div == []:
        return True
    else:
        return False
def primefactor(n,k):
    prompt = ""
    for i in range(k,n+1):
        if n%i == 0:
            if prime(i):
                prompt = primefactor(divide(n,i),(i+1)) + " " + str(i) + prompt
                break
    return prompt
def divide(n,k):
    if n%k == 0:
        return divide(n//k,k)
    else:
        return n
n = eval(input())
p = primefactor(n,2)
p = p.lstrip()
print(p)