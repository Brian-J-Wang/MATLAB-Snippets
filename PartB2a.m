clear

u = 1;
w = 1;
xprot = 1;
xrna = 1;
kHalf = 0.33;
h = 2;

dt = 0.01;
Time = 0:dt:20;


for x = 0:0.2:1.4
    for y = 0:0.2:1.4
        xProt(1) = x;
        xRNA(1) = y;
        for i = 1:length(Time) - 1
            dXrnaDt(i) = (u * power(xProt(i), 2)) / (power(kHalf, 2) + power(xProt(i), 2)) - (xrna * xRNA(i));
            dXproDt(i) = w * xRNA(i) - xprot * xProt(i);
            xRNA(i + 1) = xRNA(i) + dXrnaDt(i) * dt;
            xProt(i + 1) = xProt(i) + dXproDt(i) * dt;
        end
        plot(xProt, xRNA);
        hold on
    end
end

xlabel("xProt");
ylabel("xRNA");
hold off