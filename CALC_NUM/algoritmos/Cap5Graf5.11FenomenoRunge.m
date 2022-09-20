clear
clc
% Neste exemplo usaremos a interpolação para demonstrar o fenomeno de Runge:
%1. Polinomial com m pontos equidistantes;
%2. Polinomial com mk pontos definidos pelos 'nós' do polinomio de grau nk=mk-1 de Chebyschev;
%3. Por polinomiais splines cubicas.
clear
a=-1 %valor inicial do intervalo
b=+1 %valor final   do intervalo

%1.Polinomial com pontos equidistantes;
n=5 %numero de subdivicoes do intervalo [a; b] para n+1 pontos
m=n+1;
x=a:((b-a)/n):b    % valores de x equidistantes
y=1./(1.+25.*x.*x) % valores exatos da função f(x) para os n+1 pontos tabelados
% Cálculo por interpolação polinomial
difdiv1=fdifdiv(n,x,y); %vetor com diferenças de ordem k=1:n no ponto i = 1 
np=10*n % numero de subdivicoes para serem plotados
xp= a:((b-a)/np):b; % (np+1) pontos x a serem plotados
yp=fgregoryn(n,x,y,difdiv1,xp); %y aproximado por Pn(x) para cada xp(i)

n=7 %numero de subdivicoes do intervalo [a; b] para n+1 pontos
m=n+1;
x=a:((b-a)/n):b    % valores de x equidistantes
y=1./(1.+25.*x.*x) % valores exatos da função f(x) para os n+1 pontos tabelados
% Cálculo por interpolação polinomial
difdiv1=fdifdiv(n,x,y); %vetor com diferenças de ordem k=1:n no ponto i = 1 
np=20*n % numero de subdivicoes para serem plotados
xp2= a:((b-a)/np):b; % (np+1) pontos x a serem plotados
yp2=fgregoryn(n,x,y,difdiv1,xp2); %y aproximado por Pn(x) para cada xp(i)

ye=1./(1.+25.*xp2.*xp2); %valores exatos de y

plot(xp,yp,'-.k','LineWidth',2,xp2,yp2,'--k','LineWidth',2,xp2,ye,'-k','LineWidth',3) %xp,ypk,'-k','LineWidth',3,xpp,ypp,'--k','LineWidth',1)
legend()
ylim([-0.2 1.3])
