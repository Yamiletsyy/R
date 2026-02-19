N <- 10000
n <- 1:N

# x = 1
S1 <- sum(((-1)^(n+1) / n) * 1^n)
print(S1)

# x = 2
S2 <- sum(((-1)^(n+1) / n) * 2^n)
print(S2)
