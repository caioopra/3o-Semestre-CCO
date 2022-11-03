clc
clear

a = [4 2 3; 2 -4 -1; -1 1 4];
b = [7 1 -5];
n = length(b);

# CALCULO DE L & U
for k = 1 : n
    for i = k : n
        # um somatorio para cada linha (antes de calcular L)
        soma = 0;
        for t = 1 : k-1
            soma = soma + L(i, t) * U(t, k);
        endfor
        L(i, k) = a(i, k) - soma;
    endfor
    
    # calculo de U
    U(k, k) = 1;    # diagonal principal (k, k) = 1
    for j = k + 1 : n
          # somatorio
          soma = 0;
          for t = 1 : k - 1
                soma = soma + L(k, t) * U(t, j); 
          endfor
          U(k, j) = (a(k, j) - soma) / L(k, k);
    endfor
endfor

# Ly = b  => caso tenha vários sistemas, mas com mesmo b, pode decompor apenas uma vez
# encontrando y (substituição direta)
# varre sistema de cima para baixo e encontra y
y(1) = b(1) / L(1, 1);
for i = 2 : n
    soma = 0;
    for j = 1 : (i - 1)
        soma = soma + L(i, j) * y(j);
    endfor
    y(i) = (b(i) - soma) / L(i, i);
endfor

# Ux = y  => tring. sup
# substituição direta
x(n) = y(n) / U(n, n);
for i = n-1 : -1 : 1
    soma = 0;
    for j = i + 1 : n
        soma = soma + U(i, j) * x(j);
    endfor
    x(i) = (y(i) - soma) / U(i, i);  # U(i, i) = 1
endfor

y
x

# residuo
r = abs(b' - a * x')