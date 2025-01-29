clear
%Constants
G_L = 0.05;
V_L = -65;

V_spk = -45;
V_r = -65;
tau_arp = 2;

fireRate = [];
fireRateIndex = 1;
currentValues = 0:2:80;
%Simulation Settings
dt = 0.1;
t_max = 200;

%Initial Conditions
tic
for c = 0:2:80
    dtSpike = [];
    spikeIndex = 1;
    
    V(1) = V_L;
    I_e(1) = c;

    dt_tau = 0;
    for t = 1:t_max / dt

        dVdt = (-G_L * (V(t) - V_L)) + I_e(t);

        if t < dt_tau
            V(t + 1) = V(t);
            I_e(t + 1) = I_e(t);
            continue;
        end

        if V(t) > V_spk
            V(t + 1) = V_r;
            dt_tau = t + (tau_arp / dt);

            dtSpike(spikeIndex) = (t * dt) * (1/1000);
            spikeIndex = spikeIndex + 1;
        else
            V(t + 1) = V(t) + (dVdt * dt);
        end
        I_e(t + 1) = I_e(t);    
    end

    sum = 0;
    for i = 1:(length(dtSpike) - 1)
        sum = sum + (dtSpike(i + 1) - dtSpike(i));
    end
    
    fireRate(fireRateIndex) = 1 / (sum / length(dtSpike));
    fireRateIndex = fireRateIndex + 1;
end
toc

plot(currentValues, fireRate);
title('Firerate vs Current');
xlabel('current (nA)');
ylabel('FireRate');


