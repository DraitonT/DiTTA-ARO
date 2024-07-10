clc, clear %close all
addpath(genpath(append(pwd,'\..\..\lib'))) % Adds TwinAnalyticsToolKit.m library to the working path
tic

% -------------MATLAB Script Information-------------
% Author Names: Michael Quach
% Date: 12/16/23
% Tool Version: R2023a
% Purpose of Script: Convergence Study Values main script
%
% Extracts text files from Ansys Mechanical -> Individual CSVs -> Combines
% all csvs into 1 csv -> Plots the trade study
%
% other .m files required: TwinAnalyticsToolKit.m
% other files required (not .m): Folder with the individual results from
% each convergence test run

%%%%%%%%%%%%%%%%%%%%%%%%% EDITABLE %%%%%%%%%%%%%%%%%%%%%%%%%

%% 0.0 Filepath inputs
cutLocation = '1800';
folderOfInterest = append('\..\..\..\data\convergenceStudy\',cutLocation); 
folderPath = append(pwd, folderOfInterest);
contour = false;
generateData = false;

%%%%%%%%%%%%%%%%%%%%%%%%% EDITABLE %%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% NON-EDITABLE %%%%%%%%%%%%%%%%%%%%%%%

%% 1.0 TwinAnalyticsToolKit Functions

% Condition to check if the user wants to create csv file containing all
% the data from each of the runs
if generateData
    TwinAnalyticsToolKit.convergenceStudyParserandIndividualCSVCombiner(folderPath)
    TwinAnalyticsToolKit.convergenceStudyCSVsCombiner(folderPath)
end

% Read the combined csv and instantiates a variable for its directory
combinedCSVFilePath = append(pwd,'\..\..\data\convergenceStudy\combinedData.csv');
dataTable = readtable(append(pwd,'\..\..\..\data\convergenceStudy\',cutLocation, '\combinedData.csv'),'VariableNamingRule','preserve');

% Plots for the convergence study 
% TwinAnalyticsToolKit.plotDeformationVsElementSize(dataTable);
TwinAnalyticsToolKit.plotDeformationVsNodes(dataTable);
hold on
legend({'Damageless', '18 inches'},'location','southeast')
% TwinAnalyticsToolKit.plotDeformationVsNodesFilter(dataTable);

% Condition to check if 3D contour plot is wanted
if contour
    TwinAnalyticsToolKit.ThreeDConvergencePlotter(combinedCSVFilePath)
end

toc
%%%%%%%%%%%%%%%%%%%%%%% NON-EDITABLE %%%%%%%%%%%%%%%%%%%%%%%




