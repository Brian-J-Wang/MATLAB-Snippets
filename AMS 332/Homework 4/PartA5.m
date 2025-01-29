%Constants
G_Na = 400;
G_K = 200;
G_L = 2;
E_Na = 99;
E_K = -85;
V_L = -65;
C = 2;

%Simulation parameters
t_max = 200;
dt = 0.01;

%Spike detection
spikeRecorded = false;
detecThreshold = -15;

for I_e = 100:2.5:200
    dtSpikeIndex = 1;
    dtSpike = [];
    V(1) = V_L;
    m(1) = a_m(V(1)) / (a_m(V(1)) + b_m(V(1)));
    h(1) = a_h(V(1)) / (a_h(V(1)) + b_h(V(1)));
    n(1) = a_n(V(1)) / (a_n(V(1)) + b_n(V(1)));
    for i = 1:(t_max/dt)
        dVt1 = -G_L * (V(i) - V_L);
        dVt2 = -G_Na * power( m(i), 3) * h(i) * (V(i) - E_Na);
        dVt3 = -G_K * power( n(i), 4) * (V(i) - E_K);
        dVdt = (dVt1 +dVt2 + dVt3 + I_e) / C;
        dmdt = a_m(V(i)) * (1 - m(i)) - b_m(V(i)) * m(i);
        dhdt = a_h(V(i)) * (1 - h(i)) - b_h(V(i)) * h(i);
        dndt = a_n(V(i)) * (1 - n(i)) - b_n(V(i)) * n(i);

        V(i + 1) = V(i) + dVdt * dt;
        m(i + 1) = m(i) + dmdt * dt;
        h(i + 1) = h(i) + dhdt * dt;
        n(i + 1) = n(i) + dndt * dt;

        I_m(i + 1) = -dVt1 - dVt2 - dVt3;               %total membrane current
        Na_c(i + 1) = G_Na * power( m(i), 3) * h(i);    %sodium conductance
        K_c(i + 1) = G_K * power( n(i), 4);             %potassium conductance

        if V(i + 1) > detecThreshold
            if spikeRecorded == false;
                spikeRecorded = true;
                dtSpike(dtSpikeIndex) = i;
                dtSpikeIndex = dtSpikeIndex + 1;
            end
        else
            spikeRecorded = false;
        end
    end
    if I_e < 110
        FireRate(((I_e - 100) / 2.5) + 1) = 0;
    else
        sum = 0;
        for i = 1:length(dtSpike) - 1
            sum = sum + dtSpike(i + 1) - dtSpike(i);
        end
        FireRate(((I_e - 100) / 2.5) + 1) = (1 / (sum / dtSpikeIndex)) / 0.00002;
    end
end

plot(100:2.5:200, FireRate);
title('FireRate vs current strength');
xlabel('current (mV)');
ylabel('FireRate (action potentials / seconds)');
% Common Functions
function out = a_m(V)
    num = 0.1 * (V + 40);
    den = 1 - power(exp(1), (-0.1 * (V + 40)));
    out = num / den;
end

function out = b_m(V)
    out = 4 * power(exp(1), (-0.0556 * (V + 65)));
end

function out = a_h(V)
    out = 0.07 * power(exp(1), (-0.05 * (V + 65)));
end

function out = b_h(V)
    den = 1 + power(exp(1), (-0.1 * (V + 35)));
    out = 1 / den;
end

function out = a_n(V)
    num = 0.01 * (V + 55);
    den = 1 - power( exp(1), (-0.1 * (V + 55)));
    out = num / den;
end

function out = b_n(V)
    out = 0.125 * power( exp(1), (-0.0125 * (V + 65)));
end