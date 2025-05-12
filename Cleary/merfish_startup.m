%% Startup Script
% -------------------------------------------------------------------------
% This script initializes the matlab workspace and defines useful paths and
% global variables for STORM analysis and MERFISH analysis
% If you already have a startup script add the following code to this
% script. To be functional, there are specific paths that must be set based
% on the local machine.  
% -------------------------------------------------------------------------
%% Clear Existing Workspace
close all;
clear all;
clc;
display('------------------------------------------------------------------');
warning off all
restoredefaultpath; % Clear previous paths
warning on all
addpath('/share/pkg.8/matlab/2024b/');   % MATLAB directory
%addpath('startup'); % Location of any startup script

%% Define matlab-storm Variables and Paths:
global insightExe; % System executable command for InsightM
global scratchPath; % place for matlab-storm to save temporary files
global pythonPath; % path to Python 2.7
global matlabStormPath; % path to matlab-storm downloaded from https://github.com/ZhuangLab/matlab-storm
global stormAnalysisPath; % path to storm-analysis downloaded from https://github.com/ZhuangLab/storm-analysis

scratchPath = 'scratch/';
pythonPath = '/share/pkg.7/python2/2.7.15'; 
matlabStormPath = 'matlab-storm/';  
stormAnalysisPath= 'storm-analysis/';  
%insightExe = 'C:\Utilities\STORMAnalysis\Insight3\InsightM.exe';

% Call the matlab-storm startup script
addpath([matlabStormPath,'Startup/']);
matlabstorm_startup;    % Configure matlab-storm
	
%% Add merfish_analysis: downloaded from https://github.com/ZhuangLab/MERFISH_analysis

display('Adding MERFISH_analysis');
MERFISHAnalysisPath = ['./']; % Path the folder in which you installed this software package
addpath(genpath(MERFISHAnalysisPath), '-begin');
display(['    ' MERFISHAnalysisPath]);
display(['      And all enclosed paths']);

%% Add export_fig
%addpath(['C:\Users\Jeff.Morgan0\Dropbox\ZhuangLab\Coding\Matlab\matlab-functions\FromGitHub\export_fig\']); % Path to export_fig
