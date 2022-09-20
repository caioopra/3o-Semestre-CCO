function fgrafico3D_exem7_3(m,v,T,P,R,a,b)
% Calculando passos:
n=20
   % Definindo pontos:
vp = linspace (min(v), max(v), n)';
Tp = linspace (min(T), max(T), n)';
[vx, Ty] = meshgrid (vp, Tp);
Pp=R.*Ty./(vx.-b).-a./(sqrt(Ty).*vx.*(vx.+b));

% Plotando:
  surf(vp,Tp,Pp)
  %mesh(vp,Tp,Pp)
  xlabel('v(m3/mol)')
  ylabel('T(K)')
  zlabel('P(Pa)')
  grid on
  axis square
  hold on
  plot3(v,T,P,'*k','markersize',10,'linewidth',5)
  %hold off
end