format longg
a = 1;
b = 1/sqrt(2);
t = 1/4;
x = 1;

iterations = 3;

fprintf('iterations: %i \n', iterations);

for i = 1:iterations
    y = a;
    a = (a + b)/2;
    b = sqrt(b*y);
    t = t - x * (y - a)^2;
    x = 2 * x;
end

Pi_est = ((a + b)^2) / (4 * t);

disp(Pi_est);
disp(pi)