from math import exp, cos, sin


def funcao(x: float) -> float:
    return exp(x) - (2 * cos(x))


def derivada(x: float) -> float:
    return exp(x) + (2 * sin(x))


x0 = 1
fx = funcao(x0)
erro_admitido = 10**-15

xk = 0

while abs(fx) > erro_admitido:
    dx = derivada(x0)
    xk = x0 - fx / dx

    x0 = xk
    fx = funcao(x0)

print(f"xk = {xk}")
