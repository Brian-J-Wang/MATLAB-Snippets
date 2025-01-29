% code

x = [2 5 1 6];

for i = 1:4
    x(i) = x(i) + 16;
end

disp("1a");
disp(x);
disp("");

x = [2 5 1 6];

for i = 1:4
    x(i) = sqrt(x(i));
end

disp("1b");
disp(x);
disp("");

x = [2 5 1 6];

for i = 1:4
    x(i) = pow2(x(i));
end

disp("1c");
disp(x);
disp("");