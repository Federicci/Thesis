%{

This script process the LTSpice output to produce the 
power budget report, the Sankey Diagram of the power flow and the stresses summary. 
For using it, 3 requirements are given:

Be sure that "matlab-sankey-diagram" folder is included in the
path as the functions it utilizes comes from there.

Take the spice terminal output data into the .txt 
named "dataEntry" that includes all mean powers and stresses as
in the following example:

pt1_mean: AVG(v(pt1))=0.728356 FROM 0.005 TO 0.006
pt2_mean: AVG(v(pt2))=0.724197 FROM 0.005 TO 0.006
pt3_mean: AVG(v(pt3))=0.724197 FROM 0.005 TO 0.006
pt4_mean: AVG(v(pt4))=0.728357 FROM 0.005 TO 0.006
pt5_mean: AVG(v(pt5))=0.142563 FROM 0.005 TO 0.006
pt6_mean: AVG(v(pt6))=0.142574 FROM 0.005 TO 0.006
pt7_mean: AVG(v(pt7))=0.142575 FROM 0.005 TO 0.006
pt8_mean: AVG(v(pt8))=0.142563 FROM 0.005 TO 0.006
pcr1_mean: AVG(v(pcr1))=1.19469 FROM 0.005 TO 0.006
pcr2_mean: AVG(v(pcr2))=-0.258013 FROM 0.005 TO 0.006
pd1_mean: AVG(v(pd1))=1.92426 FROM 0.005 TO 0.006
pd2_mean: AVG(v(pd2))=1.92533 FROM 0.005 TO 0.006
pd3_mean: AVG(v(pd3))=0.701015 FROM 0.005 TO 0.006
pd4_mean: AVG(v(pd4))=0.702789 FROM 0.005 TO 0.006
pd5_mean: AVG(v(pd5))=0.70279 FROM 0.005 TO 0.006
pd6_mean: AVG(v(pd6))=0.701015 FROM 0.005 TO 0.006
pclink_mean: AVG(v(pclink))=0.0352083 FROM 0.005 TO 0.006
pcout_mean: AVG(v(pcout))=0.0144872 FROM 0.005 TO 0.006
pout_mean: AVG(v(pout))=663.208 FROM 0.005 TO 0.006
pin_mean: AVG(v(pin))=-678.015 FROM 0.005 TO 0.006
pdp1_mean: AVG(v(pdp1))=171.136 FROM 0.005 TO 0.006
pdp2_mean: AVG(v(pdp2))=273.637 FROM 0.005 TO 0.006
poutstg1_mean: AVG(v(poutstg1))=497.253 FROM 0.005 TO 0.006
poutstg2_mean: AVG(v(poutstg2))=389.571 FROM 0.005 TO 0.006
plink_mean: AVG(v(plink))=668.39 FROM 0.005 TO 0.006
max_vds_1: MAX(v(in,v1))=37.484 FROM 0.00598 TO 0.006
min_vds_1: MIN(v(in,v1))=-3.36804 FROM 0.00598 TO 0.006
max_vtrans_1: MAX(v(v1,v6))=308.609 FROM 0.00598 TO 0.006
min_vtrans_1: MIN(v(v1,v6))=-303.694 FROM 0.00598 TO 0.006
max_vcr_1: MAX(v(v5,v6))=265.453 FROM 0.00598 TO 0.006
min_vcr_1: MIN(v(v5,v6))=-265.63 FROM 0.00598 TO 0.006
max_vd_1: MAX(v(v9,v11))=0.849854 FROM 0.00598 TO 0.006
min_vd_1: MIN(v(v9,v11))=-214.223 FROM 0.00598 TO 0.006
max_vclink_1: MAX(v(v11,in))=106.375 FROM 0.00598 TO 0.006
min_vclink_1: MIN(v(v11,in))=106.243 FROM 0.00598 TO 0.006
max_vds_2: MAX(v(v11,v13))=187.985 FROM 0.00598 TO 0.006
min_vds_2: MIN(v(v11,v13))=-9.71599 FROM 0.00598 TO 0.006
max_vtrans_2: MAX(v(v13,v18))=179.459 FROM 0.00598 TO 0.006
min_vtrans_2: MIN(v(v13,v18))=-191.539 FROM 0.00598 TO 0.006
max_vcr_2: MAX(v(v17,v18))=27.3359 FROM 0.00598 TO 0.006
min_vcr_2: MIN(v(v17,v18))=-27.3829 FROM 0.00598 TO 0.006
max_vd_2: MAX(v(v21,out))=0.765625 FROM 0.00598 TO 0.006
min_vd_2: MIN(v(v21,out))=-204.332 FROM 0.00598 TO 0.006
max_vcout_2: MAX(v(v24,v11))=203.592 FROM 0.00598 TO 0.006
min_vcout_2: MIN(v(v24,v11))=203.136 FROM 0.00598 TO 0.006
max_ids_1: MAX(i(measid1))=21.3664 FROM 0.00598 TO 0.006
min_ids_1: MIN(i(measid1))=-2.98896 FROM 0.00598 TO 0.006
rms_ids_1: RMS(i(measid1))=10.8823 FROM 0.005 TO 0.006
max_itrans_1: MAX(i(lk11))=21.3664 FROM 0.00598 TO 0.006
min_itrans_1: MIN(i(lk11))=-21.7698 FROM 0.00598 TO 0.006
rms_itrans_1: RMS(i(lk11))=15.3838 FROM 0.005 TO 0.006
max_icr_1: MAX(i(lk11))=21.3664 FROM 0.00598 TO 0.006
min_icr_1: MIN(i(lk11))=-21.7698 FROM 0.00598 TO 0.006
rms_icr_1: RMS(i(lk11))=15.3838 FROM 0.005 TO 0.006
max_id_1: MAX(i(d1))=7.18212 FROM 0.00598 TO 0.006
min_id_1: MIN(i(d1))=-0.276191 FROM 0.00598 TO 0.006
rms_id_1: RMS(i(d1))=3.65841 FROM 0.005 TO 0.006
max_iclink_1: MAX(i(clink))=6.08573 FROM 0.00598 TO 0.006
min_iclink_1: MIN(i(clink))=-5.23267 FROM 0.00598 TO 0.006
rms_iclink_1: RMS(i(clink))=2.59376 FROM 0.005 TO 0.006
max_ids_2: MAX(i(measid5))=4.28834 FROM 0.00598 TO 0.006
min_ids_2: MIN(i(measid5))=-1.99127 FROM 0.00598 TO 0.006
rms_ids_2: RMS(i(measid5))=2.19741 FROM 0.005 TO 0.006
max_itrans_2: MAX(i(lk12))=4.28834 FROM 0.00598 TO 0.006
min_itrans_2: MIN(i(lk12))=-4.27942 FROM 0.00598 TO 0.006
rms_itrans_2: RMS(i(lk12))=3.10929 FROM 0.005 TO 0.006
max_icr_2: MAX(i(lk12))=4.28834 FROM 0.00598 TO 0.006
min_icr_2: MIN(i(lk12))=-4.27942 FROM 0.00598 TO 0.006
rms_icr_2: RMS(i(lk12))=3.10929 FROM 0.005 TO 0.006
max_id_2: MAX(i(d3))=2.97964 FROM 0.00598 TO 0.006
min_id_2: MIN(i(d3))=-0.29778 FROM 0.00598 TO 0.006
rms_id_2: RMS(i(d3))=1.50315 FROM 0.005 TO 0.006
max_icout_2: MAX(i(cout))=1.07426 FROM 0.00598 TO 0.006
min_icout_2: MIN(i(cout))=-2.06702 FROM 0.00598 TO 0.006
rms_icout_2: RMS(i(cout))=0.954666 FROM 0.005 TO 0.006
prs11_mean: AVG(v(prs11))=3.10111 FROM 0.005 TO 0.006
prs12_mean: AVG(v(prs12))=0.698417 FROM 0.005 TO 0.006
prs13_mean: AVG(v(prs13))=0.698078 FROM 0.005 TO 0.006
pc1_mean: AVG(v(prc1))=-1.30945e-06 FROM 0.005 TO 0.006
prs21_mean: AVG(v(prs21))=4.63566 FROM 0.005 TO 0.006
prs22_mean: AVG(v(prs22))=1.45435 FROM 0.005 TO 0.006
pc2_mean: AVG(v(prc2))=1.99468e-05 FROM 0.005 TO 0.006

%}

