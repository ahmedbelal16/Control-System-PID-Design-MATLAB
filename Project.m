clear; clc; close all;

%%System Parameters
Ms = 5.693; %mass of slide
Mb = 6.96; %mass of drive bar
M = Ms + Mb;
Jm = 10.91e-3; %inertia
r = 31.75e-3; %roller radius
bm = 0.268; %motor damping
Km = 0.8379; %torque constant
Kb = 0.838; %back EMF constant
Rm = 1.36; % motor resistance
Lm = 3.6e-3; %motor inductance

A = [-Rm/Lm -Kb/Lm 0; Km/(Jm+M*(r^2)) -bm/(Jm+M*(r^2)) 0; 0 r 0];
B = [1/Lm; 0; 0];
C = [0 1 0; 0 0 1/r; 0 0 1];
D = [0; 0; 0];

sys = ss(A, B, C, D); % Create state-space system representation
tf_omega = tf(sys(1)); %Output1: omega(t)
tf_theta = tf(sys(2)); %Output2: theta(t)
tf_x = tf(sys(3)); % Output3: x(t)

%Step Response of each output
% omega(t)
figure
step(sys(1))
title('Step response for Omega')
grid on
% theta(t)
figure
step(sys(2))  
title('Step response for Theta')
grid on
% x(t)
figure
step(sys(3))  
title('Step response for x')
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%% Point No.5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s = tf('s'); %define the laplace variable
Gc = [2, 5, 10, 100, 200];
G1 = tf_omega;
integrator = 1/s;

%*Step Input*%
% Create figure for step responses
figure;
% Loop through each gain value in Gc and plot the step response
for i = 1:length(Gc)
    L = integrator* G1* Gc(i); %open loop
    T = feedback(L, 1);
    subplot(2, 3, i);
    step(T); % Step response for the scaled system
    title(['Step Response for Gain = ', num2str(Gc(i))]);
    xlabel('Time (s)');
    ylabel('Response');
    grid on;
end

%*Ramp Input*%
t = 0:0.01:10;
ramp = t; % simple ramp input
% Create figure for ramp responses
figure;
% Loop through each gain value in Gc and plot the ramp response
for i = 1:length(Gc)
    L = integrator* G1* Gc(i); % open loop
    T = feedback(L, 1);
    subplot(2, 3, i);
    lsim(T, ramp, t); % Ramp response for the scaled system
    title(['Ramp Response for Gain = ', num2str(Gc(i))]);
    xlabel('Time (s)');
    ylabel('Response');
    grid on;
end


%%%%%%%%%%%%%%Point 7%%%%%%%%%%%%%%%%%%
%%%%% Without disturbance %%%%%
Ku = 495.3260803; %Ku obtained from hand analysis
Tu = 0.05;

Kp = 0.6 * Ku;
Ki = 1.2 * Ku / Tu;
Kd = 0.6 * Ku * Tu / 8;

Gc_pid = Kp + Ki/s +s*Kd;
% Create a closed-loop system with the PID controller
L_pid = integrator* G1* Gc_pid; % open loop with PID
T_pid = feedback(L_pid, 1); % closed-loop system with PID

figure
step(T_pid)
title('Step response for Ziegler–Nichols')
grid on;

% Get the step response data for the PID controlled system
info_pid = stepinfo(T_pid);
Ts_2percent_pid = info_pid.SettlingTime;
Overshoot_percent_pid = info_pid.Overshoot;
fprintf('2%% settling time = %f\n', Ts_2percent_pid)
fprintf('Overshoot percentage = %f\n', Overshoot_percent_pid)

%%%%% System's step Response with disturbance %%%%%
T_pid_dist = feedback(-G1/s, -Gc_pid);
figure
step(T_pid_dist)
title('Response with step disturbance (ZN)')
grid on;

%%%%%%%%%%%%%%Point 8%%%%%%%%%%%%%%%%%%
%%%%% Without disturbance %%%%%
KP = 5;
KI = 0.01;
KD = 0.5;
Gc_pid_tuned = KP + KI/s + s*KD; % Define the PID controller with new gains
L_pid_tuned = integrator * G1 * Gc_pid_tuned; % Open loop with tuned PID
T_pid_tuned = feedback(L_pid_tuned, 1); % Closed-loop system with tuned PID

figure
step(T_pid_tuned)
title('Step response for my colleague')
grid on;

% Get the step response data for the PID controlled system
info_pid_tuned = stepinfo(T_pid_tuned);
Ts_2percent_pid_tuned = info_pid_tuned.SettlingTime;
Overshoot_percent_pid_tuned = info_pid_tuned.Overshoot;
fprintf('My colleague has 2%% settling time = %f\n', Ts_2percent_pid_tuned)
fprintf('My colleague has Overshoot percentage = %f\n', Overshoot_percent_pid_tuned)

%%%%% System's step Response with disturbance %%%%%
T_pid_tuned_dist = feedback(-G1/s, -Gc_pid_tuned);
figure
step(T_pid_tuned_dist)
title('Response with step disturbance (colleague)')
grid on;