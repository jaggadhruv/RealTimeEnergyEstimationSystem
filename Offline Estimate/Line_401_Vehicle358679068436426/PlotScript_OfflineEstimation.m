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
addpath(genpath('./Results - Offline Estimation'));     % add the folder and subfolders to the working path (workspace)
addpath(genpath('./Averaged Data Profile'));            % add the folder and subfolders to the working path (workspace)
addpath(genpath('./Output Data Profile'));              % add the folder and subfolders to the working path (workspace)

% Load Individual Erate Profile
e1  = load('ErateProfile401_A_01.mat');
e2  = load('ErateProfile401_A_02.mat');
e3  = load('ErateProfile401_A_03.mat');
e4  = load('ErateProfile401_A_04.mat');
e5  = load('ErateProfile401_A_05.mat');
e6  = load('ErateProfile401_A_06.mat');
e7  = load('ErateProfile401_A_07.mat');
e8  = load('ErateProfile401_A_08.mat');
e9  = load('ErateProfile401_A_09.mat');
e10 = load('ErateProfile401_A_10.mat');
e11 = load('ErateProfile401_A_11.mat');
e12 = load('ErateProfile401_A_12.mat');
e13 = load('ErateProfile401_A_13.mat');
e14 = load('ErateProfile401_A_14.mat');
e15 = load('ErateProfile401_A_15.mat');
e16 = load('ErateProfile401_A_16.mat');

% Load Averaged Erate Profile
load('ErateAvgRoute401_A.mat');

% Load Output workspace data over different cycles
m1  = load('out_offCycle01.mat');
m2  = load('out_offCycle02.mat');
m3  = load('out_offCycle03.mat');
m4  = load('out_offCycle04.mat');
m5  = load('out_offCycle05.mat');
m6  = load('out_offCycle06.mat');
m7  = load('out_offCycle07.mat');
m8  = load('out_offCycle08.mat');
m9  = load('out_offCycle09.mat');
m10 = load('out_offCycle10.mat');
m11 = load('out_offCycle11.mat');
m12 = load('out_offCycle12.mat');
m13 = load('out_offCycle13.mat');
m14 = load('out_offCycle14.mat');
m15 = load('out_offCycle15.mat');
m16 = load('out_offCycle16.mat');
m17 = load('out_offCycle17.mat');
m18 = load('out_offCycle18.mat');
m19 = load('out_offCycle19.mat');
m20 = load('out_offCycle20.mat');
m21 = load('out_offCycle21.mat');

% Preapring Auxiliary energy interpolated profile in the trip data
E1 = interp1(e1.trip.timeAux,e1.trip.EuseAux,e1.trip.time) + e1.trip.EuseDrive;
E2 = interp1(e2.trip.timeAux,e2.trip.EuseAux,e2.trip.time) + e2.trip.EuseDrive;
E3 = interp1(e3.trip.timeAux,e3.trip.EuseAux,e3.trip.time) + e3.trip.EuseDrive;
E4 = interp1(e4.trip.timeAux,e4.trip.EuseAux,e4.trip.time) + e4.trip.EuseDrive;
E5 = interp1(e5.trip.timeAux,e5.trip.EuseAux,e5.trip.time) + e5.trip.EuseDrive;
E6 = interp1(e6.trip.timeAux,e6.trip.EuseAux,e6.trip.time) + e6.trip.EuseDrive;
E7 = interp1(e7.trip.timeAux,e7.trip.EuseAux,e7.trip.time) + e7.trip.EuseDrive;
E8 = interp1(e8.trip.timeAux,e8.trip.EuseAux,e8.trip.time) + e8.trip.EuseDrive;
E9 = interp1(e9.trip.timeAux,e9.trip.EuseAux,e9.trip.time) + e9.trip.EuseDrive;
E10 = interp1(e10.trip.timeAux,e10.trip.EuseAux,e10.trip.time) + e10.trip.EuseDrive;
E11 = interp1(e11.trip.timeAux,e11.trip.EuseAux,e11.trip.time) + e11.trip.EuseDrive;
E12 = interp1(e12.trip.timeAux,e12.trip.EuseAux,e12.trip.time) + e12.trip.EuseDrive;
E13 = interp1(e13.trip.timeAux,e13.trip.EuseAux,e13.trip.time) + e13.trip.EuseDrive;
E14 = interp1(e14.trip.timeAux,e14.trip.EuseAux,e14.trip.time) + e14.trip.EuseDrive;
E15 = interp1(e15.trip.timeAux,e15.trip.EuseAux,e15.trip.time) + e15.trip.EuseDrive;
E16 = interp1(e16.trip.timeAux,e16.trip.EuseAux,e16.trip.time) + e16.trip.EuseDrive;

