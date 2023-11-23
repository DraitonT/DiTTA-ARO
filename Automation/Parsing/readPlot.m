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
csvName = 'InterpolatedResults.xlsx';

data = readmatrix(csvName); % Read the CSV file into a matrix (assuming it has a header row).

% Extract the columns you need from the data matrix
Strain1 = data(:, 1);
Strain2 = data(:, 2);
Strain3 = data(:, 3);
Strain4 = data(:, 4);
Strain5 = data(:, 5);
Strain6 = data(:, 6);
Strain7 = data(:, 7);
CutLocation = data(:, 8);



figure;
hold on;
plot(CutLocation, Strain1, 'b', 'DisplayName', 'Strain 1');
plot(CutLocation, Strain2, 'g', 'DisplayName', 'Strain 2');
plot(CutLocation, Strain3, 'r', 'DisplayName', 'Strain 3');
plot(CutLocation, Strain4, 'c', 'DisplayName', 'Strain 4');
plot(CutLocation, Strain5, 'm', 'DisplayName', 'Strain 5');
plot(CutLocation, Strain6, 'y', 'DisplayName', 'Strain 6');
plot(CutLocation, Strain7, 'k', 'DisplayName', 'Strain 7');

xlabel('CutLocation');
ylabel('Strain (in/in)');
title('Strain vs. CutLocation');
legend('Location', 'Best');
grid on;
hold off;
%%%%%%%%%%%%%%%%%%%%%%%%% EDITABLE %%%%%%%%%%%%%%%%%%%%%%%%%

toc