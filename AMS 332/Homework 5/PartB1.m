lr = 1;
epoch = 500;
performance = zeros(epoch, 1);
%Truth table for AND. OR and XOR truth tables can be found in the bottom of
%the code
W = zeros(3, 1);
X = [1 1 -1; 1 -1 -1; -1 1 -1; -1 -1 -1];
Y = [-1 1 1 -1];

for t = 1:epoch
    %accuracy test
    sample = randi(size(X, 1));
    sampleX = X(sample, :);
    sampleY = Y(sample);
    
    outputY = sign(dot(W, sampleX));

    if outputY == sampleY
        performance(t) = 1;
    else
        performance(t) = 0;
    end
    
    %training data
    sample = randi(size(X, 1));
    sampleX = X(sample, :);
    sampleY = Y(sample);
    outputY = sign(dot(W, sampleX));
    for i = 1:3
        delw = lr * (sampleY - outputY) .* sampleX(i);
        W(i) = W(i) + delw;
    end
end

plot(1:epoch, performance, '.');
ylim([-0.2 1.2]);
ylabel('performace');
xlabel('presentation number');
title('XOR')

%Truth Tables for OR
%X = [1 1 -1; 1 -1 -1; -1 1 -1; -1 -1 -1]
%Y = [1 1 1 -1]

%Truth Tables for AND
%X = [1 1 -1; 1 -1 -1; -1 1 -1; -1 -1 -1]
%Y = [-1 1 1 -1]