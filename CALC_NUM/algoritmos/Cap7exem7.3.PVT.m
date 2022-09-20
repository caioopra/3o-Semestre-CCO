clear
clc
format long
m=21; % Número de pontos experimentais
v = [6.85 7.95 5.31 5.24 8.02 8.83 6.39 6.72 8.79 8.17 7.89 6.86 7.47 8.91 6.27 5.58 6.29 8.50 7.29 8.39 5.99];
T = [382. 320. 416. 365. 375. 431. 446. 346. 360. 461. 306. 425. 425. 415. 322. 329. 368. 355. 443. 301. 408.];
P = [543. 382. 803. 715. 443. 457. 688. 503. 384. 535. 369. 602. 546. 436. 509. 596. 579. 393. 585. 339. 679.];
R = 8.314;

xi=[1.; 1.;]
%for k=1:m  P(k)=funcaoP(xi(1),xi(2),R,v(k),T(k));  end
%printf("\n");for k=1:m printf("%.0f ",P(k)); end

x=fNewtonNnumFa(2,xi);
a=x(1)
b=x(2)

desvioslocais=funcaoP(a,b,R,v,T).-P
desviomedioP=sum(desvioslocais)/m  %media nula indica disribuição randomica de erros
R2=fCoefDeterminacaoPvT(a,b,m,R,P,v,T)

% Construindo grafico3D da superficie P-v-T:
fgrafico3D_exem7_3(m,v,T,P,R,a,b)
%fgrafico2D_exem7_3(m,v,T,P,R,a,b)
%grid on
