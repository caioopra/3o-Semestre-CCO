from math import exp, cos

erro_admitido = 10 ** -15
# valores iniciais das variaveis
a = 0
b = 2
xm = (a + b) / 2
erro = abs(a - b)


def calcular_xm(a: float, b:float) -> float:
    return (a + b) / 2


def funcao(x: float) -> float: 
    return exp(x) - (2 * cos(x))


while erro > erro_admitido:
    xm = calcular_xm(a, b) 
    funcao_a = funcao(a)
    funcao_xm = funcao(xm)
    
    if (funcao_a * funcao_xm) < 0: 
        b = xm
    else:
        a = xm
    
    erro = abs(a - b)

print(xm)
