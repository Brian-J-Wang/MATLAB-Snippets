clear
totalT = [10 100 200 400 800 1600 3200 6400];
numSpikes = 0;
lambda = 10;

CVar = zeros(length(totalT));
FF = zeros(length(totalT));
for t = 1:length(totalT)
    CV = zeros(50);
    SC = zeros(50);
    ISI = zeros(64000, 50);
    for y = 1:50
        numSpikesInTrial = 0;
        cumISI = 0;
        for x = 1:64000
            isi = -log(rand())/lambda;
            cumISI = cumISI + isi;
            if(cumISI < totalT(t))
                ISI(x, y) = isi;
                numSpikes = numSpikes + 1;
                numSpikesInTrial = numSpikesInTrial + 1;
            else
                ISI(x, y) = NaN;
            end
        end
        SC(y) = numSpikesInTrial;
    end
    
    for i = 1:50
        CV(i) = std(ISI(:,i), 'omitnan') ./ mean(ISI(:,i), 'omitnan');
    end
    CVar(t) = mean(CV(1));
    FF(t) = var(SC) / mean(SC);
end

plot(totalT, CVar(:, 1), DisplayName='CV');
hold on
plot(totalT, FF(:, 1), DisplayName='FF');
hold off
title('Coefficient of Variability and Fano Factor Over Time');
xlabel('Duration (s)');
ylabel('Value');
legend

