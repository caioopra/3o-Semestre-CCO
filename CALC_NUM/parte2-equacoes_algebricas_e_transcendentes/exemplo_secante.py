from math import sqrt


def function(x: float) -> float:
    return x**2 - 5


erro_admitido = 10**-15

x0 = 2
fx0 = function(x0)

x1 = 0
fx1 = function(x1)

while abs(fx1) > erro_admitido:
    xk = x1 - ((x1 - x0) * fx1) / (fx1 - fx0)

    x0 = x1
    fx0 = fx1
    x1 = xk
    fx1 = function(x1)

print(f"xk = {xk}")
print(f"Valor exato para raiz de 5 = {sqrt(5)}")
