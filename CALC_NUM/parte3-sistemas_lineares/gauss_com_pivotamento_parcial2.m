clear
clc
format long

# pivotamento parcial: trocando linhas, sem troca fisica
# entrada:
# sistema = matriz de coeficientes
# b = vetor de termos independentes

sistema = [1 1 1.5 1 1.5 0 0 0 0 0;
           0 1 0.01 0.51 1.5 0.5 0 0 0 0;
           2.9 1 2 1 1 0 5 0 0 0;
           9 1 0.2 1 1 0 0 1.5 0 0;
           1 0 2 0 0 1 1 1 0 2;
           0 1 0 0 -2 0 1 -1 1 1 ;
           1 0 2 0 0 0 1 1 1 0;
           0 1 0 0 2 0 1 1 1 -1;
           0 0 1 0 2 1 -1 0 -1 -1;
           0 1 0 0 2 0 1 0 1 1];

b = [4 -3 1 -1 -1 0 -1 1 3 -2];

n = length(b);

# para o calculo do residuo
copia_sistema = sistema;
copia_b = b;

# vetor de indices -> o[] = [1, 2, 3, ..., n]
for i = 1 : n
    o(i) = i;
endfor


# escalonamento
for k = 1 :  (n - 1)
    # processo de  troca das linhas

    maior = abs(sistema(o(k), k));  # considerando a(k,k) o maior inicialmente
    pivo = k;   # linha pivo

    # percorrendo as linhas para procurar o maior pivo
    for i = k + 1 : n
        if (abs(sistema(o(i), k)) > maior)
            maior = abs(sistema(o(i), k));
            pivo = i;  # linha do maior pivo em modulo
        endif
    endfor

    if (pivo > k)
        # SEM TROCA DE LINHAS FISICAMENTE
        aux = o(k);
        o(k) = o(pivo);
        o(pivo) = aux;
    endif

    # triangularizacao da matriz
    for i = (k + 1) : n
        multiplicador = sistema(o(i), k) / sistema(o(k), k);
        for j = k : n
            sistema(o(i), j) = sistema(o(i), j) - multiplicador * sistema(o(k), j);
        endfor
        b(o(i)) = b(o(i)) - multiplicador * b(o(k));
    endfor
    sistema
    b
    o
    pause
endfor

# retrossubstituição
x(n) = b(o(n)) / sistema(o(n), n);

for i = (n - 1) : -1 : 1  # inicio : passo : parada
  soma = 0;

  # somatorio
  for j = (i + 1) : n;
    soma += sistema(o(i), j) * x(j);
  endfor

  x(i) = (b(o(i)) - soma) / sistema(o(i), i);
endfor

sistema
b
x
o

# calculo do residuo
r = abs(copia_b' - copia_sistema * x')'