clc, clear, close all;

fileName = 'dataEntry.txt'; % Change this to the path of the input file

% Read the file content into a cell array of strings
fileContent = fileread(fileName);
lines = strsplit(fileContent, '\n');

% Initialize variables to store power values
pout_mean = 0;
pin_mean = 0;
pdp1_mean = 0;
pdp2_mean = 0;
poutstg1_mean = 0;
poutstg2_mean = 0;
plink_mean = 0;
stg1losses_means_sum = 0;
stg2losses_means_sum = 0;

FirstBridgeLosses = 0;
FirstRectifierLosses = 0;
FirstTransformerCopperLosses = 0;
FirstTransformerCoreLosses = 0;
FirstResonatorCapacitorLosses = 0;
FirstFilterCapacitorLosses = 0;
SecondBridgeLosses = 0;
SecondRectifierLosses = 0;
SecondTransformerCopperLosses = 0;
SecondTransformerCoreLosses = 0;
SecondResonatorCapacitorLosses = 0;
SecondFilterCapacitorLosses = 0;
others = 0;

% Loop through each line and extract the relevant power values
for i = 1:length(lines)
    line = strtrim(lines{i});
    % Use regexp to extract the numeric value after "AVG(v(...))="
    % Regular expression pattern to match the mean value after "AVG(v(...))="
    
    % AVGs filtering
    pattern = 'AVG\(v\([^)]+\)\)=(\S+)';
    match = regexp(line, pattern, 'tokens');
    
    if ~isempty(match)
        value = str2double(match{1}{1});
        
        if contains(line, 'pout_mean')
            pout_mean = value;
        elseif contains(line, 'pin_mean')
            pin_mean = value;
        elseif contains(line, 'pdp1_mean')
            pdp1_mean = value;
        elseif contains(line, 'pdp2_mean')
            pdp2_mean = value;
        elseif contains(line, 'poutstg1_mean')
            poutstg1_mean = value;
        elseif contains(line, 'poutstg2_mean')
            poutstg2_mean = value;
        elseif contains(line, 'plink_mean')
            plink_mean = value;

        elseif contains(line, {'pt1_mean', 'pt2_mean', 'pt3_mean', 'pt4_mean'})
            FirstBridgeLosses = FirstBridgeLosses + value;
            stg1losses_means_sum = stg1losses_means_sum + value;
        elseif contains(line, {'pd1_mean', 'pd2_mean'})
            FirstRectifierLosses = FirstRectifierLosses + value;
            stg1losses_means_sum = stg1losses_means_sum + value;
        elseif contains(line, 'pcr1_mean')
            FirstResonatorCapacitorLosses = FirstResonatorCapacitorLosses + value;
            stg1losses_means_sum = stg1losses_means_sum + value;
        elseif contains(line, {'prs11_mean', 'prs12_mean', 'prs13_mean'})
            FirstTransformerCopperLosses = FirstTransformerCopperLosses + value;
            stg1losses_means_sum = stg1losses_means_sum + value;
        elseif contains(line, {'pc1_mean'})
            FirstTransformerCoreLosses = FirstTransformerCoreLosses + value;
            stg1losses_means_sum = stg1losses_means_sum + value;
        elseif contains(line, 'pclink_mean')
            FirstFilterCapacitorLosses = FirstFilterCapacitorLosses + value;
            stg1losses_means_sum = stg1losses_means_sum + value;
        elseif contains(line, {'pt5_mean', 'pt6_mean', 'pt7_mean', 'pt8_mean'})
            SecondBridgeLosses = SecondBridgeLosses + value;
            stg2losses_means_sum = stg2losses_means_sum + value;
        elseif contains(line, {'pd3_mean', 'pd4_mean', 'pd5_mean', 'pd6_mean'})
            SecondRectifierLosses = SecondRectifierLosses + value;
            stg2losses_means_sum = stg2losses_means_sum + value;
        elseif contains(line, 'pcr2_mean')
            SecondResonatorCapacitorLosses = SecondResonatorCapacitorLosses + value;
            stg2losses_means_sum = stg2losses_means_sum + value;
        elseif contains(line, {'prs21_mean', 'prs22_mean'})
            SecondTransformerCopperLosses = SecondTransformerCopperLosses + value;
            stg2losses_means_sum = stg2losses_means_sum + value;
        elseif contains(line, {'pc2_mean'})
            SecondTransformerCoreLosses = SecondTransformerCoreLosses + value;
            stg2losses_means_sum = stg2losses_means_sum + value;
        elseif contains(line, 'pcout_mean')
            SecondFilterCapacitorLosses = SecondFilterCapacitorLosses + value;
            stg2losses_means_sum = stg2losses_means_sum + value;
        else
            % If everything was correctly filtered this should have all
            % unnecessary information/wrongly filtered information
            others = others + value;
        end
    end


    %MINs voltage fltering
    pattern = 'MIN\(v\([^)]+\)\)=(\S+)';
    match = regexp(line, pattern, 'tokens');
    
    if ~isempty(match)
        value = str2double(match{1}{1});
        
        % Check which variable to update based on the line content
        if contains(line, 'min_vds_1')
            min_vds_1 = value;
        elseif contains(line, 'min_vtrans_1')
            min_vtrans_1 = value;
        elseif contains(line, 'min_vcr_1')
            min_vcr_1 = value;
        elseif contains(line, 'min_vd_1')
            min_vd_1 = value;
        elseif contains(line, 'min_vclink_1')
            min_vclink_1 = value;
        elseif contains(line, 'min_vds_2')
            min_vds_2 = value;
        elseif contains(line, 'min_vtrans_2')
            min_vtrans_2 = value;
        elseif contains(line, 'min_vcr_2')
            min_vcr_2 = value;
        elseif contains(line, 'min_vd_2')
            min_vd_2 = value;
        elseif contains(line, 'min_vcout_2')
            min_vcout_2 = value;

        else
            % If everything was correctly filtered this should have all
            % unnecessary information/wrongly filtered information
            others = others + value;
        end
    end
    %MINs current fltering
    pattern = 'MIN\(i\([^)]+\)\)=(\S+)';
    match = regexp(line, pattern, 'tokens');
    
    if ~isempty(match)
        value = str2double(match{1}{1});
        
        % Check which variable to update based on the line content
        if contains(line, 'min_ids_1')
            min_ids_1 = value;
        elseif contains(line, 'min_itrans_1')
            min_itrans_1 = value;
        elseif contains(line, 'min_icr_1')
            min_icr_1 = value;
        elseif contains(line, 'min_id_1')
            min_id_1 = value;
        elseif contains(line, 'min_iclink_1')
            min_iclink_1 = value;
        elseif contains(line, 'min_ids_2')
            min_ids_2 = value;
        elseif contains(line, 'min_itrans_2')
            min_itrans_2 = value;
        elseif contains(line, 'min_icr_2')
            min_icr_2 = value;
        elseif contains(line, 'min_id_2')
            min_id_2 = value;
        elseif contains(line, 'min_icout_2')
            min_icout_2 = value;

        else
            % If everything was correctly filtered this should have all
            % unnecessary information/wrongly filtered information
            others = others + value;
        end
    end




    %MAXs voltage fltering
    pattern = 'MAX\(v\([^)]+\)\)=(\S+)';
    match = regexp(line, pattern, 'tokens');
    
    if ~isempty(match)
        value = str2double(match{1}{1});
        
        % Check which variable to update based on the line content
        if contains(line, 'max_vds_1')
            max_vds_1 = value;
        elseif contains(line, 'max_vtrans_1')
            max_vtrans_1 = value;
        elseif contains(line, 'max_vcr_1')
            max_vcr_1 = value;
        elseif contains(line, 'max_vd_1')
            max_vd_1 = value;
        elseif contains(line, 'max_vclink_1')
            max_vclink_1 = value;
        elseif contains(line, 'max_vds_2')
            max_vds_2 = value;
        elseif contains(line, 'max_vtrans_2')
            max_vtrans_2 = value;
        elseif contains(line, 'max_vcr_2')
            max_vcr_2 = value;
        elseif contains(line, 'max_vd_2')
            max_vd_2 = value;
        elseif contains(line, 'max_vcout_2')
            max_vcout_2 = value;

        else
            % If everything was correctly filtered this should have all
            % unnecessary information/wrongly filtered information
            others = others + value;
        end
    end
    
    %MAXs current fltering
    pattern = 'MAX\(i\([^)]+\)\)=(\S+)';
    match = regexp(line, pattern, 'tokens');
    
    if ~isempty(match)
        value = str2double(match{1}{1});
        
        % Check which variable to update based on the line content
        if contains(line, 'max_ids_1')
            max_ids_1 = value;
        elseif contains(line, 'max_itrans_1')
            max_itrans_1 = value;
        elseif contains(line, 'max_icr_1')
            max_icr_1 = value;
        elseif contains(line, 'max_id_1')
            max_id_1 = value;
        elseif contains(line, 'max_iclink_1')
            max_iclink_1 = value;
        elseif contains(line, 'max_ids_2')
            max_ids_2 = value;
        elseif contains(line, 'max_itrans_2')
            max_itrans_2 = value;
        elseif contains(line, 'max_icr_2')
            max_icr_2 = value;
        elseif contains(line, 'max_id_2')
            max_id_2 = value;
        elseif contains(line, 'max_icout_2')
            max_icout_2 = value;

        else
            % If everything was correctly filtered this should have all
            % unnecessary information/wrongly filtered information
            others = others + value;
        end
    end

    %RMSs fltering
    pattern = 'RMS\(i\([^)]+\)\)=(\S+)';
    match = regexp(line, pattern, 'tokens');
    
    if ~isempty(match)
        value = str2double(match{1}{1})
        
        % Check which variable to update based on the line content
        if contains(line, 'rms_ids_1')
            rms_ids_1 = value;
        elseif contains(line, 'rms_itrans_1')
            rms_itrans_1 = value;
        elseif contains(line, 'rms_icr_1')
            rms_icr_1 = value;
        elseif contains(line, 'rms_id_1')
            rms_id_1 = value;
        elseif contains(line, 'rms_iclink_1')
            rms_iclink_1 = value;
        elseif contains(line, 'rms_ids_2')
            rms_ids_2 = value;
        elseif contains(line, 'rms_itrans_2')
            rms_itrans_2 = value;
        elseif contains(line, 'rms_icr_2')
            rms_icr_2 = value;
        elseif contains(line, 'rms_id_2')
            rms_id_2 = value;
        elseif contains(line, 'rms_icout_2')
            rms_icout_2 = value;

        else
            % If everything was correctly filtered this should have all
            % unnecessary information/wrongly filtered information
            others = others + value;
        end
    end
