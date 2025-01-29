tiledlayout(2,1)

omega = 1;
mu = 2;
khalf = 1;
lp = 1;
lr = 1;
lprot = 0:0.1:8;

dlprotdt = (lp * lprot) / mu;
dlrnadt = (mu * lprot) ./ (lr * (khalf + lprot));

delta = 1;
gamma = 2;
jhalf = 1;
hp = 1;
hr = 1;
hprot = 0:0.1:8;

dhprotdt = (hp * hprot) / gamma;
dhrandt = (gamma * hprot) ./ (hr * (jhalf + hprot));

nexttile
plot(lprot, dlprotdt, DisplayName='protein');
hold on
plot(lprot, dlrnadt, DisplayName='RNA');
title("Protein Lan");
xlabel("Protein Concentration");
ylabel("RNA Concentration");
legend;
hold off

nexttile
plot(hprot, dhprotdt, DisplayName='protein');
hold on
plot(hprot, dlrnadt, DisplayName='RNA');
title("Protein Huang");
xlabel("Protein Concentration");
ylabel("RNA Concentration");
legend;
hold off