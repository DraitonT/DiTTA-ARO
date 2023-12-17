clc, clear, close all
addpath(genpath(append(pwd,'\..\..\lib'))) % Adds TwinAnalyticsToolKit.m library to the working path
tic

% -------------MATLAB Script Information-------------
% Author Names: Michael Quach
% Date: 12/16/23
% Tool Version: R2023a
% Purpose of Script: Convergence Study Values combined into a single CSV with element size
% other .m files required: None
% other files required (not .m): Folder with the individual results

%%%%%%%%%%%%%%%%%%%%%%%%% EDITABLE %%%%%%%%%%%%%%%%%%%%%%%%%

folderOfInterest = '\..\..\data\convergenceStudy'; 
folderPath = fullfile(pwd, folderOfInterest);

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

toc