end

% Calculate the system efficiency and partial efficiencies
efficiency_system = (pout_mean / (pout_mean+stg1losses_means_sum+stg2losses_means_sum)) * 100;
efficiency_stg1 = (poutstg1_mean/ (poutstg1_mean+stg1losses_means_sum) ) * 100;
efficiency_stg2 = (poutstg2_mean/ (poutstg2_mean+stg2losses_means_sum) ) * 100;

% Display the results
fprintf('System Efficiency: %.2f%%\n', efficiency_system);
fprintf('First Stage Efficiency: %.2f%%\n', efficiency_stg1);
fprintf('Second Stage Efficiency: %.2f%%\n', efficiency_stg2);

%% Horizontal Bar Charts with Power Budget

% Define data for the first stage
losses = [
    FirstBridgeLosses, ...
    FirstRectifierLosses, ...
    FirstTransformerCopperLosses, ...
    FirstTransformerCoreLosses, ...
    FirstFilterCapacitorLosses, ...
    FirstResonatorCapacitorLosses
];

% Define labels for each type of loss
labels = {
    '  Switches', ...
    '  Rectifier diodes', ...
    '  Transformer copper', ...
    '  Transformer core', ...
    '  Output capacitor', ...
    '  Resonator capacitor'
};

% Calculate total losses
totalLosses = sum(losses);

