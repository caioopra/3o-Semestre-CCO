clc
clear
format long

# sistema2 = lista3a, exercicio 1

# d =  J\F' (resolve sistema)
# algoritmo funciona para esse caso em particular
# mudando o sistema, mudaria equações e resolução

##x = [1; -1]; # estimativa inicial (vetor coluna)
x = [0.5; 0.5; 0.5];
erro = 10^-8;
k = 0;  # numero de repetições

erro_avaliado = 1;  # qualquer valor maior que o erro inicialmente
while (erro_avaliado > erro)
    k++;
    # montando Jacobiana manualmente (forma fixa)
##    J(1, 1) = exp(x(1));
##    J(1, 2) = 1;
##    J(2, 1) = 2 * x(1);
##    J(2, 2) = 2 * x(2);

    J(1, 1) = 2 * x(1);
    J(1, 2) = 1;
    J(1, 3) = 1;
    J(2, 1) = 4 * x(1);
    J(2, 2) = 2 * x(2);
    J(2, 3) = -4;
    J(3, 1) = 6 * x(1);
    J(3, 2) = -4;
    J(3, 3) = 2 * x(3);

    # calculando F
##    F(1) = exp(x(1)) + x(2) - 1;
##    F(2) = x(1)^2 + x(2)^2 - 4;

    F(1) = x(1)^2 + x(2) ^ 2 + x(3) ^2 -1;
    F(2) = 2*(x(1)^2) + x(2)^2 -4 * x(3);
    F(3) = 3 * (x(1) ^2) - 4 * x(2) + x(3)^2;

    # calculando Delta
    # pode usar Eliminação Gaussiana com pivotamento parcial
    d = J\-F';    # resolve sistema linear (\)

    # proximo x
    x += d;

    # criterio de parada
    erro_avaliado = sum(abs(d));
    # ou com F tendendo a 0 (diferença tendendo a 0)
endwhile

k
x
erro_avaliado
