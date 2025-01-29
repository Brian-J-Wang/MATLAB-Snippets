sum(1:100)
sum((1:15).^2)
sum(0.5.^(0:10))

r = rand(50, 1000);
o = mean(r);
histogram(o, 40);
