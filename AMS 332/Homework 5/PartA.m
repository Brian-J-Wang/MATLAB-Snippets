totalT = 5;
numSpikes = 0;
lambda = 10;

SC = zeros(50);
S = zeros(100, 50);
for y = 1:50
    numSpikesInTrial = 0;
    cumISI = 0;
    for x = 1:100
        isi = -log(rand())/lambda;
        cumISI = cumISI + isi;
        if(cumISI < totalT)
            S(x,y) = cumISI;
            ISI(x, y) = isi;
            numSpikes = numSpikes + 1;
            numSpikesInTrial = numSpikesInTrial + 1;
        else
            S(x,y) = NaN;
            ISI(x, y) = NaN;
        end
    end
    SC(y) = numSpikesInTrial;
end

disp("Average:                      " + numSpikes/(50 * totalT));

figure(1)
plot(S,1:50,'.k');
title('Neuron Spike Time');
xlabel('Time (s)');
ylabel('Trial');

dt = 0.2;
F = zeros(totalT / dt);
for i = 1:length(F)
    T(i) = 0.5 * (i * dt + (i - 1) * dt);
    for y = 1:50
        for x = 1:100
            if(S(x,y) < i * dt && S(x,y) > ((i - 1) * dt))
                F(i) = F(i) + 1;
            end
        end
    end
    F(i) = F(i)/(50 * dt);
end
figure(2)
plot(T, F);
title('PSTH');
xlabel('Time (s)');
ylabel('Average Firerate');

%Coefficient of Variability
for i = 1:50
    CV(i) = std(ISI(:,i), 'omitnan') / mean(ISI(:,i), 'omitnan');
end

figure(3)
plot(1:50, CV);
title('Coefficient of Variability');
xlabel('trial');
ylabel('variability');
disp("Coefficient of Variability:   " + mean(CV));

%Fano Factor
disp("Fano Factor:                  " + var(SC) / mean(SC));
