import random
requiredNumbers = 20 # of numbers will be generated
lowerbound = 0 # lower bound of generated number
upperbound = 1000 # upper bound of generated number
if __name__ == '__main__':
    for i in range(requiredNumbers):
        a = random.randrange(0,upperbound - lowerbound) + lowerbound
        b = random.randrange(0,upperbound - lowerbound) + lowerbound
        # def of function: func(a,b,..)