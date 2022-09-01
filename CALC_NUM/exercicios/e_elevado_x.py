from math import exp

x = 2
exato = exp(x)

soma = 1
fatorial = 1
erro = abs(exato - soma)
erro_admitido = 10 ** (-14)

i = 1
while erro > erro_admitido:
    fatorial *= i
    soma += x**i / fatorial
    erro = abs(exato - soma)

    i += 1

print(soma)
