%% Complete analysis in terms of load and gain for the converter

%{

This script takes as input the turns ratio of each transformer, the
resonating elements, and evaluate the system limits based on the loading of
each stage, plotting the necessary gain of each stage while showing the
limits for an iteration of m's. It also plots the morphed loading profiles
for each stage.

For defining the profiles themselves, refer to the final part of the script
with the profiles functions.

%}

clc, close all, clear all;

%Change here lightest load condition
Rmax = 2450;
%Define first stage turns ratio, second stage turns ratio is constrained by
%the rated input voltage gain (criteria discussed for the partciular gain
%profiles of this architecture)

%First idea
% Gtot_res = 350/36.5;
% n1 = 1/(sqrt(Gtot_res)-1);
% n2 = n1;

%Final iteration
n1 = 1/3;
%Locating resonant point at rated panel voltage @36.5v
Gtot_res = 350/36.5;
n2 = 1/(Gtot_res/(1/n1+1)-1);

%Include solar panel's data
projectdir = pwd; %retrieve actual path
dinfo = dir(fullfile(projectdir, '*.txt'));
filenames = fullfile({dinfo.folder}, {dinfo.name});
numfiles = length(filenames);

%Ordering datasets from less Irrandiance to more Irradiance
% Extract Ir values and filenames
Ir_values = zeros(numfiles, 1);
for i = 1:numfiles
    % Extract the portion of the filename containing Ir
    parts = regexp(dinfo(i).name, 'Ir=(\d+)', 'tokens');
    if ~isempty(parts)
        Ir_values(i) = str2double(parts{1}{1});
    else
        Ir_values(i) = NaN; % Handle cases where Ir= is not present
    end
end

% Sort filenames based on Ir values
[~, sort_idx] = sort(Ir_values);
sorted_filenames = filenames(sort_idx);

