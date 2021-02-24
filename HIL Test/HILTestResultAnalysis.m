%   Author: Dhruv Jagga
%   Project: Source Code - Cloud Your Bus
%   email: d.jagga@tue.nl
%   Date: 10-12-2019;
%   Revised: 06-08-2020

clear; close all; clc;

directory.current = pwd;                    % returns path of current directory

m = csvread('HIL_Test2_Out.csv',1,0);

energyDriveTrip         = m(:,1);
energyDriveTripCurrent  = m(:,2);
energyDriveActual       = m(:,3);
massEstimate            = m(:,4);
Erate                   = m(:,5);

energyAuxTrip           = m(:,6);
energyAuxTripCurrent    = m(:,7);
energyAuxActual         = m(:,8);
corrGain                = m(:,9);

energyTrip              = m(:,10);
energyTripCurrent       = m(:,11);
energyActual            = m(:,12);
error                   = m(:,13);

reliability             = m(:,14);
deviation               = m(:,15);
eState                  = m(:,16);

% Trip Profile generated after 2 cycles (Update Reference Data Profile)
trip_HIL = csvread('HIL_Test_Data_Profile02.csv',1,0);

Erate_ref = trip_HIL(:,1);
Paux_ref  = trip_HIL(:,2);
s_ref     = trip_HIL(:,3);

% Load data from SIL
load('UpdatedErateProfile401_A.mat');



