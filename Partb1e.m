clear

u = 1;
w = 1;
xprot = 1;
xrna = 1;
kHalf = 0.33;
h = 2;

dt = 0.01;
Time = 0:dt:20;

xProt(1) = 0;
xRNA(1) = 0.5;

for i = 1:length(Time) - 1
    dXrnaDt(i) = (u * power(xProt(i), 2)) / (power(kHalf, 2) + power(xProt(i), 2)) - (xrna * xRNA(i));
    dXproDt(i) = w * xRNA(i) - xprot * xProt(i);
    xRNA(i + 1) = xRNA(i) + dXrnaDt(i) * dt;
    xProt(i + 1) = xProt(i) + dXproDt(i) * dt;
end

plot(Time, xRNA, DisplayName="xRNA");
hold on
plot(Time, xProt, DisplayName="xProt");
legend
xlabel("Time (S)");
ylabel("Concentration (mM)");
hold off