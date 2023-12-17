clc, clear, close all

% Load the combined data from the CSV file
filePath = 'M:\dev\Ansys\Digital Twin\data\convergenceStudy\combinedData.csv'; % Update with the actual path to combinedData.csv
combinedData = readtable(filePath,'VariableNamingRule','preserve');
interestedFeature = 'Node Numbers';
interestedFeature = 'X Locations (inches)';
interestedComparsion = 'Total Deformation (in)';

% Extract unique element sizes
elementSizes = unique(combinedData.ElementSize);

% Initialize matrices for the contour plot
[X, Y] = meshgrid(combinedData.(interestedFeature), elementSizes);
Z = NaN(size(X));  % Initialize Z to NaNs

% Fill Z matrix with deformation values
for i = 1:length(elementSizes)
    % Extract data for the current element size
    currentData = combinedData(combinedData.ElementSize == elementSizes(i), :);
    for j = 1:length(currentData.(interestedFeature))
        xCoord = currentData.(interestedFeature)(j);
        def = currentData.(interestedComparsion)(j);
        Z(elementSizes(i) == Y(:,1), xCoord == X(1,:)) = def;
    end
end

% Create the contour plot
figure;
contour3(X, Y, Z, 150); % Adjust the number of levels as needed
xlabel(interestedFeature);
ylabel('Element Size');
zlabel(interestedComparsion);
title('Contour Plot of Deformation');
colorbar;
