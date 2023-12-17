clc, clear, close all

% Load the combined data from the CSV file
filePath = 'M:\dev\Ansys\Digital Twin\data\convergenceStudy\combinedData.csv'; % Update with the actual path to combinedData.csv
combinedData = readtable(filePath,'VariableNamingRule','preserve');

% Extract unique element sizes
elementSizes = unique(combinedData.ElementSize);

% Initialize a figure for the plot
figure;
hold on;

% Loop through each element size to plot
for i = 1:length(elementSizes)
    % Extract data for the current element size
    currentData = combinedData(combinedData.ElementSize == elementSizes(i), :);

    % Plot X-Coordinates vs. Deformation for the current element size
    plot(currentData.('X Locations (inches)'), currentData.('Total Deformation (in)'), 'DisplayName', ['Element Size ' num2str(elementSizes(i))]);
end

% Add labels, title, and legend
xlabel('X Coordinates (inches)');
ylabel('Total Deformation (in)');
title('X-Coordinates vs. Deformation for Different Element Sizes');
legend('show');
grid on;

hold off;
