# metodo de Newton para a função e"x * sen(x) - 1

from math import exp, sin, cos


def funcao(x: float) -> float:
    return exp(x) * sin(x) - 1


def derivada(x: float) -> float:
    return exp(x) * sin(x) + exp(x) * cos(x)


# variavle de entrada (xk-1)
x0 = 1
erro = 10**-8

fx = funcao(x0)
while abs(fx) > erro:
    dx = derivada(x0)
    xk = x0 - fx / dx

    x0 = xk
    fx = funcao(x0)

print(f"{xk=}")
