clear
clc
format long

# pivotamento parcial: trocando linhas
# entrada
# a = matriz de coeficientes
# b = vetor de termos independentes

sistema = [1 -1 1; 2 3 -1; -3 1 1];
b = [1 4 -1];
n = length(b);

# para o calculo do residuo
copia_sistema = sistema;
copia_b = b;

# escalonamento
for k = 1 :  (n - 1)
    # processo de  troca das linhas
    # encontrar maior elemento em modulo
    maior = abs(sistema(k, k));  # considerando a(k,k) o maior inicialmente
    pivo = k;   # linha pivo
    # percorrendo as linhas para procurar o maior pivo
    for i = k + 1 : n
        if (abs(sistema(i, k)) > maior)
            maior = abs(sistema(i, k));
            pivo = i;  # linha do maior pivo em modulo
        endif
    endfor
    
    if (pivo > k)   # se a linha pivo for maior do que k, troca
        # processo de trocar as linhas
        # TROCANDO AS LINHAS FISICAMENTE!
        for j = k : n
            aux = sistema(k, j);
            sistema(k, j) = sistema(pivo, j);
            sistema(pivo, j) = aux;
        endfor
        # troca o vetor de termos independentes b
        aux = b(k);
        b(k) = b(pivo);
        b(pivo) = aux;
    endif
    
    # triangularizacao da matriz
    for i = (k + 1) : n
        multiplicador = sistema(i, k) / sistema(k, k);
        for j = k : n
            sistema(i, j) = sistema(i, j) - multiplicador * sistema(k, j);
        endfor
        b(i) = b(i) - multiplicador * b(k);
    endfor
endfor

# retrossubstituição
x(n) = b(n) / sistema(n, n);

for i = (n - 1) : -1 : 1  # inicio : passo : parada
  soma = 0;
  
  # somatorio
  for j = (i + 1) : n;
    soma += sistema(i, j) * x(j);
  endfor
  
  x(i) = (b(i) - soma) / sistema(i, i);
endfor

printf("Resultado: \n");
sistema
b
printf("Solução: \n")
x

# calculo do residuo
residuo = abs(copia_b' - copia_sistema * x')'