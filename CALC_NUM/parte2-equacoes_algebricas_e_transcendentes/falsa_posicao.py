from math import exp, cos


def funcao(x: float) -> float:
    return exp(x) - (2 * cos(x))


def calcular_xm(a: float, b: float, funcao_a: float, funcao_b: float) -> float:

    return a - ((funcao_a * (b - a)) / (funcao_b - funcao_a))


# valores iniciais das variaveis e constantes
erro_admitido = 10**-12

a = 0
b = 2
xm = calcular_xm(a, b, funcao(a), funcao(b))
funcao_xm = funcao(xm)

while abs(funcao_xm) > erro_admitido:
    funcao_a = funcao(a)
    funcao_b = funcao(b)

    xm = calcular_xm(a, b, funcao_a, funcao_b)
    funcao_xm = funcao(xm)

    if (funcao_a * funcao_xm) < 0:
        b = xm
    else:
        a = xm

print(xm)
