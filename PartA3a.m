clear

Vmax = 20;
kHalf = 50;
h = 4;

dt = 0.01;
Time = 0:dt:10;

S(1) = 100;
for i = 1:(length(Time) - 1)
    dSdt(i) = -((Vmax * power(S(i), h))/(power(kHalf, h) + power(S(i), h)));
    S(i + 1) = S(i) + dSdt(i) * dt;
end

plot(Time, S, DisplayName="h=4, Vmax=20, kHalf=50");
hold on
legend
xlabel("Time (S)");
ylabel("Substrate Concentration (mM)");
title("Substrate Concentration over time");
hold off