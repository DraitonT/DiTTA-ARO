clc, clear, close all
tic
% -------------MATLAB Script Information-------------
% Author Names: Michael Quach
% Date: 11/17/23
% Tool Version: R2023a
% Purpose of Script: Displays the Interpolated results from all combined
% runs of specific cut
% other .m files required: None
% other files required (not .m): Folder with the individual results

%%%%%%%%%%%%%%%%%%%%%%%%% EDITABLE %%%%%%%%%%%%%%%%%%%%%%%%%
%% 0.0 Location of Cut and folder of interest
%     fileName = '502compiled.csv';
folderOfInterest = '\..\..\data\'; 

num_nearest_nodes = 4; % Set the number of nearest nodes to use for interpolation
%%%%%%%%%%%%%%%%%%%%%%%%% EDITABLE %%%%%%%%%%%%%%%%%%%%%%%%%
user_x = 1;
user_y = 1;
user_z = 1;
%% Initialize an empty table to store all interpolated values
all_interpolated_data = table();

%% 1.0 IDW Interpolation
% Load the data from CSV
filePath = append(pwd, folderOfInterest);
folder = dir(filePath);

% Loops through each of the folders
for k = 3:length(folder)
    csvFileOfInterest = append(filePath,folder(k).name, '\',folder(k).name, 'compiled.csv');
    data = readtable(csvFileOfInterest); 
    % Calculate the Euclidean distance from each node to the user specified point
    distances = sqrt((data.XLocations_inches_ - user_x).^2 + ...
                     (data.YLocations_inches_ - user_y).^2 + ...
                     (data.ZLocations_inches_ - user_z).^2);
    
    % Find the indices of the nearest nodes
    [sortedDistances, sortedIndices] = sort(distances);
    nearestIndices = sortedIndices(1:num_nearest_nodes);
    nearestDistances = sortedDistances(1:num_nearest_nodes);
    
    % Perform IDW interpolation for each column
    weights = 1 ./ nearestDistances;
    normalized_weights = weights / sum(weights);
    
    % Preallocate interpolated values vector
    interpolated_values = zeros(1, width(data)-3);  % Adjust the size based on the number of columns to interpolate
    
    % Interpolate values
    for j = 1:num_nearest_nodes
        interpolated_values = interpolated_values + normalized_weights(j) * table2array(data(nearestIndices(j), 4:end));
    end
    
    % Create a new table for the interpolated point
    interpolated_row = array2table([user_x, user_y, user_z, interpolated_values], ...
                                   'VariableNames', data.Properties.VariableNames);
    
    % Append the interpolated_row to the all_interpolated_data table
    all_interpolated_data = [all_interpolated_data; interpolated_row];
end

%% 2.0 Write the results to an Excel file
outputFileName = 'InterpolatedResults.xlsx';  % Define the output file name
writetable(all_interpolated_data, outputFileName);  % Write the table to an Excel file

disp(['All interpolated values have been written to ', outputFileName]);

toc