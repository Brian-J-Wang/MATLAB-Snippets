clear

omega = 0.1;
mu = 0.5;
xp = 0.025;
xr = 0.05;

timeStep = 0.01;
duration = 100;
timePoints = 0:timeStep:duration;

xprot(1) = 0;
xmrna(2) = 0;
for(i = 2:(duration/timeStep) + 1)
    dxprotdt(i - 1) = omega * xmrna(i - 1) - xp * (xprot(i - 1)); 
    dxmRNAdt(i - 1) = mu - xr * xmrna(i - 1);
    xprot(i) = xprot(i - 1) + (dxprotdt(i - 1) * timeStep);
    xmrna(i) = xmrna(i - 1) + (dxmRNAdt(i - 1) * timeStep);
end


plot(xprot,xmrna);
% plot(timePoints, xprot, "DisplayName", "Protein Concentrations");
% hold on
% plot(timePoints, xmrna, "DisplayName", "mRNA Concentrations");

%legend
%hold off