%color palette
startColor = [0 0 1];
endColor = [1 0 0];
gradientColors = [linspace(startColor(1), endColor(1), numfiles)', ...
                  linspace(startColor(2), endColor(2), numfiles)', ...
                  linspace(startColor(3), endColor(3), numfiles)'];

%% Definition and graph of the desired gain profiles

%{

In this code snippet the gain plot with the stage gain profiles are
presented

%}

V = linspace(15,43,1000);

gain_span = 350./V;

figure
hold on;
title('Gain distribution between stages','FontSize',25);
ylabel('Gain (V/V)','interpreter','tex','FontSize',20);
xlabel('Input Voltage (V)','FontSize',20);
xlim([15 43]);
yticks(0:5:25)
grid on;

legendString = {};
plot(V,gain_span,'LineWidth',2,'Color','k')
legendString = [legendString 'Total system gain G_{tot}'];

G1 = profileG1(V,n1,n2);

plot(V,G1,'LineWidth',2,'Color','b','LineStyle',':');
legendString = [legendString 'First stage gain G_{1}'];

G2 = profileG2(V,G1);
plot(V,G2,'LineWidth',2,'Color','r','LineStyle',':');
legendString = [legendString 'Second stage gain G_{2}'];

fontsize(gca,20,"pixels");
lgd = legend(legendString,'Interpreter','tex','Location','northeast','FontSize',20);

%% End of gain profiles

%% Definition and graph of the desired gain profiles

%{

In this code snippet the voltage stress reduction for each stage is
analyzed based on the final gain profiles

%}

legendString = {};
figure
hold on;
title('Voltage stress reduction','FontSize',25);
ylabel('Output voltage (V)','interpreter','tex','FontSize',20);
xlabel('Input Voltage (V)','FontSize',20);
set(gca,'FontSize',15);
xlim([15 43]);
grid on;

plot(V,V.*G1,'LineStyle','-','LineWidth',2,'Color','k');
legendString = [legendString 'First stage output voltage (IPOS)'];
plot(V,V.*(G1+1),'LineStyle','--','LineWidth',2,'Color','r');
legendString = [legendString 'First stage output voltage (Pure quadratic)'];
legend(legendString,'FontSize',15,'Location','northwest');

legendString = {};
figure
hold on;
title('Voltage stress reduction','FontSize',25);
ylabel('Output voltage (V)','interpreter','tex','FontSize',20);
xlabel('Input Voltage (V)','FontSize',20);
set(gca,'FontSize',15);
xlim([15 43]);
ylim([175 400]);
grid on;

plot(V,V.*(G1+1).*G2,'LineStyle','-','LineWidth',2,'Color','k');
legendString = [legendString 'Second stage output voltage (IPOS)'];
plot(V,V.*(G1+1).*(G2+1),'LineStyle','--','LineWidth',2,'Color','r');
legendString = [legendString 'Second stage output voltage (Pure quadratic)'];
legend(legendString,'FontSize',15,'Location','east');

%% End of voltage stresses

%% Load morphing


%{

In this code snippet the visualization of the system load morphing is
presented

%}

% First stage

figure11 = figure;
grid on;
hold on;
title('First Stage Loading Profile','FontSize',25)
ylabel('R_{eq_{1}} [\Omega]','Interpreter','tex','FontSize',20);
xlabel('Voltage (V)','FontSize',20);
xlim([15 43]);
fontsize(gca,20,"pixels")

figure12 = figure;
grid on;
hold on;
title('First Stage and System Loading Profile','FontSize',25)
ylabel('R_{eq_{1}} [\Omega]','Interpreter','tex','FontSize',20);
xlabel('Voltage (V)','FontSize',20);
xlim([15 43]);
fontsize(gca,20,"pixels")

legendString = {};

for k = 1:numfiles

    data = readtable(sorted_filenames{k});
    data = table2array(data);
    reduced_data = [0 0];
    counter = 1;

    for i = 1:size(data,1)
    
        if data(i,2) < 0
            break;
        end
    
        if data(i,1)*data(i,2) >= 50
        
            if mod(i,10) == 1
                reduced_data(counter,:) = data(i,:);
                counter = counter + 1;
            end
    
        end
        
    end

    expression = 'Ir=(\d+)';
    match = regexp(sorted_filenames{k}, expression, 'match');
    legendString{end+1} = [match{1} ' $\frac{W}{m^2}$'];

    % As the data is not consistent in terms of number of data points, the
    % gain profiles are calculated for every Irradiance value just to be
    % able to plot

    V = reduced_data(:,1)';
    I = reduced_data(:,2)';
    
    G1 = profileG1(V,n1,n2);
    G2 = profileG2(V,G1);

     % Calculate the system load characteristic
    load_values = 350^2 ./ (V.*I);

    % Calculate the first stage load characteristic
    load_values_fst_stg = load_values.*(G1./(G1+1)).*(1./((G2+1).^2));
    
    figure(figure11);
    plot(V,load_values_fst_stg,'LineWidth',2,'Color',gradientColors(k,:));

    figure(figure12);
    plot(V,load_values,'LineWidth',1,'Color',gradientColors(k,:),'HandleVisibility','off','LineStyle','--');
    plot(V,load_values_fst_stg,'LineWidth',2,'Color',gradientColors(k,:));

end

lightest_load_fst_stage = 2450*(G1./(G1+1)).*(1./((G2+1).^2));
figure(figure11);
plot(V,lightest_load_fst_stage,'LineWidth',3,'Color','k');
legendString = [legendString 'Lightest load (2450$\Omega$)'];
lgd = legend(legendString,'Interpreter','latex','Location','eastoutside','FontSize',20);
figure(figure12);
plot(V,lightest_load_fst_stage,'LineWidth',3,'Color','k');

% Second stage

figure21 = figure;
grid on;
hold on;
title('Second Stage Loading Profile','FontSize',25)
ylabel('R_{eq_{2}} [\Omega]','Interpreter','tex','FontSize',20);
xlabel('Voltage (V)','FontSize',20);
xlim([15 43]);
fontsize(gca,20,"pixels")

figure22 = figure;
grid on;
hold on;
title('Second Stage and System Loading Profile','FontSize',25)
ylabel('R_{eq_{2}} [\Omega]','Interpreter','tex','FontSize',20);
xlabel('Voltage (V)','FontSize',20);
xlim([15 43]);
fontsize(gca,20,"pixels")

legendString = {};

for k = 1:numfiles

    data = readtable(sorted_filenames{k});
    data = table2array(data);
    reduced_data = [0 0];
    counter = 1;

    for i = 1:size(data,1)
    
        if data(i,2) < 0
            break;
        end
    
        if data(i,1)*data(i,2) >= 50
        
            if mod(i,10) == 1
                reduced_data(counter,:) = data(i,:);
                counter = counter + 1;
            end
    
        end
        
    end

    expression = 'Ir=(\d+)';
    match = regexp(sorted_filenames{k}, expression, 'match');
    legendString{end+1} = [match{1} ' $\frac{W}{m^2}$'];

    % As the data is not consistent in terms of number of data points, the
    % gain profiles are calculated for every Irradiance value just to be
    % able to plot

    V = reduced_data(:,1)';
    I = reduced_data(:,2)';
    
    G1 = profileG1(V,n1,n2);
    G2 = profileG2(V,G1);

    % Calculate the system load characteristic
    load_values = 350^2 ./ (V.*I);

    % Calculate the first stage load characteristic
    load_values_scd_stg = load_values.*(G2./(G2+1));

    figure(figure21);
    plot(V,load_values_scd_stg,'LineWidth',2,'Color',gradientColors(k,:));

    figure(figure22);
    plot(V,load_values,'LineWidth',1,'Color',gradientColors(k,:),'HandleVisibility','off','LineStyle','--');
    plot(V,load_values_scd_stg,'LineWidth',2,'Color',gradientColors(k,:));

end

lightest_load_scd_stage = 2450*(G2./(G2+1));
figure(figure21);
plot(V,lightest_load_scd_stage,'LineWidth',3,'Color','k');
legendString = [legendString 'Lightest load (2450$\Omega$)'];
lgd = legend(legendString,'Interpreter','latex','Location','eastoutside','FontSize',20);
figure(figure22);
plot(V,lightest_load_scd_stage,'LineWidth',3,'Color','k');

%% End of stage loading


%{

In this code snippet the visualization of the system gain regulation
capabilities is plotted, parametric to different m values, for specific
values on Lr and fr, which define a specific Cr. It requires the previous
section to be ran as it utilizes the last iteration of
load_values_fst_stage and load_values_scd_stage containing the heaviest
loads of each stage, it also uses the variables lightest_load_fst_stage and
lightest_load_scd_stage created in the previous section

%}

% First stage

fr = 100e3;
Lr = 11.3e-6;
Cr = (1/(2*pi*fr))^2/Lr;
m_min = 5; % minimum m to try
m_max = 7; % maximum m to try

%FHA normalized gain
K = @(Q,m,Fx) Fx.^2*(m-1)./(((m-1)^2*Q^2*Fx.^2.*(1-Fx.^2).^2 + (Fx.^2*m-1).^2).^0.5);

Fx = 0:0.01:2; % Vector of posible switching frequencies, with fswmax = 2*fr

G1norm = G1/(1/n1);
G2norm = G2/(1/n2);

%color palette
startColor = [0 0 1];
endColor = [1 0 0];
gradientColors = [linspace(startColor(1), endColor(1), m_max-m_min+1)', ...
                  linspace(startColor(2), endColor(2), m_max-m_min+1)', ...
                  linspace(startColor(3), endColor(3), m_max-m_min+1)'];

figure
hold on;
grid on;
title('Normalized first stage gain limits (with FHA)','FontSize',25);
xlabel('Voltage (V)','FontSize',20);
xlim([15 43]);
ylabel('Normalized first stage gain','FontSize',20);
fontsize(gca,20,"pixels");

legendString = {};

for m = m_min:1:m_max

    max_gain = [];
    min_gain = [];

    for i = 1:size(load_values_fst_stg(1,:),2)
    
        R_min_reflected = 8*n1^2*load_values_fst_stg(1,i)/(pi^2);
        R_max_reflected = 8*n1^2*lightest_load_fst_stage(1,i)/(pi^2);

        Q_max = sqrt(Lr/Cr)/R_min_reflected;
        Q_min = sqrt(Lr/Cr)/R_max_reflected;

        gain_curve_Q_max = K(Q_max,m,Fx);
        gain_curve_Q_min = K(Q_min,m,Fx);

        max_gain = [max_gain max(gain_curve_Q_max)];
        min_gain = [min_gain gain_curve_Q_min(end)];

    end

    plot(V,min_gain,'LineWidth',1,'Color',gradientColors(m-m_min+1,:));
    plot(V,max_gain,'LineWidth',1,'Color',gradientColors(m-m_min+1,:),'HandleVisibility','off');
    legendString = [legendString ['m=' num2str(m)]];

end

plot(V,G1norm,'LineWidth',2,'Color','k')
legendString = [legendString 'Normalized G_{1}'];

lgd = legend(legendString,'Interpreter','tex','Location','eastoutside');


% Second stage

fr = 100e3;
Lr = 9.38e-6;
Cr = (1/(2*pi*fr))^2/Lr;
m_min = 12; % minimum m to try
m_max = 14; % maximum m to try

%color palette
startColor = [0 0 1];
endColor = [1 0 0];
gradientColors = [linspace(startColor(1), endColor(1), m_max-m_min+1)', ...
                  linspace(startColor(2), endColor(2), m_max-m_min+1)', ...
                  linspace(startColor(3), endColor(3), m_max-m_min+1)'];

figure
hold on;
grid on;
title('Normalized second stage gain limits (with FHA)','FontSize',25);
xlabel('Voltage (V)','FontSize',20);
xlim([15 43]);
ylabel('Normalized second stage gain','FontSize',20);
fontsize(gca,20,"pixels");

legendString = {};

for m = m_min:1:m_max

    max_gain = [];
    min_gain = [];

    for i = 1:size(load_values_scd_stg(1,:),2)
    
        R_min_reflected = 8*n2^2*load_values_scd_stg(1,i)/(pi^2);
        R_max_reflected = 8*n2^2*lightest_load_scd_stage(1,i)/(pi^2);

        Q_max = sqrt(Lr/Cr)/R_min_reflected;
        Q_min = sqrt(Lr/Cr)/R_max_reflected;

        gain_curve_Q_max = K(Q_max,m,Fx);
        gain_curve_Q_min = K(Q_min,m,Fx);

        max_gain = [max_gain max(gain_curve_Q_max)];
        min_gain = [min_gain gain_curve_Q_min(end)];

    end

    plot(V,min_gain,'LineWidth',1,'Color',gradientColors(m-m_min+1,:));
    plot(V,max_gain,'LineWidth',1,'Color',gradientColors(m-m_min+1,:),'HandleVisibility','off');
    legendString = [legendString ['m=' num2str(m)]];

end

plot(V,G2norm,'LineWidth',2,'Color','k')
legendString = [legendString 'Normalized G_{2}'];

lgd = legend(legendString,'Interpreter','tex','Location','eastoutside');


%% End of gain profiling verification

%%Functions

function G1_calc = profileG1(V_vector,n1,n2)
    
    % In this script, several times G1 profile has to be recalculated due
    % to the variability in the voltage vector length, the aim of this
    % function is to concentrate this to easily change G1 profile
    
    gain_span1 = 350./V_vector;
    %Define first stage turns ratio, second stage turns ratio is constrained by
    %the rated input voltage gain (criteria discussed for the partciular gain
    %profiles of this architecture)

    % %First idea (Same profile)
    % G1_calc = sqrt(gain_span1)-1;

    %Final iteration:
    G1_calc = zeros(1,size(V_vector,1));

    for i = 1:size(V_vector,2)

        if V_vector(i) < 36.5

            G1_calc(i) = 1/n1; %Fixed G1, G2 boosts

        else

            G1_calc(i) = gain_span1(i)/(1/n2+1)-1; %Fixed G2, G1 bucks

        end

    end

end

function G2_calc = profileG2(V_vect,G1_input)
    
    % In this script, several times G2 profile has to be recalculated due
    % to the variability in the voltage vector length, the aim of this
    % function is to concentrate this to easily change G2 profile
    
    gain_span2 = 350./V_vect;
    G2_calc = gain_span2./(G1_input+1)-1;

end
