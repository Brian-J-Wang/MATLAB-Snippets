% CODE
arr = rand(5,4);

% BEFORE
disp(arr);

for x = 1:5
    for y = 1:4
        if arr(x,y) < 0.2
            arr(x,y) = 0;
        else
            arr(x,y) = 1;
        end
    end
end

% AFTER
disp(arr);