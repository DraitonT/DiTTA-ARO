clc; clear; close all;
addpath(genpath(fullfile(pwd, '..\..\lib'))); % Adds TwinAnalyticsToolKit.m library to the working path
tic;

% -------------MATLAB Script Information-------------
% Author Names: Michael Quach
% Date: 11/17/23
% Tool Version: R2023a
% Purpose of Script: Plots values from interpolated data
% runs of specific cut
% other .m files required: None
% other files required (not .m): Folder with the individual results

%%%%%%%%%%%%%%%%%%%%%%%%% EDITABLE %%%%%%%%%%%%%%%%%%%%%%%%%

folderOfInterest = '..\..\data\convergenceStudy'; 
folderPath = fullfile(pwd, folderOfInterest);

% Find all CSV files in the folder and delete them
csvFiles = dir(fullfile(folderPath, '*.csv')); 
for k = 1:length(csvFiles)
    delete(fullfile(folderPath, csvFiles(k).name)); % Delete the CSV file
end

% Update the pattern to match your filenames
files = dir(folderPath); 
formatSpec = '%d%f%f%f%f'; % Assumes the data format: int float float float float

for i = 3:length(files)
    % Skip if not a folder
    if ~files(i).isdir
        continue;
    end
    
    % Process each subfolder within the folder of interest
    subFolderPath = fullfile(folderPath, files(i).name);
    individualFiles = dir(fullfile(subFolderPath, '*.txt'));  % Update the pattern to match your filenames

    % Initialize variables
    nodeNumbers = [];
    xLocations = [];
    yLocations = [];
    zLocations = [];
    elasticStrains = [];
    equivalentStress = [];
    maxPrincipalElasticStrain = [];
    maxPrincipalStress = [];
    middlePrincipalElasticStrain = [];
    middlePrincipalStress = [];
    minPrincipalElasticStrain = [];
    minPrincipalStress = [];
    totalDeformation = [];

    for j = 1:length(individualFiles)
        if individualFiles(j).isdir
            continue;
        end

        fileID = fopen(fullfile(subFolderPath, individualFiles(j).name), 'r');
        dataArray = textscan(fileID, formatSpec, 'HeaderLines', 1);
        fclose(fileID); % Close the file

        % Extract the parsed data
        nodeNumbers = dataArray{:,1};
        xLocations = dataArray{:,2};
        yLocations = dataArray{:,3};
        zLocations = dataArray{:,4};

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

    % 2.0 Saves the combined results into a CSV file
    columnNames = {'Node Numbers', 'X Locations (inches)', 'Y Locations (inches)', 'Z Locations (inches)', ...
       'Equivalent Elastic Strains (in/in)', 'Equivalent Stress (psi)', ...
       'Max Principal Elastic Strain (in/in)', 'Max Principal Stress (psi)', ...
       'Middle Principal Elastic Strain (in/in)', 'Middle Principal Stress (psi)', ...
       'Min Principal Elastic Strain (in/in)', 'Min Principal Stress (psi)', ...
       'Total Deformation (in)'};
    dataTable = table(nodeNumbers, xLocations, yLocations, zLocations, elasticStrains, equivalentStress, ...
                      maxPrincipalElasticStrain, maxPrincipalStress, middlePrincipalElasticStrain, ...
                      middlePrincipalStress, minPrincipalElasticStrain, minPrincipalStress, totalDeformation, ...
                      'VariableNames', columnNames);
    disp(dataTable);
    locationOfCSV = fullfile(subFolderPath, 'compiled_results.csv'); % Define the CSV file name
    writetable(dataTable, locationOfCSV);
end

toc; % Ends timing the script
