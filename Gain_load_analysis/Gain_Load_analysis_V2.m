%% Gain and load analysis

%{

This script illustrates how the load varies depending on the power
extraction considering the P-V curves

%}

clc, close all, clear all;

%Processing solar panel's data
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
    
figure
hold on;
title('Systen Load Characteristic','FontSize',25)
ylabel('Load (\Omega)','Interpreter','tex','FontSize',20);
xlabel('Voltage (V)','FontSize',20);

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

     % Calculate the load characteristic
    load_values = 350^2 ./ (reduced_data(:, 1).*reduced_data(:,2));

    plot(reduced_data(:,1),load_values,'LineWidth',2,'Color',gradientColors(k,:))

    [min_value, min_idx] = min(load_values);
    plot(reduced_data(min_idx, 1), min_value, 'o','LineWidth',2,'Color',gradientColors(k,:),'HandleVisibility', 'off');

end

lgd = legend(legendString,'Interpreter','latex','Location','eastoutside','FontSize',20);
xlim([15 43]);
grid on;