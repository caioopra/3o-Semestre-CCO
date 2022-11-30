function Interpolacao

clear
clc

x = [-1 0 1];
y = [4; 1; -1];
n = length(x);
grau = n - 1;

for i = 1 : n
    for j = 1 : n
        V(i, j) = x(i)^(j-1);
    endfor
endfor

a = V\y

xx = 0.5;  # ponto para interpolar
px = avalia(xx, n, a)
x1 = [x(1):0.2:x(n)];   # gera pontos intermediários
n1 = length(x1);

for j = 1 : n1
    p(j) = avalia(x1(j), n, a);
endfor
p

plot(x, y, '*')
grid
hold on
plot(x1, p, 'r')
hold on
plot(xx, px, 'go')

endfunction


function p = avalia(xx, n, a)
p = 0;
for i = 1 : n
    p = p + a(i) * xx ^(i-1);
endfor
p
endfunction

