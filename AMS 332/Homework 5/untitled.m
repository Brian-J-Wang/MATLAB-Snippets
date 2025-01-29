% Input data
X = [0 0 1; 1 1 1; 1 0 1; 0 1 1];
y = [0; 1; 1; 0];

% Initialize random weights
w = randn(3, 1);

% Set learning rate and number of epochs
lr = 0.1;
epochs = 1000;

% Train perceptron
for epoch = 1:epochs
    for i = 1:size(X, 1)
        x = X(i, :)';
        z = w'*x;
        yhat = z > 0;
        error = y(i) - yhat;
        w = w + lr*error*x;
    end
end

% Test perceptron
Xtest = [0 0 1; 1 1 1; 1 0 1; 0 1 1];
ytest = [0; 1; 1; 0];
correct = 0;
for i = 1:size(Xtest, 1)
    x = Xtest(i, :)';
    z = w'*x;
    yhat = z > 0;
    if yhat == ytest(i)
        correct = correct + 1;
    end
end
accuracy = correct/size(Xtest, 1);
disp(['Accuracy: ' num2str(accuracy)]);