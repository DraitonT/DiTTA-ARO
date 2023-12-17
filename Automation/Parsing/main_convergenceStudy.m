clc, clear, close all
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
% other files required (not .m): Folder with the individual results

%%%%%%%%%%%%%%%%%%%%%%%%% EDITABLE %%%%%%%%%%%%%%%%%%%%%%%%%
%% 0.0 Filepath inputs
folderOfInterest = '\..\..\data\convergenceStudy'; 
folderPath = append(pwd, folderOfInterest);
combinedCSVFilePath = append(pwd,'\..\..\data\convergenceStudy\combinedData.csv');

%%%%%%%%%%%%%%%%%%%%%%%%% EDITABLE %%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% NON-EDITABLE %%%%%%%%%%%%%%%%%%%%%%%

%% 1.0 TwinAnalyticsToolKit Functions
if exist(combinedCSVFilePath, 'file')
    delete(combinedCSVFilePath)
end

TwinAnalyticsToolKit.convergenceStudyParserandIndividualCSVCombiner(folderPath)
TwinAnalyticsToolKit.convergenceStudyCSVsCombiner(folderPath)
TwinAnalyticsToolKit.TwoDConvergencePlotter(combinedCSVFilePath)
TwinAnalyticsToolKit.ThreeDConvergencePlotter(combinedCSVFilePath)