% Normalize values if necessary
if totalLosses < 1
    scalingFactor = 1 / totalLosses;
    losses = losses * scalingFactor;
    totalLosses = sum(losses);
end

% Create the bar chart for the first stage
figure;
subplot(2,1,1);
barh(losses, 'FaceColor', [0.8 0 0]);
xlabel('Power Loss (W)','fontSize',20);
xlim([0 ceil(max(losses)+1)]);
ylabel('Type of Loss','fontSize',20);
title('First Stage Power Budget','fontSize',25);
set(gca, 'YTickLabel', labels, 'YTick', 1:length(labels));
grid on;

% Add text labels with specific values and percentages
for i = 1:length(losses)
    valueText = sprintf('  %.3f W (%.2f%%)', losses(i), 100 * losses(i) / totalLosses);
    text(losses(i), i, valueText, ...
        'HorizontalAlignment', 'left', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 10);
end

% Define data for the second stage
losses = [
    SecondBridgeLosses, ...
    SecondRectifierLosses, ...
    SecondTransformerCopperLosses, ...
    SecondTransformerCoreLosses, ...
    SecondFilterCapacitorLosses, ...
    SecondResonatorCapacitorLosses
];

% Define labels for each type of loss
labels = {
    '  Switches', ...
    '  Rectifier diodes', ...
    '  Transformer copper', ...
    '  Transformer core', ...
    '  Output capacitor', ...
    '  Resonator capacitor'
};

