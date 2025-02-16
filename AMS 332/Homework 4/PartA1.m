clear
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
dt = 0.002;
t_start = 40;

time = 0:dt:t_max;

I_0 = 200;
I_e = 0:dt:t_max;
for i = 1:t_max/dt
    if i < 40/dt
        I_e(i) = 0;
    else
        I_e(i) = I_0;
    end
end

%Spike detection
spikeRecorded = false;
totalSpikes = 0;
detecThreshold = -15;

%initial conditions
V(1) = V_L;
m(1) = a_m(V(1)) / (a_m(V(1)) + b_m(V(1)));
h(1) = a_h(V(1)) / (a_h(V(1)) + b_h(V(1)));
n(1) = a_n(V(1)) / (a_n(V(1)) + b_n(V(1)));

tic
for i = 1:(t_max/dt)
    dVt1 = -G_L * (V(i) - V_L);
    dVt2 = -G_Na * power( m(i), 3) * h(i) * (V(i) - E_Na);
    dVt3 = -G_K * power( n(i), 4) * (V(i) - E_K);
    dVdt = (dVt1 +dVt2 + dVt3 + I_e(i)) / C;
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
            totalSpikes = totalSpikes + 1;
            spikeRecorded = true;
        end
    else
        spikeRecorded = false;
    end
end
toc
%Command Window Output
disp("total spikes: " + totalSpikes);

%Cleanup - A bit difficult to collect the initial data for the total
%membrane current, the sodium conductance, and the sodium conductance
I_m(1) = I_m(2);
Na_c(1) = Na_c(2);
K_c(1) = K_c(2);

%Figure plotting
figure(1);
% subplot(5,1,1);
plot(time, V);
title('membrane potential vs time');
ylabel('mV');
xlabel('time (ms)');
% subplot(5,1,2);
% plot(time, I_m);
% title('total membrane current vs time');
% ylabel('mV');
% xlabel('time (ms)');
% subplot(5,1,3);
% plot(time, Na_c);
% title('sodium conductance vs time');
% ylabel('mV');
% xlabel('time (ms)');
% subplot(5,1,4);
% plot(time, K_c);
% title('potassium conductance vs time');
% ylabel('mV');
% xlabel('time (ms)');
% subplot(5,1,5);
% plot(time, I_e);
% title('current vs time');
% ylabel('pA');
% xlabel('time (ms)');

%Common Functions
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