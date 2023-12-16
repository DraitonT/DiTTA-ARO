clc, clear, close all
addpath(genpath(append(pwd,'\..\..\lib'))) % Adds TwinAnalyticsToolKit.m library to the working path
tic

% -------------MATLAB Script Information-------------
% Author Names: Michael Quach
% Date: 11/17/23
% Tool Version: R2023a
% Purpose of Script: Plots values from interpolated data
% runs of specific cut
% other .m files required: None
% other files required (not .m): Folder with the individual results

%%%%%%%%%%%%%%%%%%%%%%%%% EDITABLE %%%%%%%%%%%%%%%%%%%%%%%%%

folderOfInterest = '\..\..\data\convergenceStudy'; 
folderPath = append(pwd, folderOfInterest);

files = dir(fullfile(folderPath));  % Update the pattern to match your filenames
formatSpec = '%d%f%f%f%f'; % Assumes the data format: int float float float float
folder = dir(folderPath);

    for i = 3:length(files)
    % Read the data using textscan
            filePath = append(folderPath,'\', folder(i).name);
            individualFilePath = dir(filePath);
         for j = 3:length(individualFilePath)
            
            fileID = fopen(append(filePath,'\',individualFilePath(j).name), 'r');
            dataArray = textscan(fileID, formatSpec, 'HeaderLines', 1);
            % Close the file
            fclose(fileID);
        
            % Extract the parsed data
            nodeNumbers = dataArray{1,1};
            xLocations = dataArray{1,2};
            yLocations = dataArray{1,3};
            zLocations = dataArray{1,4};
        
            if strcmp(folder(j).name, 'Equivalent_Elastic_Strain_results.txt')
                elasticStrains = dataArray{1, 5};
            end
            
            if strcmp(folder(j).name, 'Equivalent_Stress_results.txt')
                equivalentStress = dataArray{1, 5};
            end
        
            if strcmp(folder(j).name, 'Maximum_Principal_Elastic_Strain_results.txt')
                maxPrincipalElasticStrain = dataArray{1, 5};
            end
        
            if strcmp(folder(j).name, 'Maximum_Principal_Stress_results.txt')
                maxPrincipalStress = dataArray{1, 5};
            end
        
            if strcmp(folder(j).name, 'Middle_Principal_Elastic_Strain_results.txt')
                middlePrincipalElasticStrain = dataArray{1, 5};
            end
        
            if strcmp(folder(j).name, 'Middle_Principal_Stress_results.txt')
                middlePrincipalStress = dataArray{1, 5};
            end
        
            if strcmp(folder(j).name, 'Minimum_Principal_Elastic_Strain_results.txt')
                minPrincipalElasticStrain = dataArray{1, 5};
            end
        
            if strcmp(folder(j).name, 'Minimum_Principal_Stress_results.txt')
                minPrincipalStress = dataArray{1, 5};
            end
        
            if strcmp(folder(j).name, 'Total_Deformation_results.txt')
                totalDeformation = dataArray{1, 5};
            end
         end
    end

  %% 2.0 Saves the combined results into a CSV file
  columnNames = {'Node Numbers', 'X Locations (inches)', 'Y Locations (inches)', 'Z Locations (inches)', ...
           'Equivalent Elastic Strains (in/in)', 'Equivalent Stress (psi)', ...
           'Max Principal Elastic Strain (in/in)', 'Max Principal Stress (psi)', ...
           'Middle Principal Elastic Strain (in/in)', 'Middle Principal Stress (psi)', ...
           'Min Principal Elastic Strain (in/in)', 'Min Principal Stress (psi)', ...
           'Total Deformation (in)'};
        dataTable = table(nodeNumbers, xLocations, yLocations, zLocations, elasticStrains, equivalentStress, maxPrincipalElasticStrain, maxPrincipalStress, middlePrincipalElasticStrain, middlePrincipalStress, minPrincipalElasticStrain, minPrincipalStress, totalDeformation);
        dataTable.Properties.VariableNames = columnNames;
        disp(dataTable);
        locationOfCSV = append(folderPath, '\', locationOfCut, 'compiled.csv');
        writetable(dataTable, locationOfCSV);