% Calculate total losses
totalLosses = sum(losses);

% Normalize values if necessary
if totalLosses < 1
    scalingFactor = 1 / totalLosses;
    losses = losses * scalingFactor;
    totalLosses = sum(losses);
end

% Create the bar chart for the second stage
% figure;
subplot(2,1,2);
barh(losses, 'FaceColor', [0.8, 0, 0]);
xlabel('Power Loss (W)','FontSize',20);
ylabel('Type of Loss','FontSize',20);
xlim([0 ceil(max(losses)+1)]);
title('Second Stage Power Budget','FontSize',25);
set(gca, 'YTickLabel', labels, 'YTick', 1:length(labels));
grid on;

% Add text labels with specific values and percentages
for i = 1:length(losses)
    valueText = sprintf('  %.3f W (%.2f%%)', losses(i), 100 * losses(i) / totalLosses);
    text(losses(i), i, valueText, ...
        'HorizontalAlignment', 'left', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 10);
end




%% Sankey diagram to see power flow

figure('Name','Power flow','Units','normalized','Position',[.05,.2,.5,.56])

InputString = ['INPUT: ' num2str(pout_mean+stg1losses_means_sum+stg2losses_means_sum,'%.1f') 'W'];
Stage1String = ['STAGE I: ' num2str(poutstg1_mean,'%.1f') 'W'];
DP1String = ['DP I: ' num2str(pdp1_mean,'%.1f') 'W (' num2str(100*pdp1_mean/(pout_mean+stg1losses_means_sum+stg2losses_means_sum),'%.1f') '%)'];
Losses1String = ['LOSSES I: ' num2str(stg1losses_means_sum,'%.2f') 'W'];
LinkString = ['LINK: ' num2str(pout_mean+stg2losses_means_sum,'%.1f') 'W'];
Stage2String = ['STAGE II: ' num2str(poutstg2_mean,'%.1f') 'W'];
DP2String = ['DP II: ' num2str(pdp2_mean,'%.1f') 'W (' num2str(100*pdp2_mean/(pdp1_mean+poutstg1_mean),'%.1f') '%)'];
Losses2String = ['LOSSES II: ' num2str(stg2losses_means_sum,'%.2f') 'W'];
OutputString = ['OUTPUT: ' num2str(pout_mean,'%.1f') 'W'];