% Plot - Energy Total (21 Cycle)
figure()
plot(E1,'--','DisplayName','Cycle01','LineWidth',1.5);
hold on
plot(E2,'--','DisplayName','Cycle02','LineWidth',1.5);
plot(E3,'--','DisplayName','Cycle03','LineWidth',1.5);
plot(E4,'--','DisplayName','Cycle04','LineWidth',1.5);
plot(E5,'--','DisplayName','Cycle05','LineWidth',1.5);
plot(E6,'--','DisplayName','Cycle06','LineWidth',1.5);
plot(E7,'--','DisplayName','Cycle07','LineWidth',1.5);
plot(E8,'--','DisplayName','Cycle08','LineWidth',1.5);
plot(E9,'--','DisplayName','Cycle09','LineWidth',1.5);
plot(E10,'--','DisplayName','Cycle10','LineWidth',1.5);
plot(E11,'--','DisplayName','Cycle11','LineWidth',1.5);
plot(E12,'--','DisplayName','Cycle12','LineWidth',1.5);
plot(E13,'--','DisplayName','Cycle13','LineWidth',1.5);
plot(E14,'--','DisplayName','Cycle14','LineWidth',1.5);
plot(E15,'--','DisplayName','Cycle15','LineWidth',1.5);
plot(E16,'--','DisplayName','Cycle16','LineWidth',1.5);
hold off
% Figure Properties
ylabel('Energy [KWh]','FontSize',12,'FontWeight','bold','Color','k');
ylim([0 10]);
xlabel('No. of Samples','FontSize',12,'FontWeight','bold','Color','k');
title('Energy - Route 401 (21 Cycle)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 6;
lgd.Location = 'northwest';
grid on;

% Plot - Energy Drivetrain Actual (21 Cycle) and Averaged Drivetrain Estimation
figure()
plot(m1.out.EnergyDriveActual,'--','DisplayName','Cycle01','LineWidth',1.5);
hold on
plot(m2.out.EnergyDriveActual,'--','DisplayName','Cycle02','LineWidth',1.5);
plot(m3.out.EnergyDriveActual,'--','DisplayName','Cycle03','LineWidth',1.5);
plot(m4.out.EnergyDriveActual,'--','DisplayName','Cycle04','LineWidth',1.5);
plot(m5.out.EnergyDriveActual,'--','DisplayName','Cycle05','LineWidth',1.5);
plot(m6.out.EnergyDriveActual,'--','DisplayName','Cycle06','LineWidth',1.5);
plot(m7.out.EnergyDriveActual,'--','DisplayName','Cycle07','LineWidth',1.5);
plot(m8.out.EnergyDriveActual,'--','DisplayName','Cycle08','LineWidth',1.5);
plot(m9.out.EnergyDriveActual,'--','DisplayName','Cycle09','LineWidth',1.5);
plot(m10.out.EnergyDriveActual,'--','DisplayName','Cycle10','LineWidth',1.5);
plot(m11.out.EnergyDriveActual,'--','DisplayName','Cycle11','LineWidth',1.5);
plot(m12.out.EnergyDriveActual,'--','DisplayName','Cycle12','LineWidth',1.5);
plot(m13.out.EnergyDriveActual,'--','DisplayName','Cycle13','LineWidth',1.5);
plot(m14.out.EnergyDriveActual,'--','DisplayName','Cycle14','LineWidth',1.5);
plot(m15.out.EnergyDriveActual,'--','DisplayName','Cycle15','LineWidth',1.5);
plot(m16.out.EnergyDriveActual,'--','DisplayName','Cycle16','LineWidth',1.5);
plot(m17.out.EnergyDriveActual,'--','DisplayName','Cycle17','LineWidth',1.5);
plot(m18.out.EnergyDriveActual,'--','DisplayName','Cycle18','LineWidth',1.5);
plot(m19.out.EnergyDriveActual,'--','DisplayName','Cycle19','LineWidth',1.5);
plot(m20.out.EnergyDriveActual,'--','DisplayName','Cycle20','LineWidth',1.5);
plot(m21.out.EnergyDriveActual,'--','DisplayName','Cycle21','LineWidth',1.5);
plot(trip.Euse_estimate_drive,'-','DisplayName','Averaged Profile','LineWidth',3.5);
hold off
% Figure Properties
ylabel('Energy [KWh]','FontSize',12,'FontWeight','bold','Color','k');
ylim([0 10]);
xlabel('No. of Samples','FontSize',12,'FontWeight','bold','Color','k');
title('Drivetrain Energy - Route 401 (21 Cycle)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 6;
lgd.Location = 'northwest';
grid on;

% Plot - Energy Estimation Auxiliary (21 Cycle) and Averaged Auxiliary Estimation
figure()
plot(m1.out.EnergyAuxActual,'--','DisplayName','Cycle01','LineWidth',1.5);
hold on
plot(m2.out.EnergyAuxActual,'--','DisplayName','Cycle02','LineWidth',1.5);
plot(m3.out.EnergyAuxActual,'--','DisplayName','Cycle03','LineWidth',1.5);
plot(m4.out.EnergyAuxActual,'--','DisplayName','Cycle04','LineWidth',1.5);
plot(m5.out.EnergyAuxActual,'--','DisplayName','Cycle05','LineWidth',1.5);
plot(m6.out.EnergyAuxActual,'--','DisplayName','Cycle06','LineWidth',1.5);
plot(m7.out.EnergyAuxActual,'--','DisplayName','Cycle07','LineWidth',1.5);
plot(m8.out.EnergyAuxActual,'--','DisplayName','Cycle08','LineWidth',1.5);
plot(m9.out.EnergyAuxActual,'--','DisplayName','Cycle09','LineWidth',1.5);
plot(m10.out.EnergyAuxActual,'--','DisplayName','Cycle10','LineWidth',1.5);
plot(m11.out.EnergyAuxActual,'--','DisplayName','Cycle11','LineWidth',1.5);
plot(m12.out.EnergyAuxActual,'--','DisplayName','Cycle12','LineWidth',1.5);
plot(m13.out.EnergyAuxActual,'--','DisplayName','Cycle13','LineWidth',1.5);
plot(m14.out.EnergyAuxActual,'--','DisplayName','Cycle14','LineWidth',1.5);
plot(m15.out.EnergyAuxActual,'--','DisplayName','Cycle15','LineWidth',1.5);
plot(m16.out.EnergyAuxActual,'--','DisplayName','Cycle16','LineWidth',1.5);
plot(m17.out.EnergyAuxActual,'--','DisplayName','Cycle17','LineWidth',1.5);
plot(m18.out.EnergyAuxActual,'--','DisplayName','Cycle18','LineWidth',1.5);
plot(m19.out.EnergyAuxActual,'--','DisplayName','Cycle19','LineWidth',1.5);
plot(m20.out.EnergyAuxActual,'--','DisplayName','Cycle20','LineWidth',1.5);
plot(m21.out.EnergyAuxActual,'--','DisplayName','Cycle21','LineWidth',1.5);
plot(trip.Euse_estimate_aux,'-','DisplayName','Averaged Profile','LineWidth',3.5);
hold off
% Figure Properties
ylabel('Energy [KWh]','FontSize',12,'FontWeight','bold','Color','k');
ylim([0 8]);
xlabel('No. of Samples','FontSize',12,'FontWeight','bold','Color','k');
title('Auxiliary Energy - Route 401 (21 Cycle)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 6;
lgd.Location = 'northwest';
grid on;

% Plot - Erate Profile of 16 cycles and averaged Erate profile
figure()
plot(e1.trip.Erate,'--','DisplayName','Cycle01','LineWidth',1);
hold on
plot(e2.trip.Erate,'--','DisplayName','Cycle02','LineWidth',1);
plot(e3.trip.Erate,'--','DisplayName','Cycle03','LineWidth',1);
plot(e4.trip.Erate,'--','DisplayName','Cycle04','LineWidth',1);
plot(e5.trip.Erate,'--','DisplayName','Cycle05','LineWidth',1);
plot(e6.trip.Erate,'--','DisplayName','Cycle06','LineWidth',1);
plot(e7.trip.Erate,'--','DisplayName','Cycle07','LineWidth',1);
plot(e8.trip.Erate,'--','DisplayName','Cycle08','LineWidth',1);
plot(e9.trip.Erate,'--','DisplayName','Cycle09','LineWidth',1);
plot(e10.trip.Erate,'--','DisplayName','Cycle10','LineWidth',1);
plot(e11.trip.Erate,'--','DisplayName','Cycle11','LineWidth',1);
plot(e12.trip.Erate,'--','DisplayName','Cycle12','LineWidth',1);
plot(e13.trip.Erate,'--','DisplayName','Cycle13','LineWidth',1);
plot(e14.trip.Erate,'--','DisplayName','Cycle14','LineWidth',1);
plot(e15.trip.Erate,'--','DisplayName','Cycle15','LineWidth',1);
plot(e16.trip.Erate,'--','DisplayName','Cycle16','LineWidth',1);
plot(trip.Erate,'-','Color','k','DisplayName','Averaged Profile','LineWidth',3);
hold off
% Figure Properties
ylabel('RCI [KWh/(Kg.Km)]','FontSize',12,'FontWeight','bold','Color','k');
ylim([-1.5 8]);
xlabel('No. of Samples','FontSize',12,'FontWeight','bold','Color','k');
title('Averaged RCI - Route 401 (Training Data)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 6;
lgd.Location = 'northwest';
grid on;

% Plot - Averaged Power Profile
figure()
plot(trip.Paux,'-','Color','k','DisplayName','Averaged Profile','LineWidth',1.5);
% Figure Properties
ylabel('Auxiliary Power [W]','FontSize',12,'FontWeight','bold','Color','k');
xlabel('No. of Samples','FontSize',12,'FontWeight','bold','Color','k');
title('Averaged Power - Route 401 (Training Data)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 9;
lgd.Location = 'northeast';
grid on;
