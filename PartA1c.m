Vmax1 = 2.0;
Vmax2 = 5.0;
Vmax3 = 10.0;
h = 2;
kHalf = 20;

S = 0:0.05:100;

for i = 1:length(S)
    V1(i) = (Vmax1 * power(S(i), h)) / (power(kHalf, h) + power(S(i), h));
    V2(i) = (Vmax2 * power(S(i), h)) / (power(kHalf, h) + power(S(i), h));
    V3(i) = (Vmax3 * power(S(i), h)) / (power(kHalf, h) + power(S(i), h));
end

plot(S, V1, "DisplayName", "Vmax1 = 2.0");
hold on
plot(S, V2, "DisplayName", "Vmax2 = 5.0");
plot(S, V3, "DisplayName", "Vmax3 = 10.0");
legend
xlabel("Substrate Concentration");
ylabel("Reaction Velocity (mM/S)");
hold off
