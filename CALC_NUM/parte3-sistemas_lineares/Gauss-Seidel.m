clc
clear

# sistema de entrada
#a = [3 -1 -1; 1 3 1; 2 -2 4];
#b = [1 5 4];
a = [3 4 3; 1 5 -1; 6 3 7];
b = [10 7 15];
n = length(b);

# estimativa inicial
x0 = zeros(1, n);  # vetor de 1 linha n colunas de 0s
xa = x0;    # x anterior; salva para calcular d

erro = 10^-7;  # precisao
d = 1;  # valor qualquer maior que erro

k = 0;   # numero de iterações
while (d > erro)
    k += 1;
    for i = 1 : n
        soma = 0;
        for j = 1 : n
            if j ~= i
                soma += a(i, j) * x0(j);
            endif
        endfor
        x0(i) = (b(i) - soma) / a(i, i);
    endfor
    # depois de terminado todas as linhas
    d = sum(abs(x0-xa));  # poder usar norma1(sum) ou max
    xa = x0
    pause
endwhile

k
d
x0
