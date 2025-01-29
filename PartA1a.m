Vmax = 5.0;
h1 = 1;
h2 = 2;
h3 = 10;
kHalf = 20.0;

S = 0:0.05:100;

for i = 1:length(S)
    V1(i) = (Vmax * power(S(i), h1)) / (power(kHalf, h1) + power(S(i), h1));
    V2(i) = (Vmax * power(S(i), h2)) / (power(kHalf, h2) + power(S(i), h2));
    V3(i) = (Vmax * power(S(i), h3)) / (power(kHalf, h3) + power(S(i), h3));
end

plot(S, V1, "DisplayName", "h = 1");
hold on
plot(S, V2, "DisplayName", "h = 2");
plot(S, V3, "DisplayName", "h = 10");
legend
xlabel("Substrate Concentration");
ylabel("Reaction Velocity (mM/S)");
hold off