links={InputString, Stage1String, poutstg1_mean+stg1losses_means_sum;...
       InputString, DP1String, pdp1_mean;...
       Stage1String, LinkString, poutstg1_mean;...
       DP1String, LinkString, pdp1_mean;...
       Stage1String, Losses1String, stg1losses_means_sum;...
       LinkString, Stage2String, poutstg2_mean+stg2losses_means_sum;...
       LinkString, DP2String, pdp2_mean;
       Stage2String, Losses2String, stg2losses_means_sum;...
       Stage2String, OutputString, poutstg2_mean;...
       DP2String, OutputString, pdp2_mean;
       };

% Create a Sankey diagram object
SK=SSankey(links(:,1),links(:,2),links(:,3));

% Set link color rendering method
% 'left'/'right'/'interp'(default)/'map'/'simple'
SK.RenderingMethod='interp';  

% Set alignment
% 'up'/'down'/'center'(default)
SK.Align='center';

% Set text location
% 'left'(default)/'right'/'top'/'center'/'bottom'
SK.LabelLocation='right';

SK.ColorList=[1,0,0;
              0.75,0,0.25;
              0.75,0,0.25;
              0.5,0,0.5;
              0.5,0,0.5;
              0.25,0,0.75;
              0.25,0,0.75;
              0,0,1;
              0,0,1;
];

