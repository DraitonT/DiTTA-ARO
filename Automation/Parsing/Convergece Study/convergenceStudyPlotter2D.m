clc, clear, close all
addpath(genpath(append(pwd,'\..\..\lib'))) % Adds TwinAnalyticsToolKit.m library to the working path
tic

% -------------MATLAB Script Information-------------
% Author Names: Michael Quach
% Date: 12/16/23
% Tool Version: R2023a
% Purpose of Script: Convergence Study Values combined into seperate CSVs
% other .m files required: None
% other files required (not .m): Folder with the individual results

%%%%%%%%%%%%%%%%%%%%%%%%% EDITABLE %%%%%%%%%%%%%%%%%%%%%%%%%
% Load the combined data from the CSV file
combinedCSVFilePath = append(pwd,'\..\..\data\convergenceStudy\combinedData.csv'); 

%%%%%%%%%%%%%%%%%%%%%%%%% EDITABLE %%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% NON-EDITABLE %%%%%%%%%%%%%%%%%%%%%%%

TwinAnalyticsToolKit.TwoDConvergencePlotter(combinedCSVFilePath)

%%%%%%%%%%%%%%%%%%%%%%% NON-EDITABLE %%%%%%%%%%%%%%%%%%%%%%%