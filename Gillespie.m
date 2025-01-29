iterations = 5000;

omega = 0.1;
Cmrna = 10;
Cp = 0.001;
Cprot(1) = 0;

TimeVal(1) = 0;

for i = 1:iterations
    V1 = omega * Cmrna;
    V2 = Cp * Cprot(i);
    Vtot = V1 + V2;
    
    y = rand;
    tau = -log(y)/Vtot;

    x = rand * Vtot;
    if x <= V1
        Cprot(i + 1) = Cprot(i) + 1;
    elseif x <= V1 + V2
        Cprot(i + 1) = Cprot(i) - 1;
    elseif x > V1 + V2
        Disp("error");
        Cprot(i + 1) = Cprot(i);
    end
    TimeVal(i + 1) = TimeVal(i) + tau;
end

plot(TimeVal,Cprot);