SK.NodeList={InputString, Stage1String, DP1String,...
            Losses1String, LinkString, Stage2String,...
            DP2String, Losses2String, OutputString
};

SK.Sep=.3;

% Start drawing
SK.draw()

axis([0.9 5.8 -940 20])


%% Stresses report

%Make sure that maximum stress is not hidden as a negative value
total_max_vds_1 = max(abs(max_vds_1),abs(min_vds_1));
total_max_vtrans_1 = max(abs(max_vtrans_1),abs(min_vtrans_1));
total_max_vcr_1 = max(abs(max_vcr_1),abs(min_vcr_1));
total_max_vd_1 = max(abs(max_vd_1),abs(min_vd_1));
total_max_vclink_1 = max(abs(max_vclink_1),abs(min_vclink_1));
total_max_vds_2 = max(abs(max_vds_2),abs(min_vds_2));
total_max_vtrans_2 = max(abs(max_vtrans_2),abs(min_vtrans_2));
total_max_vcr_2 = max(abs(max_vcr_2),abs(min_vcr_2));
total_max_vd_2 = max(abs(max_vd_2),abs(min_vd_2));
total_max_vcout_2 = max(abs(max_vcout_2),abs(min_vcout_2));

total_max_ids_1 = max(abs(max_ids_1),abs(min_ids_1));
total_max_itrans_1 = max(abs(max_itrans_1),abs(min_itrans_1));
total_max_icr_1 = max(abs(max_icr_1),abs(min_icr_1));
total_max_id_1 = max(abs(max_id_1),abs(min_id_1));
total_max_iclink_1 = max(abs(max_iclink_1),abs(min_iclink_1));
total_max_ids_2 = max(abs(max_ids_2),abs(min_ids_2));
total_max_itrans_2 = max(abs(max_itrans_2),abs(min_itrans_2));
total_max_icr_2 = max(abs(max_icr_2),abs(min_icr_2));
total_max_id_2 = max(abs(max_id_2),abs(min_id_2));
total_max_icout_2 = max(abs(max_icout_2),abs(min_icout_2));

