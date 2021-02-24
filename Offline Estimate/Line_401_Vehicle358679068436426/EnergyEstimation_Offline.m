% This file is the 'main' file and will execute all parameters, functions, data and 
% scripts in the model and executed results are published in plots   

%   Author: Dhruv Jagga
%   Project: Source Code - Cloud Your Bus
%   email: d.jagga@tue.nl
%   Date: 10-12-2019;
%   Revised: 22-05-2020

% Clear Workspace
clc;
clear;
close all;

% Create path in the current directory
directory.current = pwd;                                % returns path of current directory
addpath('./Output Data Profile');                       % add the folder to the working path (workspace)
addpath('./Functions');                                 % add the folder to the working path (workspace)
addpath(genpath('./Data'));                             % add the folder and subfolders to the working path (workspace)
addpath(genpath('./Plot Functions'));                   % add the folder and subfolders to the working path (workspace)
addpath(genpath('./Averaged Data Profile'));            % add the folder and subfolders to the working path (workspace)
addpath(genpath('./Results - Offline Estimation'));     % add the folder and subfolders to the working path (workspace)


% Line 401_A (Direction - Station to Airport) - Load different cycle data to create subsequent data structures    
m = load('cycle21.mat');
 
% Load averaged Erate Profile
load('ErateAvgRoute401_A.mat');

% Extracting data from the data structure

time        = m.data(:,1)-m.data(1,1);

lat         = m.data(:,2);                               % degree
lon         = m.data(:,3);                               % degree
head        = m.data(:,4);                               % degree

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define starting point and ending point of the route using GPS coordinates
% [The below entered route coordinates is for line 401 moving in between Eindhoven Station and Airport]
% Direction - Station to Airport

start.lat = 51.4442;                                     % Physically/manually entered GPS latitude
start.lon = 5.4788;                                      % Physically/manually entered GPS longitude
start.head = 278;                                        % Physically/manually entered GPS heading

% Allowing variation/deviation with following range [in degrees] around GPS coordinate
start.latRange = 0.0004;                                 % Physically/manually entered
start.lonRange = 0.0004;                                 % Physically/manually entered
start.headRange= 50;                                     % Physically/manually entered

stop.lat = 51.4567;                                      % Physically/manually entered GPS latitude
stop.lon = 5.3933;                                       % Physically/manually entered GPS longitude
stop.head = 309;                                         % Physically/manually entered GPS heading

% Allowing variation/deviation with following range [in degrees] around GPS coordinate
stop.latRange = 0.0004;                                  % Physically/manually entered
stop.lonRange = 0.0004;                                  % Physically/manually entered
stop.headRange= 50;                                      % Physically/manually entered

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Index start and stop from given data and given GPS coordinates
[idx_Start,idx_Stop] = idxStartStop(time,lat,lon,head,start,stop);

time        = m.data(idx_Start:idx_Stop,1)-m.data(idx_Start,1);
dt          = [0;diff(time)];                            % used as weighted sample space

v           = m.data(idx_Start:idx_Stop,5);              % kmph
v           = v * (5/18);                                % mps

s           = cumsum(v.*dt);                             % m

ds          = [0;diff(trip.sRoute)];                     % used as weighted sample space

vin         = m.data(idx_Start:idx_Stop,6);

VoltBat     = m.data(idx_Start:idx_Stop,7);              % V
AmpBat      = m.data(idx_Start:idx_Stop,8);              % A

VoltDrive   = m.data(idx_Start:idx_Stop,9);              % V
AmpDrive    = m.data(idx_Start:idx_Stop,10);             % A

PressFA     = m.data(idx_Start:idx_Stop,11);             % KPa
PressRA     = m.data(idx_Start:idx_Stop,12);             % KPa
PressAA     = m.data(idx_Start:idx_Stop,13);             % KPa

PowerBat    = (VoltBat.*AmpBat);                         % W
EnergyBat   = cumsum(PowerBat.*dt)/(3.6e6);              % KWh

PowerDrive  = (VoltDrive.*AmpDrive);                     % W  
EnergyDrive = cumsum(PowerDrive.*dt)/3.6e6;              % KWh
EnergyDriveInterp = interp1(time,EnergyDrive,trip.time); % KWh

PowerAux    = PowerBat - PowerDrive;                     % W
EnergyAux   = EnergyBat - EnergyDrive;                   % KWh
EnergyAuxInterp = interp1(time,EnergyAux,trip.time);     % KWh

EnergyTotalInterp = EnergyDriveInterp + EnergyAuxInterp;

for k = find(isnan(EnergyTotalInterp))
    EnergyTotalInterp(k) = 0;
end

% Estimated Energy from Averaged Erate Profile and Power Reference Profile

dt        = [0;diff(trip.time)];                         % used as weighted sample space
EuseDrive = cumsum(trip.Erate.*ds)*trip.mveh/3.6e6;
EuseAux   = cumsum(trip.Paux.*dt)/3.6e6;
EuseTotal = EuseDrive + EuseAux;

% Absolute Error
errorAbs100 = abs(sum(EuseTotal) - sum(EnergyTotalInterp))./sum(EnergyTotalInterp) * 100;

out.EnergyDriveActual   = EnergyDriveInterp;
out.EnergyAuxActual     = EnergyAuxInterp;
out.EnergyTotalActual   = EnergyTotalInterp;

out.EnergyDriveEstimate = EuseDrive;
out.EnergyAuxEstimate   = EuseAux;
out.EnergyTotalEstimate = EuseTotal;

out.absError            = errorAbs100;

savdir = 'C:\Users\20184719\Documents\Final Project - Module 5\Source Code\MATLAB\Cloud Your Bus - Energy Estimation System for EV\Offline Estimate\Line_401_Vehicle358679068436426\Results - Offline Estimation';
save(fullfile(savdir,'out_offCycle21'),'out');
