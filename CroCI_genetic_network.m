clear

WcI = 50;
XcIP = 1.2;
XcIR = 1.2;
mucI = 50;
KcroHalf = 10;
cIR(1) = 50;
cIP(1) = 0;

Wcro = 50;
XcroP = 0.8;
XcroR = 0.8;
mucro = 50;
KcIHalf = 10;
croR(1) = 0;
croP(1) = 0;

dt = 0.01;
timeSteps = 0:dt:30;

for i = 1:length(timeSteps) - 1;
    dcIPdt = WcI * cIR(i) - XcIP * cIP(i);
    dcIRdt = mucI * (1 - (power(croP(i), 2))/(power(KcroHalf,2) + power(croP(i),2))) - XcIR * cIR(i);
    dcroPdt = Wcro * croR(i) - XcroP * croP(i);
    dcroRdt = mucro * (1 - (power(cIP(i), 2))/(power(KcIHalf,2) + power(cIP(i),2))) - XcroR * croR(i);

    cIP(i + 1) = cIP(i) + (dcIPdt * dt);
    cIR(i + 1) = cIR(i) + (dcIRdt * dt);
    croP(i + 1) = croP(i) + (dcroPdt * dt);
    croR(i + 1) = croR(i) + (dcroRdt * dt);
end

plot(timeSteps, cIP, DisplayName='cIP');
hold on
plot(timeSteps, cIR, DisplayName='cIR');
plot(timeSteps, croP, DisplayName='croP');
plot(timeSteps, croR, DisplayName='crpR');
legend;
xlabel('Time (s)');
ylabel('Concentration (molecules)');
title('Change in Protein Concentration over Time');
hold off