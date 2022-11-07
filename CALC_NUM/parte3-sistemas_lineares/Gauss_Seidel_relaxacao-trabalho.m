clc
clear
format long

a = [62 24 1 8 15;23 50 7 14 16;4 6 58 20 22;10 12 19 66 3;11 18 25 2 54];
b = [110 110 110 110 110];
n = length(b);
x0 = zeros(1, n);  # estimativa inicial = [0 0 0 0 0]
w = 1.0801;    # relaxação (w=1 -> Gauss Seidel

xa = x0;    # xa = x anterior (xk-1); salva para calcular d

erro = 10^-10;    # precisao
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
        x0(i) = (1-w) * x0(i) + w * (b(i) - soma) / a(i, i);
    endfor
    # depois de terminado todas as linhas
    d = max(abs(x0-xa));  # poder usar norma1(sum) ou max
    xa = x0;
endwhile

# mostra número de iterações, solução e precisão
k
x0
d

#{

========================
RESPOSTAS
========================
a)
    soma linha 1 = 48   (a(1, 1) = 62 > 48)  -> OK
    soma linha 2 = 60   (a(2, 2) = 50 < 60) -> X
    soma linha 3 = 52   (a(3, 3) = 58 > 52) -> OK
    soma linha 4 = 44   (a(4, 4) = 66 > 44) -> OK
    soma linha 5 = 56   (a(5, 5) = 54 < 56) -> X

    Portanto, não é verdade que o valor da soma dos valores da linha,
    com exceção do valor membro da diagonal princiapal, é menor do que o valor
    não somado (|a(i,i) >= Si), entretanto, há dois casos em que é verdade, logo
    há a possibilidade de convergência, ainda que sem a garantia; soma-se a isso
    o fato do sistema ser irredutível.

b)
    Número de iterações: 22
    Solução: [1   1   1   1   1]
    Precisão: 4.025690891751310e-11

c)
   Substituindo o valor de w por 0.95 (w < 1), houve aumento no número de iterações
   realizadas; para outro valor menor do que um, com w = 0.98, o número de iterações
   ainda é maior, sendo igual a 23. Portanto, sub-relaxação não auxilia na velocidade
   de execução para o sistema.

   Com valor de w > 1, percebe-se diminuição no número de iterações com o valor de 1.1,
   com 17 iterações; aumentando o valor para 1.2, volta a haver queda no desempenho,
   indicando que o valor ideal está mais próximo de 1.1. Após alguns valores testados,
   conclui-se que um fator ótimo w seria 1.0801, o qual chega no mesmo resultado
   para o sistema, mas com:
     - Número de iterações: 16
     - Precisão: 1.770117386001857e-11

#}
