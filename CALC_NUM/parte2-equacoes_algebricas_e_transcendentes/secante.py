from hashlib import new
from math import exp, cos, sin


def function(x: float) -> float:
    return exp(x) - 2 * cos(x)


# precisao desejada para o algoritmo
erro_admitido = 10**-15

# aproximações iniciais considerando o intervalo
x0 = 2
x1 = 0

fx0 = function(x0)
fx1 = function(x1)

k = 0
while abs(fx1) > erro_admitido:
    xk = x1 - ((x1 - x0) * fx1) / (fx1 - fx0)

    x0 = x1
    fx0 = fx1
    x1 = xk
    fx1 = function(x1)

    k += 1

print("Método da Secante:")
print(f"Número de iterações: {k}")
print(f"Valor aproximado da raiz = {xk}")
print(f"Precisão obtida: {fx1 - erro_admitido}\n")

print("---" * 20)

# implementação do método de Newton para comparações
def derivada(x: float) -> float:
    return exp(x) + 2 * sin(x)


newton_x0 = 1
newton_fx = function(newton_x0)
newton_xk = 0

newton_k = 0
while abs(newton_fx) > erro_admitido:
    dx = derivada(newton_x0)
    newton_xk = newton_x0 - newton_fx / dx

    newton_x0 = newton_xk
    newton_fx = function(newton_x0)

    newton_k += 1

print("\nComparações do método da Secante com o método de Newton:\n")

print(f"Número de iterações:\n - Newton : {newton_k}\n - Secante: {k}")
print(f"Valor da raiz:\n - Newton : {newton_xk}\n - Secante: {xk}")
print(
    f"Precisão:\n - Newton : {newton_fx - erro_admitido}\n - Secante: {fx1 - erro_admitido}"
)
