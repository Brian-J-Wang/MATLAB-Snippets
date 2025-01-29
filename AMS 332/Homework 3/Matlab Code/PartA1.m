mu = 1;
cprot = 1;
dprot = 0.0001;

omega = 1;
crna = 1;
drna = 0.0001;

totalTime = 200;
timeStep = 0.1;
time = 0:timeStep:totalTime;

totalDistance = 3.0;
distanceStep = 0.02;
position = 0:distanceStep:totalDistance - distanceStep;

khalf = 0.33;

Nx = ceil( (totalDistance - 0) / distanceStep );
Nt = ceil( (totalTime - 0) / timeStep );

%(concentration, time)
prot = zeros(Nx, Nt);
rna = zeros(Nx, Nt);

%initial conditions
rna(1, 1) = 1.0;
prot(1, 1) = 1.0;
%simulation here
for t = 1:Nt
    for x = 1:Nx
        rate_rna = (mu * prot(x, t)^2)/(khalf^2 + prot(x, t)^2);
        rna_decay = -crna * rna(x, t);

        rate_prot = omega * rna(x, t);
        prot_decay = -cprot * prot(x, t);
        
        del2Crna = -2 * rna(x, t);
        del2Cprot = -2 * prot(x, t);
        if x == 1
            del2Crna = del2Crna + rna(x + 1, t);
            del2Cprot = del2Cprot + prot(x + 1, t); 
        elseif x == Nx
            del2Crna = del2Crna + rna(x - 1, t);
            del2Cprot = del2Cprot + prot(x - 1, t);
        else
            del2Crna = del2Crna + rna(x - 1, t) + rna(x + 1, t);
            del2Cprot = del2Cprot + prot(x - 1, t) + prot(x + 1, t);
        end
        del2Crna = del2Crna / distanceStep^2;
        del2Cprot = del2Cprot / distanceStep^2;

        dprotdt = rate_prot + prot_decay + (del2Cprot * dprot);
        drnadt = rate_rna + rna_decay + (del2Crna * drna);

        prot(x, t + 1) = prot(x, t) + dprotdt * timeStep;
        rna(x, t + 1) = rna(x, t) + drnadt * timeStep;
    end
end

figure(1);
subplot(2,1,1);
plot(time, prot(1, :), displayname='position = 1');
hold on
plot(time, prot(2, :), displayname='position = 2');
plot(time, prot(3, :), displayname='position = 3');
title('Protein Concentration at Different Positions')
xlabel('Time (s)')
ylabel('Concentration (mM)')
legend
hold off

subplot(2,1,2);
plot(time, rna(1, :), displayname='position = 1');
hold on
plot(time, rna(2, :), displayname='position = 2');
plot(time, rna(3, :), displayname='position = 3');
title('RNA Concentration at Different Positions');
xlabel('Time (s)');
ylabel('Concentration (mM)');
legend
hold off

figure(2);
subplot(2,1,1);
plot(position, prot(:,1), DisplayName='protein');
hold on
plot(position, rna(:,1), DisplayName='rna');
title('Concentration at Different Distances (T = 0 s)');
xlabel('position (um)');
ylabel('Concentration (uM')
legend
hold off

subplot(2,1,2);
plot(position, prot(:,ceil(totalTime / timeStep)), DisplayName='protein');
hold on
plot(position, rna(:,ceil(totalTime / timeStep)), DisplayName='rna');
title('Concentration at Different Distances (T = 200 s)');
xlabel('position (um)');
ylabel('Concentration (uM')
legend
hold off

