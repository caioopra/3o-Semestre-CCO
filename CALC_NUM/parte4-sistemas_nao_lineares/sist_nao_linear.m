clc
clear
format long

# d =  J\F' (resolve sistema)
# algoritmo funciona para esse caso em particular
# mudando o sistema, mudaria equações e resolução

x = [1; -1]; # estimativa inicial (vetor coluna)
erro = 10^-8;
k = 0;  # numero de repetições

erro_avaliado = 1;  # qualquer valor maior que o erro inicialmente
while (erro_avaliado > erro)
    k++;
    # montando Jacobiana manualmente (forma fixa)
    J(1, 1) = exp(x(1));
    J(1, 2) = 1;
    J(2, 1) = 2 * x(1);
    J(2, 2) = 2 * x(2);

    # calculando F
    F(1) = exp(x(1)) + x(2) - 1;
    F(2) = x(1)^2 + x(2)^2 - 4;

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
