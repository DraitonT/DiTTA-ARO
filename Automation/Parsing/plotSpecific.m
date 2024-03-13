clc, clear, close all
addpath(genpath(append(pwd,'\..\..\lib'))) %Adds TwinAnalyticsToolKit.m library to the working path
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
% Read the CSV file
% cutLocation = '200'
% fileName = '200compiled.csv'; % Update the filename if necessary
cutLocation = '200'
fileName = '200compiled.csv'; % Update the filename if necessary
filePath = append(pwd,'\..\..\data\runs\', cutLocation, '\', fileName);
data = readtable(filePath, VariableNamingRule="preserve");

% Extract the necessary columns
x_location = data.('X Locations (inches)');
equiv_elastic_strain = data.('Equivalent Elastic Strains (in/in)');

% Plotting
figure;
scatter(x_location, equiv_elastic_strain, 'b.');
xlabel('X Locations (inches)', 'Interpreter', 'latex');
ylabel('Equivalent Elastic Strains (in/in)', 'Interpreter', 'latex');
title('Scatter Plot of Equivalent Elastic Strain vs X Location', 'Interpreter', 'latex');
grid on;
