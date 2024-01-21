classdef TwinAnalyticsToolKit
    methods(Static)
        %% 1.0 Parsers for Ansys Mechanical Outputs (Cut Location Runs)

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
        %% 1.2 Parser for all strain gage locations (Equivalent Elastic Strain only) using IDW Interpolation
        function groupPerCutAllEquElasticStrain(folderOfInterest, num_nearest_nodes)
            % Initialize an empty array to store all interpolated values
            all_interpolated_data = [];
            % Initialize an empty array to store interpolation details
            all_interpolation_details = [];

            % Define an array of user coordinates
            user_coordinates = [
                5.1, 6, 0;
                7.1, 6, 0;
                9.2, 6, 0;
                11.1, 6, 0;
                15.2, 6, 0;
                17.1, 6, 0;
                21.2, 6, 0
                ];

            % Load the data from CSV
            filePath = append(pwd, folderOfInterest);
            folder = dir(filePath);

            % Loops through each of the folders
            for k = 3:length(folder)
                folderName = folder(k).name;
                cutLocation = str2double(folderName) / 100; % Assuming the folderName is something like '502'

                csvFileOfInterest = append(filePath, folderName, '\', folderName, 'compiled.csv');
                data = readtable(csvFileOfInterest, 'VariableNamingRule','preserve');

                % Remove 'Node Numbers' column if it exists
                if any(strcmp('Node Numbers', data.Properties.VariableNames))
                    data.('Node Numbers') = [];
                end

                % Initialize a temporary storage for the current cut's data
                cut_data = zeros(1, 8); % 7 coordinates + 1 cut location
                % New temporary storage for interpolation details
                temp_interpolation_details = zeros(num_nearest_nodes*size(user_coordinates, 1), 7); % Node index, X, Y, Z, Weight, Strain Value, Cut Location

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

                    % Modified IDW interpolation for 'Equivalent Elastic Strains (in/in)'
                    if any(nearestDistances == 0)
                        % Assign high weight to zero distances and zero to others
                        weights = nearestDistances == 0;
                        weights = weights; % Adjust this high value as needed
                        normalized_weights = weights;
                    else
                        % Original weighting calculation if no distances are zero
                        weights = 1 ./ nearestDistances;
                        normalized_weights = weights / sum(weights);
                    end

                    % Interpolate 'Equivalent Elastic Strains (in/in)'
                    equivalentElasticStrain = sum(normalized_weights .* data.('Equivalent Elastic Strains (in/in)')(nearestIndices));

                    % Store the interpolated value in the temporary storage
                    cut_data(coord_idx) = equivalentElasticStrain;

                    % Store interpolation details including strain values
                    for i = 1:num_nearest_nodes
                        nodeIndex = nearestIndices(i);
                        detail_idx = (coord_idx - 1) * num_nearest_nodes + i;
                        temp_interpolation_details(detail_idx, :) = [nodeIndex, data.('X Locations (inches)')(nodeIndex), ...
                            data.('Y Locations (inches)')(nodeIndex), ...
                            data.('Z Locations (inches)')(nodeIndex), normalized_weights(i), ...
                            data.('Equivalent Elastic Strains (in/in)')(nodeIndex), cutLocation];
                    end
                end

                % Store the cut location in the temporary storage
                cut_data(8) = cutLocation;

                % Append the cut data and details to their respective matrices
                all_interpolated_data = [all_interpolated_data; cut_data];
                all_interpolation_details = [all_interpolation_details; temp_interpolation_details];
            end

            % Convert the array to a table with appropriate headings for interpolated data
            strainHeaders = arrayfun(@(n) ['Strain ' num2str(n) ' (in/in)'], 1:7, 'UniformOutput', false);
            all_interpolated_data_table = array2table(all_interpolated_data, 'VariableNames', [strainHeaders, {'CutLocation'}]);

            % Write the interpolated data results to an Excel file
            outputFileName = 'InterpolatedResults.xlsx';
            writetable(all_interpolated_data_table, outputFileName);

            % Convert the details array to a table and write to a new CSV
            detailHeaders = {'NodeIndex', 'X', 'Y', 'Z', 'Weight', 'StrainValue', 'CutLocation'};
            interpolation_details_table = array2table(all_interpolation_details, 'VariableNames', detailHeaders);
            detailOutputFileName = 'InterpolationDetails.csv';
            writetable(interpolation_details_table, detailOutputFileName);

            disp(['All interpolation details have been written to ', detailOutputFileName]);
        end

        %% 1.2.1 Plotter
        function elasticStrainPlotter(csvName)
            data = readmatrix(csvName); % Read the CSV file into a matrix (assuming it has a header row).

            % Extract the columns you need from the data matrix
            Strain1 = data(:, 1);
            Strain2 = data(:, 2);
            Strain3 = data(:, 3);
            Strain4 = data(:, 4);
            Strain5 = data(:, 5);
            Strain6 = data(:, 6);
            Strain7 = data(:, 7);
            CutLocation = data(:, 8);



            figure;
            hold on;
            plot(CutLocation, Strain1, 'b', 'DisplayName', 'Strain 1');
            plot(CutLocation, Strain2, 'g', 'DisplayName', 'Strain 2');
            plot(CutLocation, Strain3, 'r', 'DisplayName', 'Strain 3');
            plot(CutLocation, Strain4, 'c', 'DisplayName', 'Strain 4');
            plot(CutLocation, Strain5, 'm', 'DisplayName', 'Strain 5');
            plot(CutLocation, Strain6, 'y', 'DisplayName', 'Strain 6');
            plot(CutLocation, Strain7, 'k', 'DisplayName', 'Strain 7');

            xlabel('Cut Location (inches)', 'Interpreter', 'latex');
            ylabel('Strain (in/in)', 'Interpreter', 'latex');
            title('Strain vs. Cut Location', 'Interpreter', 'latex');
            legend('Location', 'Best', 'Interpreter', 'latex');

            grid on;
            hold off;
        end

        %% 2.0 Convergence Study Related Functions
        %% 2.1 Ansys Mechanical text file parsers and csv combine
        function convergenceStudyParserandIndividualCSVCombiner(folderPath)
            files = dir(fullfile(folderPath));  % Update the pattern to match your filenames
            formatSpec = '%d%f%f%f%f'; % Assumes the data format: int float float float float
            folder = dir(folderPath);

            % Reads through the folder of all the files of a specific run
            for i = 3:length(files)
                % Read the data using textscan
                filePath = append(folderPath,'\', folder(i).name);
                individualFilePath = dir(filePath);
                x = strsplit(filePath,'\');

                % If a combined CSV of all the runs exist, deletes and
                % skips the index
                if strcmp(x{12}, 'combinedData.csv')
                    delete(append(individualFilePath.folder,'\',individualFilePath.name))
                else

                    % Occurs if the file isn't 'combinedData.csv'
                    for j = 3:length(individualFilePath)
                        if strcmp(append(folder(i).name, 'compiled.csv'), individualFilePath(j).name)
                            %     delete(append(filePath,'\',folder(i).name, 'compiled.csv'))
                        else
                            fileID = fopen(append(filePath,'\',individualFilePath(j).name), 'r');
                            dataArray = textscan(fileID, formatSpec, 'HeaderLines', 1);
                            % Close the file
                            fclose(fileID);

                            % Extract the parsed data
                            nodeNumbers = dataArray{1,1};
                            xLocations = dataArray{1,2};
                            yLocations = dataArray{1,3};
                            zLocations = dataArray{1,4};

                            % Allocates the array based on the type of
                            % results of a specific file
                            if strcmp(individualFilePath(j).name, 'Equivalent_Elastic_Strain_results.txt')
                                elasticStrains = dataArray{1, 5};
                            end

                            if strcmp(individualFilePath(j).name, 'Equivalent_Stress_results.txt')
                                equivalentStress = dataArray{1, 5};
                            end

                            if strcmp(individualFilePath(j).name, 'Maximum_Principal_Elastic_Strain_results.txt')
                                maxPrincipalElasticStrain = dataArray{1, 5};
                            end

                            if strcmp(individualFilePath(j).name, 'Maximum_Principal_Stress_results.txt')
                                maxPrincipalStress = dataArray{1, 5};
                            end

                            if strcmp(individualFilePath(j).name, 'Middle_Principal_Elastic_Strain_results.txt')
                                middlePrincipalElasticStrain = dataArray{1, 5};
                            end

                            if strcmp(individualFilePath(j).name, 'Middle_Principal_Stress_results.txt')
                                middlePrincipalStress = dataArray{1, 5};
                            end

                            if strcmp(individualFilePath(j).name, 'Minimum_Principal_Elastic_Strain_results.txt')
                                minPrincipalElasticStrain = dataArray{1, 5};
                            end

                            if strcmp(individualFilePath(j).name, 'Minimum_Principal_Stress_results.txt')
                                minPrincipalStress = dataArray{1, 5};
                            end

                            if strcmp(individualFilePath(j).name, 'Total_Deformation_results.txt')
                                totalDeformation = dataArray{1, 5};
                            end
                        end
                    end

                    % Saves the combined results into an individual CSV
                    % file for a single run
                    columnNames = {'Node Numbers', 'X Locations (inches)', 'Y Locations (inches)', 'Z Locations (inches)', ...
                        'Equivalent Elastic Strains (in/in)', 'Equivalent Stress (psi)', ...
                        'Max Principal Elastic Strain (in/in)', 'Max Principal Stress (psi)', ...
                        'Middle Principal Elastic Strain (in/in)', 'Middle Principal Stress (psi)', ...
                        'Min Principal Elastic Strain (in/in)', 'Min Principal Stress (psi)', ...
                        'Total Deformation (in)'};
                    dataTable = table(nodeNumbers, xLocations, yLocations, zLocations, elasticStrains, equivalentStress, maxPrincipalElasticStrain, maxPrincipalStress, middlePrincipalElasticStrain, middlePrincipalStress, minPrincipalElasticStrain, minPrincipalStress, totalDeformation);
                    dataTable.Properties.VariableNames = columnNames;
                    disp(dataTable);
                    locationOfCSV = append(filePath, '\', folder(i).name, 'compiled.csv');
                    writetable(dataTable, locationOfCSV);
                end


            end
        end
        %% 2.2 Convergence Study CSV Combiner
        function convergenceStudyCSVsCombiner(folderPath)
            %CONVERGENCESTUDYCSVSCOMBINER purpose of function is to grab all
            %the individual csvs from all the element size of a particular
            %run and combine them into a single csv file

            elementFolders = dir(fullfile(folderPath, 'elementsize*')); % Folders for different element sizes

            % Initialize variables to store combined data
            combinedData = [];

            % Loop over each element size folder
            for i = 1:length(elementFolders)
                if elementFolders(i).isdir
                    % Extract element size from the folder name (e.g., 'elementsize0p5')
                    elementSizeStr = regexp(elementFolders(i).name, 'elementsize(\d+p\d+)', 'tokens');
                    elementSizeStr = elementSizeStr{1}{1};
                    elementSize = str2double(strrep(elementSizeStr, 'p', '.'));

                    % Construct path to the individual folder
                    individualFolderPath = fullfile(folderPath, elementFolders(i).name);

                    % Get all .csv files in this folder
                    individualFiles = dir(fullfile(individualFolderPath, '*.csv'));

                    % Process each file within this folder
                    for j = 1:length(individualFiles)
                        % Construct path to individual file
                        individualFilePath = fullfile(individualFolderPath, individualFiles(j).name);

                        % Read the data from each file
                        dataTable = readtable(individualFilePath, 'VariableNamingRule','preserve');

                        % Add a column for element size
                        dataTable.ElementSize = repmat(elementSize, height(dataTable), 1);

                        % Append the data table to the combined data
                        combinedData = [combinedData; dataTable]; % Assumes all data tables have the same structure
                    end
                end
            end

            % Define the output file path for the combined data
            outputFilePath = fullfile(folderPath, 'combinedData.csv');

            % Write the combined data to a CSV file
            writetable(combinedData, outputFilePath);
        end
        %% 2.3 2D Convergence Feature Plotter
        function TwoDConvergencePlotter(filePath)
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
        end

        %% 2.4 3D Convervgence Feature Plotter
        function ThreeDConvergencePlotter(filePath)
            combinedData = readtable(filePath,'VariableNamingRule','preserve');
            % interestedFeature = 'Node Numbers';
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

        end

        %% 2.5 2D Convergence Plotter
        function TwoDConvergencePlotter2(filePath)
            combinedData = readtable(filePath,'VariableNamingRule','preserve');
            % User-specified location
            user_x = 24;
            user_y = 3;
            user_z = 0;

            % Extract unique element sizes
            elementSizes = unique(combinedData.ElementSize);

            % Initialize a figure for the plot
            figure;
            hold on;

            % Loop through each element size to plot
            for i = 1:length(elementSizes)
                % Extract data for the current element size
                currentData = combinedData(combinedData.ElementSize == elementSizes(i), :);

                % Calculate the distance from each node to the user-specified location
                distances = sqrt((currentData.('X Locations (inches)') - user_x).^2 + ...
                    (currentData.('Y Locations (inches)') - user_y).^2 + ...
                    (currentData.('Z Locations (inches)') - user_z).^2);

                % Find the index of the node closest to the user-specified location
                [~, closestIndex] = min(distances);

                % Get the number of nodes and deformation for the closest node
                numNodes = currentData.('Node Numbers')(closestIndex);
                deformation = currentData.('Total Deformation (in)')(closestIndex);

                % Plot the number of nodes vs. deformation for the closest node
                plot(numNodes, deformation, 'o', 'DisplayName', ['Element Size ' num2str(elementSizes(i))]);
            end

            % Add labels, title, and legend
            xlabel('Node Number');
            ylabel('Total Deformation (in)');
            title('Deformation at Point (24,3,0) Across Different Element Sizes');
            legend('show');
            grid on;

            hold off;
        end

        %% 2.6 Plotting deformation vs the elemetn size
        function plotDeformationVsElementSize(dataTable)
            % Filters data for the right-most edge
            rightEdgeData = dataTable(dataTable.('X Locations (inches)') == max(dataTable.('X Locations (inches)')), :);

            % Group by element size and calculate mean deformation
            groupedData = varfun(@mean, rightEdgeData, 'InputVariables', 'Total Deformation (in)', ...
                'GroupingVariables', 'ElementSize');

            % Plotting
            figure;
            plot(groupedData.ElementSize, groupedData.('mean_Total Deformation (in)'), 'o-');
            title('Average Deformation at Right-Most Edge vs Element Size', 'Interpreter', 'latex');
            xlabel('Element Size', 'Interpreter', 'latex');
            ylabel('Average Deformation (in)', 'Interpreter', 'latex');
            grid on;
        end

        %% 2.7 Plots the deformation against the number of nodes
        function plotDeformationVsNodes(dataTable)
            % Filters data for the right-most edge
            rightEdgeData = dataTable(dataTable.('X Locations (inches)') == max(dataTable.('X Locations (inches)')), :);

            % Sort data by node numbers
            sortedDataByNodes = sortrows(rightEdgeData, 'Node Numbers');

            % Plotting
            figure;
            plot(sortedDataByNodes.('Node Numbers'), sortedDataByNodes.('Total Deformation (in)'), 'o-');
            title('Deformation vs Number of Nodes at Right-Most Edge', 'Interpreter', 'latex');
            xlabel('Node Number', 'Interpreter', 'latex');
            ylabel('Total Deformation (in)', 'Interpreter', 'latex');
            grid on;
        end

        %% 2.8 Plots the Deformation against the number of nodes (Right most edge for a certain amount of nodes)
        function plotDeformationVsNodesFilter(dataTable)
            % Filters data for the right-most edge
            rightEdgeData = dataTable(dataTable.('X Locations (inches)') == max(dataTable.('X Locations (inches)')), :);

            % Further filtering to include only node numbers up to 10,000
            filteredDataByNodes = rightEdgeData(rightEdgeData.('Node Numbers') <= 40000, :);

            % Sort data by node numbers
            sortedDataByNodes = sortrows(filteredDataByNodes, ('Node Numbers'));

            % Plotting
            figure;
            plot(sortedDataByNodes.('Node Numbers'), sortedDataByNodes.('Total Deformation (in)'), 'o-');
            title('Deformation vs Number of Nodes at Right-Most Edge (Up to Node 40,000)', 'Interpreter', 'latex');
            xlabel('Node Number', 'Interpreter', 'latex');
            ylabel('Total Deformation (in)', 'Interpreter', 'latex');
            grid on;
        end


    end
end