% Plot - Drivetrain Online Estimation (Route 401) - Individual Cycles
figure()
plot(energyDriveTrip,':','Color','k','DisplayName','Estimation (Trip End)','LineWidth',3.0);
hold on
plot(energyDriveTripCurrent,':','Color','b','DisplayName','Estimation (Current)','LineWidth',3.0);
plot(energyDriveActual,'-','Color','r','DisplayName','Measured','LineWidth',1.5);
hold off
% Figure Properties
ylabel('Energy [KWh]','FontSize',12,'FontWeight','bold','Color','k');
xlabel('No. of Samples','FontSize',12,'FontWeight','bold','Color','k');
title('Drivetrain Online Energy Estimation - Route 401 (HIL Test)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 9;
lgd.Location = 'southeast';
grid on;

% Plot - Mass Estimation (Drivetrain)
figure()
plot(massEstimate,':','Color','r','DisplayName','Estimation','LineWidth',3.0);
% Figure Properties
ylabel('Amplitude [Kg]','FontSize',12,'FontWeight','bold','Color','k');
xlabel('No. of Samples','FontSize',12,'FontWeight','bold','Color','k');
title('Mass Estimation - Route 401 (HIL Test)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 9;
lgd.Location = 'northeast';
grid on;

% Plot - Auxiliary Online Estimation (Route 401) - Individual Cycles
figure()
plot(energyAuxTrip,':','Color','k','DisplayName','Estimation (Trip End)','LineWidth',3.0);
hold on
plot(energyAuxTripCurrent,':','Color','b','DisplayName','Estimation (Current)','LineWidth',3.0);
plot(energyAuxActual,'-','Color','r','DisplayName','Measured','LineWidth',1.5);
hold off
% Figure Properties
ylabel('Energy [KWh]','FontSize',12,'FontWeight','bold','Color','k');
xlabel('No. of Samples','FontSize',12,'FontWeight','bold','Color','k');
title('Auxiliary Online Energy Estimation - Route 401 (HIL Test)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 9;
lgd.Location = 'northeast';
grid on;

% Plot - Gain Estimation (Auxiliary)
figure()
plot(corrGain,':','Color','r','DisplayName','Estimation','LineWidth',3.0);
% Figure Properties
ylabel('Estimate','FontSize',12,'FontWeight','bold','Color','k');
xlabel('No. of Samples','FontSize',12,'FontWeight','bold','Color','k');
title('Gain Estimation - Route 401 (HIL Test)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 9;
lgd.Location = 'northeast';
grid on;

% Plot - Total Online Estimation (Route 401) - Individual Cycles
figure()
plot(energyTrip,':','Color','k','DisplayName','Estimation (Trip End)','LineWidth',3.0);
hold on
plot(energyTripCurrent,':','Color','b','DisplayName','Estimation (Current)','LineWidth',3.0);
plot(energyActual,'-','Color','r','DisplayName','Measured','LineWidth',1.5);
hold off
% Figure Properties
ylabel('Energy [KWh]','FontSize',12,'FontWeight','bold','Color','k');
xlabel('No. of Samples','FontSize',12,'FontWeight','bold','Color','k');
title('Total Online Energy Estimation - Route 401 (HIL Test)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 9;
lgd.Location = 'southeast';
grid on;

% Plot - Active Status
figure()
plot(eState,'-','Color','k','DisplayName','Active Status','LineWidth',1.5);
% Figure Properties
ylabel('Status','FontSize',12,'FontWeight','bold','Color','k');
ylim([0 2]);
xlabel('No. of Samples','FontSize',12,'FontWeight','bold','Color','k');
title('Active Status - Route 401 (HIL Test)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 9;
lgd.Location = 'northeast';
grid on;

% Plot - Error in Estimation
figure()
plot(error,'-','Color','k','DisplayName','Error','LineWidth',1.5);
% Figure Properties
ylabel('Error [%]','FontSize',12,'FontWeight','bold','Color','k');
xlabel('No. of Samples','FontSize',12,'FontWeight','bold','Color','k');
title('Error in Estimation - Route 401 (HIL Test)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 9;
lgd.Location = 'northeast';
grid on;

% Plot - Deviation from Offline Estimation
figure()
plot(deviation,'-','Color','k','DisplayName','Deviation','LineWidth',1.5);
% Figure Properties
ylabel('Deviation [%]','FontSize',12,'FontWeight','bold','Color','k');
xlabel('No. of Samples','FontSize',12,'FontWeight','bold','Color','k');
title('Deviation from Offline Estimation - Route 401 (HIL Test)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 9;
lgd.Location = 'northeast';
grid on;

% Plot - Erate Calculation
figure()
plot(Erate,'-','Color','k','DisplayName','RCI','LineWidth',1.5);
% Figure Properties
ylabel('RCI [KWh/(Kg.Km)]','FontSize',12,'FontWeight','bold','Color','k');
xlabel('No. of Samples','FontSize',12,'FontWeight','bold','Color','k');
title('Calculated RCI - Route 401 (HIL Test)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 9;
lgd.Location = 'northeast';
grid on;

% Plot - Reliability
figure()
plot(reliability,'-','Color','r','DisplayName','Reliability','LineWidth',1.5);
% Figure Properties
ylabel('Amplitude [%]','FontSize',12,'FontWeight','bold','Color','k');
ylim([0 120]);
xlabel('No. of Samples','FontSize',12,'FontWeight','bold','Color','k');
title('Estimation Reliability - Route 401 (HIL Test)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 9;
lgd.Location = 'northeast';
grid on;


% Plot - Erate Updated Reference profile
figure()
plot(Erate_ref,'-','Color','k','DisplayName','RCI','LineWidth',3.0);
% Figure Properties
ylabel('RCI [m/s^2]','FontSize',12,'FontWeight','bold','Color','k');
xlabel('No. of Samples','FontSize',12,'FontWeight','bold','Color','k');
title('RCI - Updated Reference Profile','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 9;
lgd.Location = 'southeast';
grid on;


% Plot - Paux Updated Reference profile
figure()
plot(Paux_ref,'-','Color','k','DisplayName','Power','LineWidth',3.0);
% Figure Properties
ylabel('Power [W]','FontSize',12,'FontWeight','bold','Color','k');
xlabel('No. of Samples','FontSize',12,'FontWeight','bold','Color','k');
title('Auxiliary Power - Updated Reference Profile','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 9;
lgd.Location = 'southeast';
grid on;