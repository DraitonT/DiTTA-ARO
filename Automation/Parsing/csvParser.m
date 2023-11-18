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
    fileName = '\502compiled.csv';
    folderOfInterest = '\..\..\data\502'; 
    
    num_nearest_nodes = 4; % Set the number of nearest nodes to use for interpolation
%%%%%%%%%%%%%%%%%%%%%%%%% EDITABLE %%%%%%%%%%%%%%%%%%%%%%%%%

%% 1.0 IDW Interpolation
    % Ask the user for input coordinates
    user_x = input('Enter X coordinate: ');
    user_y = input('Enter Y coordinate: ');
    user_z = input('Enter Z coordinate: ');
    
    % Load the data from CSV
    filePath = append(pwd, folderOfInterest, fileName);
    append(pwd,folderOfInterest, fileName)
    data = readtable(filePath); 
    
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
    for i = 1:num_nearest_nodes
        interpolated_values = interpolated_values + normalized_weights(i) * table2array(data(nearestIndices(i), 4:end));
    end

%% 2.0 Results from Interpolation
    % Display nodes used for interpolation
    disp('Nodes used for interpolation and their coordinates:');
    for i = 1:num_nearest_nodes
        disp(['Node ', num2str(nearestIndices(i)), ': (', ...
              num2str(data.XLocations_inches_(nearestIndices(i))), ', ', ...
              num2str(data.YLocations_inches_(nearestIndices(i))), ', ', ...
              num2str(data.ZLocations_inches_(nearestIndices(i))), ')']);
    end
    
    % Create a new table for the interpolated point
    interpolated_row = array2table([user_x, user_y, user_z, interpolated_values], ...
                                   'VariableNames', data.Properties.VariableNames);

    disp(interpolated_row)

%     % Display nodes used for interpolation, their coordinates, and associated values
%     disp('Nodes used for interpolation, their coordinates, and associated values:');
%     for i = 1:num_nearest_nodes
%         nodeIndex = nearestIndices(i);
%         nodeData = data(nodeIndex, :);
%         nodeNum = nodeData.NodeNumbers;
%         nodeX = nodeData.XLocations_inches_;
%         nodeY = nodeData.YLocations_inches_;
%         nodeZ = nodeData.ZLocations_inches_;
%         
%         % Display the node number and its coordinates
%         fprintf('Node %d: (%.4f, %.4f, %.4f)\n', nodeNum, nodeX, nodeY, nodeZ);
%         
%         % Display the associated values for this node
%         disp(table2array(nodeData(1, 4:end)));
%     end
toc