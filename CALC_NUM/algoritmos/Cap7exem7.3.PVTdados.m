clear
clc
format short
m=21; % Número de pontos experimentais
%v=[ 5.0 5.2 5.4 5.6 5.8 6.0 6.2 6.4 6.6 6.8 7.0 7.2 7.4 7.6 7.8 8.0 8.2 8.4 8.6 8.8 9.0  ];
for i=1:m v(i)=5+4.*rand(); end
%T=sort([ 300. 310.5 321. 331.5 342. 352.5 363. 373.5 384.0 394.5 405.0 415.5 426.0 436.5 447.0 457.5 468. 478.5 489. 499.5 510 ]);
for i=1:m T(i)=300+200.*rand(); end
%P=[ 623. 614. 606. 599. 592. 586. 580. 575. 570. 565. 561. 557. 553. 549. 546. 543. 540. 537. 534. 532. 530. ];
R = 8.314;
a=1.;b=1.
P=funcaoP(a,b,R,v,T);
v=transpose(v)
T=transpose(T)
P=transpose(P)
% Construindo grafico3D da superficie P-v-T:
fgrafico3D_exem7_3(m,v,T,P,R,a,b)
%fgrafico2D_exem7_3(m,v,T,P,R,a,b)
%grid on
