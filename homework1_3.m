%CODE

A = [2 7 9 7 ; 3 1 5 6 ; 8 1 2 5];
AA = A;
BB = A;
EE = zeros(4,3);

%Doing A, B, and C within a the same for loops
for x = 1:3
    for y = 1:4
        AA(x, y) = 1 / A(x, y);
        BB(x, y) = sqrt(A(x, y));
        EE(y, x) = A(x, y);
    end
end

CC = A(1:3, 2);
DD = A(1:3, 1);
for r = 1:4
    if (mod(r, 2) == 0 && r ~= 2)
        CC =[CC A(1:3, r)];
    end

    if (mod(r + 1, 2) == 0 && r ~= 1)
        DD =[DD A(1:3, r)];
    end
end

disp(AA);
disp(BB);
disp(CC);
disp(DD);
disp(EE);
