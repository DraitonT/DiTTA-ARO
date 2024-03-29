clc, clear, close all
tic
% -------------MATLAB Script Information-------------
% Author Names: Michael Quach
% Date: 10/12/23
% Tool Version: R2023a
% Purpose of Script: Compiles all results from a particular run into a single csv
% other .m files required: None
% other files required (not .m): Folder with the individual results

%%%%%%%%%%%%%%%%%%%%%%%%% EDITABLE %%%%%%%%%%%%%%%%%%%%%%%%%
%% 0.0 Location of Cut and folder of interest
    locationOfCut = '0790';
    folderOfInterest = '\..\..\data\runsMarch\'; 

%%%%%%%%%%%%%%%%%%%%%%%%% EDITABLE %%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% NON-EDITABLE %%%%%%%%%%%%%%%%%%%%%%%

%% 1.0 Compiling the results 
    %% 1.1 Looks for the folder with all the runs for the specific cut location
        folderPath = append(pwd, folderOfInterest, locationOfCut);
        folder = dir(folderPath);
        formatSpec = '%d%f%f%f%f'; % Assumes the data format: int float float float float
    %% 1.2 Loops through the text files (results) from the desired folder
        for i = 3:length(folder)
            % Read the data using textscan
            fileID = fopen(append(folderPath, '\', folder(i).name), 'r');
            dataArray = textscan(fileID, formatSpec, 'HeaderLines', 1);
            % Close the file
            fclose(fileID);
        
            % Extract the parsed data
            nodeNumbers = dataArray{1,1};
            xLocations = dataArray{1,2};
            yLocations = dataArray{1,3};
            zLocations = dataArray{1,4};
        
            if strcmp(folder(i).name, 'Equivalent_Elastic_Strain_results.txt')
                elasticStrains = dataArray{1, 5};
            end
            
            if strcmp(folder(i).name, 'Equivalent_Stress_results.txt')
                equivalentStress = dataArray{1, 5};
            end
        
            if strcmp(folder(i).name, 'Maximum_Principal_Elastic_Strain_results.txt')
                maxPrincipalElasticStrain = dataArray{1, 5};
            end
        
            if strcmp(folder(i).name, 'Maximum_Principal_Stress_results.txt')
                maxPrincipalStress = dataArray{1, 5};
            end
        
            if strcmp(folder(i).name, 'Middle_Principal_Elastic_Strain_results.txt')
                middlePrincipalElasticStrain = dataArray{1, 5};
            end
        
            if strcmp(folder(i).name, 'Middle_Principal_Stress_results.txt')
                middlePrincipalStress = dataArray{1, 5};
            end
        
            if strcmp(folder(i).name, 'Minimum_Principal_Elastic_Strain_results.txt')
                minPrincipalElasticStrain = dataArray{1, 5};
            end
        
            if strcmp(folder(i).name, 'Minimum_Principal_Stress_results.txt')
                minPrincipalStress = dataArray{1, 5};
            end
        
            if strcmp(folder(i).name, 'Total_Deformation_results.txt')
                totalDeformation = dataArray{1, 5};
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

    toc
%%%%%%%%%%%%%%%%%%%%%%% NON-EDITABLE %%%%%%%%%%%%%%%%%%%%%%%