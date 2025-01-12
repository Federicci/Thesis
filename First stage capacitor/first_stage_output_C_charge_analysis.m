%% First stage output capacitor charge analysis

%{

This script helps visualize the worst case scenario for the phase-shift in
the current waveforms playing at the output of the first stage, solved
numerically due to the complexity of the expresion

%}

clc, close all, clear all;

I_o1 = 4.66;
I_o = 1.94;
I_in2 = I_o1-I_o;
fsw = 100e3;

ic = @(x,phi) pi/2*I_o1*abs(sin(x))-(I_o+pi/2*I_in2*abs(sin(x+phi)));
ic_t = @(time,phi) pi/2*I_o1*abs(sin(2*pi*fsw*time))-(I_o+pi/2*I_in2*abs(sin(2*pi*fsw*time+phi)));

x_values = linspace(0,3.14,10000);
phi_values = linspace(0,3.14,10000);
Q_plus_vector = [];

% Sweep phase-shift angles
for i = 1:size(phi_values,2)

    flag = 0; %flag for detecting 0 crossing

    for t = 1:size(x_values,2)

        if ic(x_values(1,t),phi_values(1,i)) > 0 & flag == 0

            flag = 1;
            t1 = t;

        elseif flag == 1 & ic(x_values(1,t),phi_values(1,i)) < 0

            t2 = t;
            break;

        end

    end

    ic_t_fixed = @(time) ic_t(time,phi_values(1,i));
    Q_plus = integral(ic_t_fixed,x_values(1,t1)/(2*pi*fsw),x_values(1,t2)/(2*pi*fsw));
    Q_plus_vector = [Q_plus_vector Q_plus];
    
end

figure
hold on;
title('Charge Q_{+} for different phase-shift \phi','FontSize',25,'Interpreter','tex');
ylabel('Charge (\mu C)','Interpreter','tex','FontSize',20);
xlabel('Phase-shift (rad)','FontSize',20);
xlim([0 pi]);
plot(phi_values,Q_plus_vector,'LineWidth',2,'Color','r');