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
directory.current = pwd;                % returns path of current directory
addpath('./Output Data Profile');       % add the folder to the working path (workspace)
addpath('./Functions');                 % add the folder to the working path (workspace)
addpath(genpath('./Data'));             % add the folder and subfolders to the working path (workspace)
addpath(genpath('./Plot Functions'));   % add the folder and subfolders to the working path (workspace)

% Line 401_A (Direction - Station to Airport) - Load different cycle data to create subsequent data structures    
 m = load('cycle01.mat');   

% Extracting data from the data structure

time        = m.data(:,1)-m.data(1,1);

lat         = m.data(:,2);                               % degree
lon         = m.data(:,3);                               % degree
head        = m.data(:,4);                               % degree

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define starting point and ending point of the route using GPS coordinates
% [The below entered route coordinates is for line 401 moving in between Eindhoven Station and Airport]
% Direction - Station to Airport

start.lat = 51.4442;                                    % Physically/manually entered GPS latitude
start.lon = 5.4788;                                     % Physically/manually entered GPS longitude
start.head = 278;                                       % Physically/manually entered GPS heading

% Allowing variation/deviation with following range [in degrees] around GPS coordinate
start.latRange = 0.0004;                                % Physically/manually entered
start.lonRange = 0.0004;                                % Physically/manually entered
start.headRange= 50;                                    % Physically/manually entered

stop.lat = 51.4567;                                     % Physically/manually entered GPS latitude
stop.lon = 5.3933;                                      % Physically/manually entered GPS longitude
stop.head = 309;                                        % Physically/manually entered GPS heading

% Allowing variation/deviation with following range [in degrees] around GPS coordinate
stop.latRange = 0.0004;                                 % Physically/manually entered
stop.lonRange = 0.0004;                                 % Physically/manually entered
stop.headRange= 50;                                     % Physically/manually entered

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Direction - Airport to Station

% start.lat = 51.4501;                                    % Physically/manually entered GPS latitude
% start.lon = 5.4027;                                     % Physically/manually entered GPS longitude
% start.head = 154;                                       % Physically/manually entered GPS heading
% 
% % Allowing variation/deviation with following range [in degrees] around GPS coordinate
% start.latRange = 0.0003;                                % Physically/manually entered
% start.lonRange = 0.0003;                                % Physically/manually entered
% start.headRange= 5;                                     % Physically/manually entered
% 
% stop.lat = 51.4442;                                     % Physically/manually entered GPS latitude
% stop.lon = 5.4788;                                      % Physically/manually entered GPS longitude
% stop.head = 72;                                         % Physically/manually entered GPS heading
% 
% % Allowing variation/deviation with following range [in degrees] around GPS coordinate
% stop.latRange = 0.0004;                                 % Physically/manually entered
% stop.lonRange = 0.0004;                                 % Physically/manually entered
% stop.headRange= 5;                                      % Physically/manually entered

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Index start and stop from given data and given GPS coordinates
[idx_Start,idx_Stop] = idxStartStop(time,lat,lon,head,start,stop);

time        = m.data(idx_Start:idx_Stop,1)-m.data(idx_Start,1);
dt          = [0;diff(time)];                            % used as weighted sample space

v           = m.data(idx_Start:idx_Stop,5);              % kmph
v           = v * (5/18);                                % mps

s           = cumsum(v.*dt);                             % m

trip.sRoute = [1:1:max(s)]';                             % distance vector with sample of '1m' for particular route
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
EnergyDriveInterp = interp1(time,EnergyDrive,trip.sRoute); % KWh

PowerAux    = PowerBat - PowerDrive;                     % W
EnergyAux   = EnergyBat - EnergyDrive;                   % KWh

% E_{Rate} Energy Consumed per unit distance per unit mass
trip.mveh   = 19000;                                     % Kg
ForceDrive  = zeros(length(time),1);                     % creating an empty vector for force data
ERate       = zeros(length(time),1);                     % creating an empty vector for Erate data

% Calculating Force and Erate respectively
for i = 1:length(time)
    if v(i) == 0
        ForceDrive(i) = 0;
        ERate(i) = ForceDrive(i)./trip.mveh;
    else
        ForceDrive(i) = PowerDrive(i)./v(i);
        ERate(i) = ForceDrive(i)./trip.mveh;
    end
end

ERate = ERate';

trip.s         = max(s);

[sIntp,index]  = unique(s);
trip.time      = interp1(sIntp,time(index),trip.sRoute);                % interpolating the time vector at every 1 m distance    

Erate_raw      = interp1(sIntp,ERate(index),trip.sRoute);               % interpolating the Erate vector at every 1 m distance
[b,a]          = butter(2,0.2);
trip.Erate     = filtfilt(b,a,Erate_raw);                               % filtering the Erate using the butterworth filter

% Auxiliary Power for Route
% trip.Paux      = mean(PowerAux);                                      % using mean of auxiliary power consumed over time
trip.Paux      = PowerAux;                                              % using profile of auxiliary power consumed over time.

% trip.Euse_estimate  = cumsum(trip.Erate.*ds)*trip.mveh/3.6e6 + trip.Paux*trip.time/3.6e6;
trip.EuseDrive = cumsum(trip.Erate.*ds)*trip.mveh/3.6e6;

% Creating Auxiliary trip profile
trip.EuseAux   = cumsum(PowerAux.*dt)/3.6e6;
trip.timeAux   = time;

% for checking purposes (not available in real life)
trip.Etrip_measured = EnergyBat(length(EnergyBat));

%save ErateProfile trip

% Save the trip data structure into the Output Data Profile Folder in directory
savdir = 'C:\Users\20184719\Documents\Final Project - Module 5\Source Code\CYB - Energy Estimation\Route401\Line_401_Vehicle358679068436426\Output Data Profile';
save(fullfile(savdir,'ErateProfile401_A_01'),'trip');

%%

% Plot GPS heading with latitude and longitude
figure()
plot_dir(lat(1:150:end),lon(1:150:end));
xlabel('Latitide [degree]');
ylabel('Longitude [degree]');
title('GPS Route');

figure()
plot(trip.sRoute,Erate_raw,trip.sRoute,trip.Erate)
grid
xlabel('travelled distance [m]')
ylabel('E-rate [m/s^2]')

figure()
plot(trip.sRoute,trip.EuseDrive,s,EnergyDrive)
grid
xlabel('travelled distance [m]')
ylabel('Energy usage - Drivetrain [kWh]')
legend('estimate','actual','Location','NorthWest')

figure()
hold on
plot(EnergyBat,'r');
plot(EnergyDrive,'b');
plot(EnergyAux,'g');
hold off
xlabel('Time [sec]');
ylabel('Energy [KWh]');
legend('Total Battery Energy', 'Drivetrain Energy', 'Auxillary Energy');
title('Energy Consumption over Route');

figure()
plot(lat,lon);
xlabel('Latitide [degree]');
ylabel('Longitude [degree]');
title('GPS Route');




























