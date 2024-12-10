MOD = 10**9 + 7
m = int(input())
# Transition matrix:
def matrix_mult(A,B):
    C = [[0,0],[0,0]]
    for i in range(0,2):
        for j in range(0,2):
            for k in range(0,2):
                C[i][j] = (C[i][j] + A[i][k] * B[k][j]) % MOD
    return C
def matrix_pow(M,p):
    if p == 1:
        return M
    elif p % 2 == 0:
        return matrix_pow(matrix_mult(M,M), p//2)
    else:
        return matrix_mult(M, matrix_pow(M, p-1))
def count(m):
    M = [[19,7],[6,20]]
    Mp = matrix_pow(M,m)
    final_state = Mp[0][0]
    return final_state
count = count(m) % MOD
print(count)
