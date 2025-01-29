chiP = 1;
chiR = 1;
omega = 1;
mu = 1;

[X,Y] = meshgrid(0:0.25:4, 0:0.25:4);
Uprot = omega * Y - chiP * X;
Vrna = mu - chiR * Y;




Xprot = 0:0.1:4;
dprotdt = (chiP .* Xprot) / omega;
drnadt = mu/chiR;

plot(Xprot, dprotdt, DisplayName='dprotdt');
hold on;
quiver(X,Y,Uprot,Vrna, DisplayName='trajectory');
yline(drnadt, DisplayName='drnadt');
xlabel('[Xprot]');
ylabel('[Xrna]');
title('nullcline visualizations');
legend
hold off;