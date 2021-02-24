% This file is the 'main' file to prepare data for the Simulink file to run  

%   Author: Dhruv Jagga
%   Project: Source Code - Cloud Your Bus
%   email: d.jagga@tue.nl
%   Date: 10-12-2019;
%   Revised: 06-08-2020

% Clear Workspace
clc;
clear;
close all;

% Create path in the current directory
directory.current = pwd;                    % returns path of current directory
addpath(genpath('./Offline Estimate'));     % add the folder and subfolders to the working path (workspace)
addpath(genpath('./Parameter'));            % add the folder and subfolders to the working path (workspace)
addpath(genpath('./Post Processing'));      % add the folder and subfolders to the working path (workspace)

% Load test data profile
load('testDataRoute401_A_2Cycle.mat');
%load('validationDataRoute401_A_2Cycle.mat');

% Vehicle ID
vehicleID = sym(358679068436426);

% Establishing a new data (Just for Simulation - Has to be extracted from Bison API)
% Route Information
routeInfo  = 4011;

% Extracting data from the data structure

time        = m.data(:,1)-m.data(1,1);
dt          = [0;diff(time)];                            % used as weighted sample space

lat         = m.data(:,2);                               % degree
lon         = m.data(:,3);                               % degree
head        = m.data(:,4);                               % degree

v           = m.data(:,5);                               % kmph
v           = v * (5/18);                                % mps

vin         = m.data(:,6);

VoltBat     = m.data(:,7);                               % V
AmpBat      = m.data(:,8);                               % A

VoltDrive   = m.data(:,9);                               % V
AmpDrive    = m.data(:,10);                              % A

PressFA     = m.data(:,11);                              % KPa
PressRA     = m.data(:,12);                              % KPa
PressAA     = m.data(:,13);                              % KPa

% Pre-processing the extracted data
s           = cumsum(v.*dt);                             % m

PowerBat    = (VoltBat.*AmpBat);                         % W
EnergyBat   = cumsum(PowerBat.*dt)/(3.6e6);              % KWh

PowerDrive  = (VoltDrive.*AmpDrive);                     % W  
EnergyDrive = cumsum(PowerDrive.*dt)/3.6e6;              % KWh

PowerAux    = PowerBat - PowerDrive;                     % W
EnergyAux   = EnergyBat - EnergyDrive;                   % KWh

% Convert the loaded data as timeseries data
time       = timeseries(m.data(:,1)-m.data(1,1),m.data(:,1)-m.data(1,1));                    % [s]
Vx         = timeseries(v,m.data(:,1)-m.data(1,1));                                          % [m/s]
VoltBat    = timeseries(VoltBat,m.data(:,1)-m.data(1,1));                                    % [V]
AmpBat     = timeseries(AmpBat,m.data(:,1)-m.data(1,1));                                     % [A]
VoltDrive  = timeseries(VoltDrive,m.data(:,1)-m.data(1,1));                                  % [V]
AmpDrive   = timeseries(AmpDrive,m.data(:,1)-m.data(1,1));                                   % [A]
PressFA    = timeseries(PressFA,m.data(:,1)-m.data(1,1));                                    % [KPa]
PressRA    = timeseries(PressRA,m.data(:,1)-m.data(1,1));                                    % [KPa]
PressAA    = timeseries(PressAA,m.data(:,1)-m.data(1,1));                                    % [KPa]

s          = timeseries(s,m.data(:,1)-m.data(1,1));                                          % [KPa]
PowerBat   = timeseries(PowerBat,m.data(:,1)-m.data(1,1));                                   % [KPa]
EnergyBat  = timeseries(EnergyBat,m.data(:,1)-m.data(1,1));                                  % [KPa]
PowerDrive = timeseries(PowerDrive,m.data(:,1)-m.data(1,1));                                 % [KPa]
EnergyDrive= timeseries(EnergyDrive,m.data(:,1)-m.data(1,1));                                % [KPa]
PowerAux   = timeseries(PowerAux,m.data(:,1)-m.data(1,1));                                   % [KPa]
EnergyAux  = timeseries(EnergyAux,m.data(:,1)-m.data(1,1));                                  % [KPa]


% Preprocessing the GPS data (Replace the NaN value with the last recorded value)
for k = find(isnan(lat))
    lat(k) = lat(k-1);
end

for l = find(isnan(lon))
    lon(l) = lon(l-1);
end

for n = find(isnan(head))
    head(n) = head(n-1);
end

GPSlat  = timeseries(lat,m.data(:,1)-m.data(1,1));                                    % [deg.]
GPSlon = timeseries(lon,m.data(:,1)-m.data(1,1));                                     % [deg.]
GPShead = timeseries(head,m.data(:,1)-m.data(1,1));                                   % [deg.]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load relevent trip data
% Load Erate and other necessary data profiles for energy estimation and correction 
trip = routeData(routeInfo);
trip = trip.trip;

% Load start and stop coordinates for the relevent trip
[start,stop] = routeParameter(routeInfo);

% Perform the simulation
 out=sim('EnergyEstimationCorrection.slx');

% Post processing of data and updating database
% Step 1 - Extract Data segments of the different cycles of the route
[ErateExt,timeExt,sExt,PauxExt,energyTripExt,checkflag] = extractData(out);

% Step 2 - Make individual data structures for these subsequent trips
[tripPost] = dataStruct(ErateExt,timeExt,sExt,PauxExt,energyTripExt,out);

% Save the trip data structure into the Output Data Profile Folder in directory
savdir = 'C:\Users\20184719\Documents\Final Project - Module 5\Source Code\MATLAB\Cloud Your Bus - Energy Estimation System for EV\Post Processing\DataProfile-Route_401';

% Save trip data - Route 401 - Cycle 1
if tripPost.trip1.tripDataHealth == true
    trip = tripPost.trip1;
    save(fullfile(savdir,'ErateProfile401_A_01'),'trip');
end

% Save trip data - Route 401 - Cycle 2
if tripPost.trip2.tripDataHealth == true
    trip = tripPost.trip2;
    save(fullfile(savdir,'ErateProfile401_A_02'),'trip');
end

% Step 3 - Do averaging of these data structures to make a unique data structure
tripUpdate = avgDataStruct(out,tripPost);

savdirUp = 'C:\Users\20184719\Documents\Final Project - Module 5\Source Code\MATLAB\Cloud Your Bus - Energy Estimation System for EV\Parameter\UpdatedProfile';

if tripUpdate.tripDataHealth == true
    trip = tripUpdate;
    save(fullfile(savdirUp,'UpdatedErateProfile401_A'),'trip');
end

% Checking for Absolute error of respective cycles of the trips made (For Analysis purpose only)
absError = absoluteError(out);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Concatanate data for the testing of 2 cycles over same route (Preparing Test Data)

% Line 401_A (Direction - Station to Airport)-Test Data    
% d1 = load('cycle01.mat'); 
% d2 = load('cycle02.mat');   
% 
% m.data = vertcat(d1.data,d2.data);
% 
% save testDataRoute401_A_2Cycle m;

% Line 401_A (Direction - Station to Airport)-Validation Data
% d1 = load('cycle17.mat'); 
% d2 = load('cycle18.mat');   
% 
% m.data = vertcat(d1.data,d2.data);
% 
% save validationDataRoute401_A_2Cycle m;


