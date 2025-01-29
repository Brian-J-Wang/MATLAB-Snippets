format short
%CODE
x = [2, 7, 1, 6];

a = x - 1;
disp(a);

temp = (7 * mod(2:5, 2));
b = x + temp;
disp(b);

c = x .^ (1/3);
disp(c)

d = x.^ 4;
disp(d);

%OUTPUT