% Define the associations between components and variable names.
components = {
    'First stage MOSFETs stress', 'vds_1', 'ids_1', 'rms_ids_1';
    'First stage transformer primary stress', 'vtrans_1', 'itrans_1', 'rms_itrans_1';
    'First stage resonating capacitor stress', 'vcr_1', 'icr_1', 'rms_icr_1';
    'First stage diodes stress', 'vd_1', 'id_1', 'rms_id_1';
    'First stage linkage capacitor stress', 'vclink_1', 'iclink_1', 'rms_iclink_1';
    'Second stage MOSFETs stress', 'vds_2', 'ids_2', 'rms_ids_2';
    'Second stage transformer primary stress', 'vtrans_2', 'itrans_2', 'rms_itrans_2';
    'Second stage resonating capacitor stress', 'vcr_2', 'icr_2', 'rms_icr_2';
    'Second stage diodes stress', 'vd_2', 'id_2', 'rms_id_2';
    'Second stage output capacitor stress', 'vcout_2', 'icout_2', 'rms_icout_2'
};

% Initialize the table data
numComponents = size(components, 1);
maxVoltageData = NaN(numComponents, 1);
maxCurrentData = NaN(numComponents, 1);
rmsCurrentData = NaN(numComponents, 1);

% Extract and calculate the maximum values for each component
for i = 1:numComponents
    % Extract variable names from the associations
    componentName = components{i, 1};
    vVar = components{i, 2};  % Voltage variable name
    iVar = components{i, 3};  % Current variable name
    rmsVar = components{i, 4}; % RMS current variable name
    
    % Calculate the maximum voltage if the variables exist in the workspace
    maxVoltageVar = ['total_max_' vVar];
    maxCurrentVar = ['total_max_' iVar];
    rmsCurrentVar = [rmsVar];
    
    % Use eval to extract values if the variable exists
    if exist(maxVoltageVar, 'var')
        maxVoltageData(i) = eval(maxVoltageVar);
    end
    if exist(maxCurrentVar, 'var')
        maxCurrentData(i) = eval(maxCurrentVar);
    end
    if exist(rmsCurrentVar, 'var')
        rmsCurrentData(i) = eval(rmsCurrentVar);
    end
end

% Create a table with the data
dataTable = table(components(:, 1), maxVoltageData, maxCurrentData, rmsCurrentData, ...
    'VariableNames', {'Component', 'Maximum instantaneous voltage (V)', 'Maximum instantaneous current (A)', 'Maximum RMS current (A)'});

% Convert the numerical data to strings for display in uitable
% This ensures that all elements are strings for compatibility
dataForDisplay = [dataTable.Component, ...
                  num2cell(maxVoltageData), ...
                  num2cell(maxCurrentData), ...
                  num2cell(rmsCurrentData)];

% uitable showing
f = uifigure('Name', 'Component Stress Analysis', 'NumberTitle', 'off', ...
              'Color', 'white');  % Set background color to white
t = uitable('Parent', f, 'Data', dataForDisplay, ...
        'ColumnName', dataTable.Properties.VariableNames, ...
        'RowName', {}, ...  % Removes the row numbering
        'Units', 'normalized', ...  
        'Position', [0.1 0.1 0.8 0.8]);  % Initial size, using normalized units

% Adjust column widths (e.g., set specific widths in pixels or 'auto' for automatic)
t.ColumnWidth = {250, 250, 250, 250};  % Adjust these values to your preference

% Center align all cells using uistyle and addStyle (requires MATLAB R2019b or later)
s = uistyle('HorizontalAlignment', 'center');
addStyle(t, s);

% Optionally, set the row and column striping color
t.RowStriping = 'off';  % Disable row striping
t.BackgroundColor = [1 1 1];



