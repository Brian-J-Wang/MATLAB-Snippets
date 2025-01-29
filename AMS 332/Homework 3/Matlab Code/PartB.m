mu = 1;
cprot = 1;
dprot = 0.0001;

omega = 1;
crna = 1;
drna = 0.0001;

totalTime = 400;
timeStep = 0.01;
time = 0:timeStep:totalTime;

totalDistance = 3.0;
distanceStep = 0.02;
position = 0:distanceStep:totalDistance - distanceStep;

khalf = 0.33;

Nx = ceil( (totalDistance - 0) / distanceStep );
Nt = ceil( (totalTime - 0) / timeStep );

%(concentration, time)
protx = zeros(Nx, Nt);
rnax = zeros(Nx, Nt);
proty = zeros(Nx, Nt);
rnay = zeros(Nx, Nt);
%initial conditions
rnax(1, 1) = 1.0;
protx(1, 1) = 1.0;
rnax(150, 1) = 1.0;
protx(150, 1) = 1.0;
rnay(75, 1) = 1.0;
proty(75, 1) = 1.0;
%simulation here
for t = 1:Nt
    for x = 1:Nx
        rnax_growth = mu * (1 - ((proty(x, t)^2)/(khalf^2 + proty(x, t)^2)));
        rnax_decay = -crna * rnax(x, t);
        protx_growth = omega * rnax(x, t);
        protx_decay = -cprot * protx(x, t);
        
        rnay_growth = mu * (1 - ((protx(x, t)^2)/(khalf^2 + protx(x, t)^2)));
        rnay_decay = -crna * rnay(x, t);
        proty_growth = omega * rnay(x, t);
        proty_decay = -cprot * proty(x, t);

        del2Crnax = -2 * rnax(x, t);
        del2Cprotx = -2 * protx(x, t);
        del2Crnay = -2 * rnay(x, t);
        del2Cproty = -2 * proty(x, t);
        if x == 1
            del2Crnax = del2Crnax + rnax(x + 1, t);
            del2Cprotx = del2Cprotx + protx(x + 1, t); 
            del2Crnay = del2Crnay + rnay(x + 1, t);
            del2Cproty = del2Cproty + proty(x + 1, t); 
        elseif x == Nx
            del2Crnax = del2Crnax + rnax(x - 1, t);
            del2Cprotx = del2Cprotx + protx(x - 1, t);
            del2Crnay = del2Crnay + rnay(x - 1, t);
            del2Cproty = del2Cproty + proty(x - 1, t);
        else
            del2Crnax = del2Crnax + rnax(x - 1, t) + rnax(x + 1, t);
            del2Cprotx = del2Cprotx + protx(x - 1, t) + protx(x + 1, t);
            del2Crnay = del2Crnay + rnay(x - 1, t) + rnay(x + 1, t);
            del2Cproty = del2Cproty + proty(x - 1, t) + proty(x + 1, t);
        end
        del2Crnax = del2Crnax / distanceStep^2;
        del2Cprotx = del2Cprotx / distanceStep^2;
        del2Crnay = del2Crnay / distanceStep^2;
        del2Cproty = del2Cproty / distanceStep^2;


        dprotxdt = protx_growth + protx_decay + (del2Cprotx * dprot);
        drnaxdt = rnax_growth + rnax_decay + (del2Crnax * drna);
        dprotydt = proty_growth + proty_decay + (del2Cproty * dprot);
        drnaydt = rnay_growth + rnay_decay + (del2Crnay * drna);

        protx(x, t + 1) = protx(x, t) + dprotxdt * timeStep;
        rnax(x, t + 1) = rnax(x, t) + drnaxdt * timeStep;
        proty(x, t + 1) = proty(x, t) + dprotydt * timeStep;
        rnay(x, t + 1) = rnay(x, t) + drnaydt * timeStep;
    end
end

figure(1);
subplot(2,1,1);
plot(time, protx(1, :), displayname='position = 1');
hold on
plot(time, protx(75, :), displayname='position = 75');
plot(time, protx(150, :), displayname='position = 150');
title('Protein X Concentration at Different Positions')
xlabel('Time (s)')
ylabel('Concentration (mM)')
legend
hold off

subplot(2,1,2);
plot(time, rnax(1, :), displayname='position = 1');
hold on
plot(time, rnax(75, :), displayname='position = 75');
plot(time, rnax(150, :), displayname='position = 150');
title('RNA X Concentration at Different Positions');
xlabel('Time (s)');
ylabel('Concentration (mM)');
legend
hold off

figure(2)
subplot(2,1,1);
plot(time, proty(1, :), displayname='position = 1');
hold on
plot(time, proty(75, :), displayname='position = 75');
plot(time, proty(150, :), displayname='position = 150');
title('Protein Y Concentration at Different Positions')
xlabel('Time (s)')
ylabel('Concentration (mM)')
legend
hold off

subplot(2,1,2);
plot(time, rnay(1, :), displayname='position = 1');
hold on
plot(time, rnay(75, :), displayname='position = 75');
plot(time, rnay(150, :), displayname='position = 150');
title('RNA Y Concentration at Different Positions');
xlabel('Time (s)');
ylabel('Concentration (mM)');
legend
hold off

figure(3);
subplot(2,1,1);
plot(position, protx(:,1), DisplayName='protein');
hold on
plot(position, rnax(:,1), DisplayName='rna');
title('Concentration of gene X at Different Distances (T = 0 s)');
xlabel('position (um)');
ylabel('Concentration (uM')
legend
hold off

subplot(2,1,2);
plot(position, protx(:,totalTime/timeStep), DisplayName='protein');
hold on
plot(position, rnax(:,totalTime/timeStep), DisplayName='rna');
title('Concentration of gene X at Different Distances (T = 400 s)');
xlabel('position (um)');
ylabel('Concentration (uM')
legend
hold off

figure(4);
subplot(2,1,1);
plot(position, proty(:,1), DisplayName='protein');
hold on
plot(position, rnay(:,1), DisplayName='rna');
title('Concentration of gene Y at Different Distances (T = 0 s)');
xlabel('position (um)');
ylabel('Concentration (uM')
legend
hold off

subplot(2,1,2);
plot(position, proty(:,totalTime/timeStep), DisplayName='protein');
hold on
plot(position, rnay(:,totalTime/timeStep), DisplayName='rna');
title('Concentration of gene Y at Different Distances (T = 400 s)');
xlabel('position (um)');
ylabel('Concentration (uM')
legend
hold off