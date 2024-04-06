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

convergenceStudyCSVCombiner(folderPath)

