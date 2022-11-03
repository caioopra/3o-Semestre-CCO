clc
clear

# otimização: armazena em apenas uma matriz
  # não usa a diag. principal de U (=1), a armazena em L (nos termos que são 0)

a = [4 2 3; 2 -4 -1; -1 1 4];
b = [7 1 -5];
n = length(b);

copia_a = a;  # precisa da copia de a para residuo

# CALCULO DE L & U
for k = 1 : n
    for i = k : n
        # um somatorio para cada linha (antes de calcular L)
        soma = 0;
        for t = 1 : k-1
            soma = soma + a(i, t) * a(t, k);
        endfor
        a(i, k) = a(i, k) - soma;
    endfor
    
    # calculo de U
    for j = k + 1 : n
          # somatorio
          soma = 0;
          for t = 1 : k - 1
                soma = soma + a(k, t) * a(t, j); 
          endfor
          a(k, j) = (a(k, j) - soma) / a(k, k);
    endfor
endfor
a

# Ly = b  => caso tenha vários sistemas, mas com mesmo b, pode decompor apenas uma vez
# encontrando y (substituição direta)
# varre sistema de cima para baixo e encontra y
y(1) = b(1) / a(1, 1);
for i = 2 : n
    soma = 0;
    for j = 1 : (i - 1)
        soma = soma + a(i, j) * y(j);
    endfor
    y(i) = (b(i) - soma) / a(i, i);
endfor

# Ux = y  => tring. sup
# substituição direta
x(n) = y(n); 
for i = n-1 : -1 : 1
    soma = 0;
    for j = i + 1 : n
        soma = soma + a(i, j) * x(j);
    endfor
    x(i) = (y(i) - soma);  # U(i, i) = 1
endfor

y
x

# residuo
r = abs(b' - copia_a * x')