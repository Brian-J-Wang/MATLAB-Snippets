clear

omega = 60;
mu = 20;
xp = 40;
xr = 10;

x = 0:50;
xMRNA1 = x;
xMRNA2 = x;

steps = 50;
for i = 1:steps+1
    xMRNA1(i) = (xp * x(i))/omega;
    xMRNA2(i) = mu/xr;
end

plot(x, xMRNA1);
hold on
xlabel("Protein Concentration");
ylabel("mRNA Concentration");
plot(x, xMRNA2);
hold off