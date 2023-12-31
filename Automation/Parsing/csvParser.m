clc, clear, close all
addpath(genpath(append(pwd,'\..\..\lib'))) %Adds TwinAnalyticsToolKit.m library to the working path
tic
% -------------MATLAB Script Information-------------
% Author Names: Michael Quach
% Date: 11/17/23
% Tool Version: R2023a
% Purpose of Script: Displays the Interpolated results from all combined
% runs of specific cut
% other .m files required: None
% other files required (not .m): Folder with the individual results

%%%%%%%%%%%%%%%%%%%%%%%%% EDITABLE %%%%%%%%%%%%%%%%%%%%%%%%%

%% 0.0 Location of all data files
folderOfInterest = '\..\..\data\runs\'; 
num_nearest_nodes = 4; % Set the number of nearest nodes to use for interpolation
csvName = 'InterpolatedResults.xlsx';

%%%%%%%%%%%%%%%%%%%%%%%%% EDITABLE %%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% NON-EDITABLE %%%%%%%%%%%%%%%%%%%%%%%

TwinAnalyticsToolKit.groupPerCutAllEquElasticStrain(folderOfInterest, num_nearest_nodes)
TwinAnalyticsToolKit.elasticStrainPlotter(csvName)

%%%%%%%%%%%%%%%%%%%%%%% NON-EDITABLE %%%%%%%%%%%%%%%%%%%%%%%
toc
