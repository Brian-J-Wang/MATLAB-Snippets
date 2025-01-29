Vmax = 20.0;
h = 4;
kHalf = 50;

S = 0:0.05:100;

for i = 1:length(S)
    V1(i) = (Vmax * power(S(i), h)) / (power(kHalf, h) + power(S(i), h)); 
end

plot(S, V1, "DisplayName", "Vmax = 20.0, h = 4, kHalf = 50");
hold on
legend
xlabel("Substrate Concentration");
ylabel("Reaction Velocity (mM/S)");
hold off
