clc, clear, close all
% Open the file containing the dataset

%%%%%%%%%%%%%%%%%%%%%%%%% EDITABLE %%%%%%%%%%%%%%%%%%%%%%%%%

locationOfCut = '402';
folderOfInterest = '\..\..\data\';


%%%%%%%%%%%%%%%%%%%%%%%%% EDITABLE %%%%%%%%%%%%%%%%%%%%%%%%%
folderPath = append(pwd, folderOfInterest, locationOfCut);
folder = dir(folderPath);

formatSpec = '%d%f%f%f%f'; % Assumes the data format: int float float float float
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
    % Display the parsed data
    dataTable = table(nodeNumbers, xLocations, yLocations, zLocations, elasticStrains, equivalentStress, maxPrincipalElasticStrain, maxPrincipalStress, middlePrincipalElasticStrain, middlePrincipalStress, minPrincipalElasticStrain, minPrincipalStress, totalDeformation);
%     
    % Display the table
    disp(dataTable);
    
    locationOfCSV = append(folderPath, '\', locationOfCut, 'compiled.csv');
    % Assuming dataTable is your table
    writetable(dataTable, locationOfCSV);
