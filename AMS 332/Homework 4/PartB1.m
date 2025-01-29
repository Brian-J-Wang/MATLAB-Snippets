clear
%Constants
G_L = 0.05;
V_L = -65;

V_spk = -45;
V_r = -65;
dt_tau = 0;
tau_arp = 2;



%Simulation Settings
dt = 0.002;
t_max = 200;

%Initial Conditions
V(1) = V_L;
I_e(1) = 1.1;

tic
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
    else
        V(t + 1) = V(t) + (dVdt * dt);
    end

    I_e(t + 1) = I_e(t);
end
toc

time = 0:dt:t_max;

figure(1);
subplot(2,1,1);
plot(time, V);
title('membrane potential vs time');
xlabel('time (ms)');
ylabel('mV');
subplot(2,1,2);
plot(time, I_e);
title('external current vs. time');
xlabel('time (ms)');
ylabel('current nA');