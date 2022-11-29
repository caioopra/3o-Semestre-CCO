clc
clear

# tabela de pontos
x = [1 3 4 6];
y = [2.5 13 22 36];
z = log(y);   # ln(y)
n = length(x);
M = 1;  # sempre 1 (linearizado -> exponencial)

for i = 1 : M+1
    for j = i : M+1
        a(i, j) = 0;
        for k = 1 : n
            a(i, j) = a(i, j) + x(k)^(j+i-2);
        endfor
    endfor
    a(j, i) = a(i, j);

    b(i) =  0;
    for k = 1 : n
        b(i) = b(i) + z(k) * x(k)^(i-1);
    endfor
endfor

a
b
c = a \ b';
c = exp(c);
c

# montando o gráfico
for i = 1 : n
    g(i) = c(1) * c(2)^x(i);
endfor
g;

plot(x,y,'o')
grid
hold on
plot(x, g, 'r')

