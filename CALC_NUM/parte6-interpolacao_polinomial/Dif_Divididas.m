function Dif_Divididas
clear
clc

x = [0 1 2 3];
y = [-3 -2 4 0];
n = length(x);

ponto_interpolar = 2.5;
interpolado = Newton(x, y, n, ponto_interpolar);
printf("Interpolando o ponto 2.5: %d\n", interpolado)

# interpolando os pontos em x
for i = 1 : n
    interpolado = Newton(x, y, n, x(i));
    printf("Interpolando o ponto %d: %d\n", x(i), interpolado)
endfor

endfunction


function P = Newton(x, y, n, ponto_interpolar)
for i = 1 : n
    a(i, 1) = y(i);
endfor

for j = 2 : n
  for i = j : n
      a(i,j) = (a(i,j-1) - a(i-1, j-1))/(x(i) - x(i-j+1));
  endfor
  endfor

# calculando P
P = 0;
for i = 1 : n
    mult = 1;
    for j = 1 : i-1
        mult *= ponto_interpolar - x(j);
    endfor
    P += mult * a(i, i);
endfor
P;
endfunction
