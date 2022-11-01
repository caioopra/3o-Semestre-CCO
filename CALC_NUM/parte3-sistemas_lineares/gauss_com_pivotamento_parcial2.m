clear
clc
format long

# pivotamento parcial: trocando linhas, sem troca fisica
# entrada:
# sistema = matriz de coeficientes
# b = vetor de termos independentes

sistema = [1 -1 1; 2 3 -1; -3 1 1];
b = [1 4 -1];
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
    # encontrar maior elemento em modulo
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
        for j = k : n
            aux = o(k);
            o(k) = o(pivo);
            o(pivo) = aux;
        endfor
    endif
    
    # triangularizacao da matriz
    for i = (k + 1) : n
        multiplicador = sistema(o(i), k) / sistema(o(k), k);
        for j = k : n
            sistema(o(i), j) = sistema(o(i), j) - multiplicador * sistema(o(k), j);
        endfor
        b(o(i)) = b(o(i)) - multiplicador * b(o(k));
    endfor
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

printf("Resultado: \n");
sistema
b
printf("Solução: \n")
x
o

# calculo do residuo
residuo = abs(copia_b' - copia_sistema * x')'