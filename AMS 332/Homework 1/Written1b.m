chiP = 1;
chiR = 1;
omega = 1;
mu = 1;

Xprot = 0:0.1:4;
dprotdt = (chiP .* Xprot) / omega;
drnadt = mu/chiR;

plot(Xprot, dprotdt, DisplayName='dprotdt');
hold on;
yline(drnadt, DisplayName='drnadt');
xlabel('[Xprot]');
ylabel('[Xrna]');
title('nullcline visualizations');
legend
hold off;