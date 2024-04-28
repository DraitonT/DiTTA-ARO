clc, clear, close all
addpath(genpath(append(pwd,'\..\..\..\lib'))) %Adds TwinAnalyticsToolKit.m library to the working path
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
interestedData = [{'Equivalent Elastic Strains (in/in)'}, {'Total Deformation (in)'}];
csvInfo.name = [{'Strain'}, {'Deformation'}];
csvInfo.unit = [{' (in/in)'}, {' (in)'}];

folderOfInterest = '\..\..\..\data\runsMarch\'; 
num_nearest_nodes = 4; % Set the number of nearest nodes to use for interpolation
csvName = '\..\..\..\data\runsMarch\InterpolationResults_Strain.csv';
csvName = '\..\..\..\data\runsMarch\InterpolationResults_Deformation .csv';

%%%%%%%%%%%%%%%%%%%%%%%%% EDITABLE %%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% NON-EDITABLE %%%%%%%%%%%%%%%%%%%%%%%

for i = 1:length(interestedData)
    TwinAnalyticsToolKit.groupPerCutAllValue(folderOfInterest, num_nearest_nodes, interestedData{1,i}, csvInfo, i)
end

% TwinAnalyticsToolKit.groupPerCutAllEquElasticStrain(folderOfInterest, num_nearest_nodes)
% TwinAnalyticsToolKit.elasticStrainPlotter(append(pwd,csvName))

%%%%%%%%%%%%%%%%%%%%%%% NON-EDITABLE %%%%%%%%%%%%%%%%%%%%%%%
toc
