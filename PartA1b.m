Vmax = 5.0;
h = 2;
kHalf1 = 10.0;
kHalf2 = 20.0;
kHalf3 = 40.0;

S = 0:0.05:100;

for i = 1:length(S)
    V1(i) = (Vmax * power(S(i), h)) / (power(kHalf1, h) + power(S(i), h));
    V2(i) = (Vmax * power(S(i), h)) / (power(kHalf2, h) + power(S(i), h));
    V3(i) = (Vmax * power(S(i), h)) / (power(kHalf3, h) + power(S(i), h));
end

plot(S, V1, "DisplayName", "kHalf1 = 10.0");
hold on
plot(S, V2, "DisplayName", "kHalf2 = 20.0");
plot(S, V3, "DisplayName", "kHalf3 = 40.0");
legend
xlabel("Substrate Concentration");
ylabel("Reaction Velocity (mM/S)");
hold off
