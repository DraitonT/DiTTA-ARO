classdef TwinAnalyticsToolKit
    methods(Static)
        %% 1.0 Parsers for Ansys Mechanical Outputs 

        %% 1.1 Parser for all strain gage locations (All data)
        function groupPerCutAllData(folderOfInterest, num_nearest_nodes)
            % Initialize an empty table to store all interpolated values
            all_interpolated_data = table();
            
            %Define an array of user coordinates
            user_coordinates = [
                5.1, 6, 0.05;
                7.1, 6, 0.05;
                9.2, 6, 0.05;
                11.1, 6, 0.05;
                15.2, 6, 0.05;
                17.1, 6, 0.05;
                21.2, 6, 0.05
            ];
            
            % IDW Interpolation
            % Load the data from CSV
            filePath = append(pwd, folderOfInterest);
            folder = dir(filePath);
            
            % Loops through each of the folders
            for k = 3:length(folder)
                folderName = folder(k).name;
                % Parse the folder name to convert it to a decimal number
                cutLocation = str2double(folderName) / 100; % Assuming the folderName is something like '502'
            
                csvFileOfInterest = append(filePath, folderName, '\', folderName, 'compiled.csv');
                data = readtable(csvFileOfInterest, 'VariableNamingRule','preserve'); 
            
                % Remove 'Node Numbers' column if it exists
                if any(strcmp('Node Numbers', data.Properties.VariableNames))
                    data.('Node Numbers') = [];
                end
            
                % Loop through each set of user input coordinates
                for coord_idx = 1:size(user_coordinates, 1)
                    user_x = user_coordinates(coord_idx, 1);
                    user_y = user_coordinates(coord_idx, 2);
                    user_z = user_coordinates(coord_idx, 3);
            
                    % Calculate the Euclidean distance from each node to the user specified point
                    distances = sqrt((data.('X Locations (inches)') - user_x).^2 + ...
                                     (data.('Y Locations (inches)') - user_y).^2 + ...
                                     (data.('Z Locations (inches)') - user_z).^2);
            
                    % Find the indices of the nearest nodes
                    [sortedDistances, sortedIndices] = sort(distances);
                    nearestIndices = sortedIndices(1:num_nearest_nodes);
                    nearestDistances = sortedDistances(1:num_nearest_nodes);
            
                    % Perform IDW interpolation for each data column
                    weights = 1 ./ nearestDistances;
                    normalized_weights = weights / sum(weights);
            
                    % Preallocate interpolated values vector
                    interpolated_values = zeros(1, width(data) - 3); % Adjust the size based on the number of columns to interpolate
            
                    % Interpolate values
                    for j = 1:num_nearest_nodes
                        interpolated_values = interpolated_values + normalized_weights(j) * table2array(data(nearestIndices(j), 4:end));
                    end
            
                    % Create a new table for the interpolated point
                    interpolated_row = array2table([cutLocation, user_x, user_y, user_z, interpolated_values], ...
                                                   'VariableNames', ['CutLocation', 'X', 'Y', 'Z', data.Properties.VariableNames(4:end)]);
            
                    % Append the interpolated_row to the all_interpolated_data table
                    all_interpolated_data = [all_interpolated_data; interpolated_row];
                end
            end
            
            % Write the results to an Excel file
            outputFileName = 'InterpolatedResults.xlsx';  % Define the output file name
            writetable(all_interpolated_data, outputFileName);  % Write the table to an Excel file
            
            disp(['All interpolated values have been written to ', outputFileName]);
        end
        %% 1.2 Parser for all strain gage locations (Equivalent Elastic Strain only)
        function groupPerCutAllEquElasticStrain(folderOfInterest, num_nearest_nodes)
            % Initialize an empty array to store all interpolated values
            all_interpolated_data = [];
        
            % Define an array of user coordinates
            user_coordinates = [
                5.1, 6, 0.05;
                7.1, 6, 0.05;
                9.2, 6, 0.05;
                11.1, 6, 0.05;
                15.2, 6, 0.05;
                17.1, 6, 0.05;
                21.2, 6, 0.05
            ];
        
            % IDW Interpolation
            % Load the data from CSV
            filePath = append(pwd, folderOfInterest);
            folder = dir(filePath);
        
            % Loops through each of the folders
            for k = 3:length(folder)
                folderName = folder(k).name;
                % Parse the folder name to convert it to a decimal number
                cutLocation = str2double(folderName) / 100; % Assuming the folderName is something like '502'
        
                csvFileOfInterest = append(filePath, folderName, '\', folderName, 'compiled.csv');
                data = readtable(csvFileOfInterest, 'VariableNamingRule','preserve'); 
        
                % Remove 'Node Numbers' column if it exists
                if any(strcmp('Node Numbers', data.Properties.VariableNames))
                    data.('Node Numbers') = [];
                end
        
                % Initialize a temporary storage for the current cut's data
                cut_data = zeros(1, 8); % 7 coordinates + 1 cut location
        
                % Loop through each set of user input coordinates
                for coord_idx = 1:size(user_coordinates, 1)
                    user_x = user_coordinates(coord_idx, 1);
                    user_y = user_coordinates(coord_idx, 2);
                    user_z = user_coordinates(coord_idx, 3);
        
                    % Calculate the Euclidean distance from each node to the user specified point
                    distances = sqrt((data.('X Locations (inches)') - user_x).^2 + ...
                                     (data.('Y Locations (inches)') - user_y).^2 + ...
                                     (data.('Z Locations (inches)') - user_z).^2);
        
                    % Find the indices of the nearest nodes
                    [sortedDistances, sortedIndices] = sort(distances);
                    nearestIndices = sortedIndices(1:num_nearest_nodes);
                    nearestDistances = sortedDistances(1:num_nearest_nodes);
        
                    % Perform IDW interpolation for 'Equivalent Elastic Strains (in/in)'
                    weights = 1 ./ nearestDistances;
                    normalized_weights = weights / sum(weights);
        
                    % Interpolate 'Equivalent Elastic Strains (in/in)'
                    equivalentElasticStrain = sum(normalized_weights .* data.('Equivalent Elastic Strains (in/in)')(nearestIndices));
        
                    % Store the interpolated value in the temporary storage
                    cut_data(coord_idx) = equivalentElasticStrain;
                end
        
                % Store the cut location in the temporary storage
                cut_data(8) = cutLocation;
        
                % Append the cut data to the all_interpolated_data matrix
                all_interpolated_data = [all_interpolated_data; cut_data];
            end
        
            % Convert the array to a table with appropriate headings
            strainHeaders = arrayfun(@(n) ['Strain ' num2str(n) ' (in/in)'], 1:7, 'UniformOutput', false);
            all_interpolated_data_table = array2table(all_interpolated_data, 'VariableNames', [strainHeaders, {'CutLocation'}]);
        
            % Write the results to an Excel file
            outputFileName = 'InterpolatedResults.xlsx'; % Define the output file name
            writetable(all_interpolated_data_table, outputFileName); % Write the table to an Excel file
        
            disp(['All interpolated values have been written to ', outputFileName]);
        end

    end
end