clear
clc
format long

# entrada
# sistema = matriz de coeficientes
# b = vetor de termos independentes

sistema = [1 2 1 -1; 3 2 4 4; 4 4 3 4; 2 0 1 5];
b = [5 16 22 15];
n = length(b);

# escalonamento
for k = 1 :  (n - 1)
    for i = (k + 1) : n
      multiplicador = sistema(i, k) / sistema(k, k);
      for j = k : n
        sistema(i, j) = sistema(i, j) - multiplicador * sistema(k, j);
      endfor
      b(i) = b(i) - multiplicador * b(k);
    endfor
    pause
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
