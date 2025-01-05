%% I-V P-V curves plot

clc, close all, clear all;

%Reducing data

projectdir = pwd; %retrieve actual path
dinfo = dir(fullfile(projectdir, '*.txt'));
filenames = fullfile({dinfo.folder}, {dinfo.name});
numfiles = length(filenames);

%Ordering datasets from less Irrandiance to greater Irradiance
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
legendString = {};
figure;
hold on;

for k = 1:numfiles

    data = readtable(sorted_filenames{k}); %Data is read in sorted Irradiance from lower to higher
    data = table2array(data);
    
    reduced_data = [0 0];
    for i = 1:size(data,1)

        if data(i,2) < 0
            break;
        end
    
        if mod(i,10) == 1 %PSIM output was really large, containing around 40000 samples, a reduction to 4000 is done
            reduced_data(round(i/10)+1,:) = data(i,:);
        end
    
    end

    plot(reduced_data(:,1),reduced_data(:,2),'LineWidth',2.5,'Color',gradientColors(k,:))
    expression = 'Ir=(\d+)';
    match = regexp(sorted_filenames{k}, expression, 'match');
    legendString{end+1} = [match{1} ' $\frac{W}{m^2}$'];

end

lgd = legend(legendString,'Interpreter','latex');
lgd.FontSize = 20;
grid on;
title('I-V curves (3SHBGHA#-680)','FontSize',25)
xlim([0 55])
xlabel('Votage (V)','FontSize',20)
ylabel('Current (A)','FontSize',20)
hold off;

legendString = {};
figure;
hold on;

for k = 1:numfiles

    data = readtable(sorted_filenames{k});
    data = table2array(data);
    
    reduced_data = [0 0];
    for i = 1:size(data,1)

        if data(i,2) < 0
            break;
        end
    
        if mod(i,10) == 1
            reduced_data(round(i/10)+1,:) = data(i,:);
        end
    
    end

    plot(reduced_data(:,1),reduced_data(:,1).*reduced_data(:,2),'LineWidth',2.5,'Color',gradientColors(k,:))
    expression = 'Ir=(\d+)';
    match = regexp(sorted_filenames{k}, expression, 'match');
    legendString{end+1} = [match{1} ' $\frac{W}{m^2}$'];

end

lgd = legend(legendString,'Location','northwest','Interpreter','latex');
lgd.FontSize = 20;
grid on;
title('P-V curves (3SHBGHA#-680)','FontSize',25)
xlabel('Votage (V)','FontSize',20)
ylabel('Power (W)','FontSize',20)

