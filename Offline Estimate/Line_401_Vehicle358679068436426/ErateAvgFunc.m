%   Author: Dhruv Jagga
%   Project: Source Code - Cloud Your Bus
%   email: d.jagga@tue.nl
%   Date: 10-12-2019;
%   Revised: 28-07-2020

% Clear Workspace
clc;
clear;
close all;

% Create path in the current directory
directory.current = pwd;                                % returns path of current directory
addpath(genpath('./Output Data Profile'));              % add the folder and subfolders to the working path (workspace)
addpath(genpath('./Averaged Data Profile'));            % add the folder and subfolders to the working path (workspace)

% Number of trips to be averaged
n = 16;

% Load Erate profile data structures for Individual trip
% Line 401_A (Direction - Station to Airport) 
m1 = load("ErateProfile401_A_01.mat");
m2 = load("ErateProfile401_A_02.mat");
m3 = load("ErateProfile401_A_03.mat");
m4 = load("ErateProfile401_A_04.mat");
m5 = load("ErateProfile401_A_05.mat");
m6 = load("ErateProfile401_A_06.mat");
m7 = load("ErateProfile401_A_07.mat");
m8 = load("ErateProfile401_A_08.mat");
m9 = load("ErateProfile401_A_09.mat");
m10 = load("ErateProfile401_A_10.mat");
m11 = load("ErateProfile401_A_11.mat");
m12 = load("ErateProfile401_A_12.mat");
m13 = load("ErateProfile401_A_13.mat");
m14 = load("ErateProfile401_A_14.mat");
m15 = load("ErateProfile401_A_15.mat");
m16 = load("ErateProfile401_A_16.mat");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extracting the Erate profiles from subsequent data structures
e1 = m1.trip.Erate;
e2 = m2.trip.Erate;
e3 = m3.trip.Erate;
e4 = m4.trip.Erate;
e5 = m5.trip.Erate;
e6 = m6.trip.Erate;
e7 = m7.trip.Erate;
e8 = m8.trip.Erate;
e9 = m9.trip.Erate;
e10 = m10.trip.Erate;
e11 = m11.trip.Erate;
e12 = m12.trip.Erate;
e13 = m13.trip.Erate;
e14 = m14.trip.Erate;
e15 = m15.trip.Erate;
e16 = m16.trip.Erate;

% Creating averaged Erate Profile
e = min([length(e1),length(e2),length(e3),length(e4)...
    ,length(e5),length(e6),length(e7),length(e8)...
    ,length(e9),length(e10),length(e11),length(e12)...
    ,length(e13),length(e14),length(e15),length(e16)]);

s = min([m1.trip.s,m2.trip.s,m3.trip.s,m4.trip.s...
    ,m5.trip.s,m6.trip.s,m7.trip.s,m8.trip.s...
    ,m9.trip.s,m10.trip.s,m11.trip.s,m12.trip.s...
    ,m13.trip.s,m14.trip.s,m15.trip.s,m16.trip.s]);

% Initializing the Erate vector with averaged size
ErateAvg = zeros(e,1);

% Averaging the Erate and corresponding time array
for i = 1:e
    ErateAvg(i) = (m1.trip.Erate(i)+m2.trip.Erate(i)+m3.trip.Erate(i)+m4.trip.Erate(i)...
                   + m5.trip.Erate(i)+m6.trip.Erate(i)+m7.trip.Erate(i)+m8.trip.Erate(i)...
                   + m9.trip.Erate(i)+m10.trip.Erate(i)+m11.trip.Erate(i)+m12.trip.Erate(i)...
                   + m13.trip.Erate(i)+m14.trip.Erate(i)+m15.trip.Erate(i)+m16.trip.Erate(i))/n;
               
               
    timeAvg(i)  = (m1.trip.time(i)+m2.trip.time(i)+m3.trip.time(i)+m4.trip.time(i)...
                   + m5.trip.time(i)+m6.trip.time(i)+m7.trip.time(i)+m8.trip.time(i)...
                   + m9.trip.time(i)+m10.trip.time(i)+m11.trip.time(i)+m12.trip.time(i)...
                   + m13.trip.time(i)+m14.trip.time(i)+m15.trip.time(i)+m16.trip.time(i))/n;     
end

mveh = 19000;

ErateAvg = ErateAvg;
timeAvg  = timeAvg';

% Creating averaged Auxiliary Power Profile
%PauxAvg = mean([m1.trip.Paux m2.trip.Paux m3.trip.Paux m4.trip.Paux]);

% Creating time varying Auxiliary Power Profile
f = min([length(m1.trip.time),length(m2.trip.time),length(m3.trip.time),length(m4.trip.time)...
    ,length(m5.trip.time),length(m6.trip.time),length(m7.trip.time),length(m8.trip.time)...
    ,length(m9.trip.time),length(m10.trip.time),length(m11.trip.time),length(m12.trip.time)...
    ,length(m13.trip.time),length(m14.trip.time),length(m15.trip.time),length(m16.trip.time)]);

% Extracting the time array from the data structure
timeAux1 = m1.trip.timeAux;
timeAux2 = m2.trip.timeAux;
timeAux3 = m3.trip.timeAux;
timeAux4 = m4.trip.timeAux;
timeAux5 = m5.trip.timeAux;
timeAux6 = m6.trip.timeAux;
timeAux7 = m7.trip.timeAux;
timeAux8 = m8.trip.timeAux;
timeAux9 = m9.trip.timeAux;
timeAux10 = m10.trip.timeAux;
timeAux11 = m11.trip.timeAux;
timeAux12 = m12.trip.timeAux;
timeAux13 = m13.trip.timeAux;
timeAux14 = m14.trip.timeAux;
timeAux15 = m15.trip.timeAux;
timeAux16 = m16.trip.timeAux;

% Extracting the Power array from the data structure
Paux1 = m1.trip.Paux;
Paux2 = m2.trip.Paux;
Paux3 = m3.trip.Paux;
Paux4 = m4.trip.Paux;
Paux5 = m5.trip.Paux;
Paux6 = m6.trip.Paux;
Paux7 = m7.trip.Paux;
Paux8 = m8.trip.Paux;
Paux9 = m9.trip.Paux;
Paux10 = m10.trip.Paux;
Paux11 = m11.trip.Paux;
Paux12 = m12.trip.Paux;
Paux13 = m13.trip.Paux;
Paux14 = m14.trip.Paux;
Paux15 = m15.trip.Paux;
Paux16 = m16.trip.Paux;

% Interpolating the Power according to the distance-time interpolation
Paux1 = interp1(timeAux1,Paux1,m1.trip.time);
Paux2 = interp1(timeAux2,Paux2,m2.trip.time);
Paux3 = interp1(timeAux3,Paux3,m3.trip.time);
Paux4 = interp1(timeAux4,Paux4,m4.trip.time);
Paux5 = interp1(timeAux5,Paux5,m5.trip.time);
Paux6 = interp1(timeAux6,Paux6,m6.trip.time);
Paux7 = interp1(timeAux7,Paux7,m7.trip.time);
Paux8 = interp1(timeAux8,Paux8,m8.trip.time);
Paux9 = interp1(timeAux9,Paux9,m9.trip.time);
Paux10 = interp1(timeAux10,Paux10,m10.trip.time);
Paux11 = interp1(timeAux11,Paux11,m11.trip.time);
Paux12 = interp1(timeAux12,Paux12,m12.trip.time);
Paux13 = interp1(timeAux13,Paux13,m13.trip.time);
Paux14 = interp1(timeAux14,Paux14,m14.trip.time);
Paux15 = interp1(timeAux15,Paux15,m15.trip.time);
Paux16 = interp1(timeAux16,Paux16,m16.trip.time);

% Averaging the Auxiliary Power and corresponding time array
for j = 1:f
    PauxAvg(j)    = (Paux1(j) + Paux2(j) + Paux3(j) + Paux4(j)...
                   + Paux5(j) + Paux6(j) + Paux7(j) + Paux8(j)...
                   + Paux9(j) + Paux10(j) + Paux11(j) + Paux12(j)...
                   + Paux13(j) + Paux14(j) + Paux15(j) + Paux16(j))/n;
                
    timeAuxAvg(j) = (m1.trip.time(j) + m2.trip.time(j) + m3.trip.time(j) + m4.trip.time(j)...
                   + m5.trip.time(j) + m6.trip.time(j) + m7.trip.time(j) + m8.trip.time(j)...
                   + m9.trip.time(j) + m10.trip.time(j) + m11.trip.time(j) + m12.trip.time(j)...
                   + m13.trip.time(j) + m14.trip.time(j) + m15.trip.time(j) + m16.trip.time(j))/n;
end

PauxAvg     = PauxAvg';
timeAuxAvg  = timeAuxAvg';
dt          = [0;diff(timeAuxAvg)];                              % used as weighted sample space

sRoute      = [1:1:s]';                                          % distance vector with sample of '1m' for particular route
ds          = [0;diff(sRoute)];                                  % used as weighted sample space

%Euse_estimate  = cumsum(ErateAvg.*ds)*mveh/3.6e6 + PauxAvg*timeAvg/3.6e6;
EuseDrive  = cumsum(ErateAvg.*ds)*mveh/3.6e6;
EuseAux    = cumsum(PauxAvg.*dt)/3.6e6;

Etrip_measured = mean([m1.trip.Etrip_measured m2.trip.Etrip_measured m3.trip.Etrip_measured m4.trip.Etrip_measured...
                       m5.trip.Etrip_measured m6.trip.Etrip_measured m7.trip.Etrip_measured m8.trip.Etrip_measured...
                       m9.trip.Etrip_measured m10.trip.Etrip_measured m11.trip.Etrip_measured m12.trip.Etrip_measured...
                       m13.trip.Etrip_measured m14.trip.Etrip_measured m15.trip.Etrip_measured m16.trip.Etrip_measured]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Making a new trip parameter structure with average Erate (+ all averaged profiles)
trip.sRoute         = sRoute;
trip.mveh           = mveh;

trip.s              = s;
trip.time           = timeAvg;

trip.Erate          = ErateAvg;
trip.Paux           = PauxAvg;

trip.Euse_estimate_drive  = EuseDrive;
trip.Euse_estimate_aux    = EuseAux;

trip.timeAux        = timeAuxAvg;
trip.Etrip_measured = Etrip_measured;

%save ErateAvgRoute401_A trip

% Save the trip data structure into the Output Data Profile Folder in directory
savdir = 'C:\Users\20184719\Documents\Final Project - Module 5\Source Code\CYB - Energy Estimation\Route401\Line_401_Vehicle358679068436426\Averaged Data Profile';
save(fullfile(savdir,'ErateAvgRoute401_A'),'trip');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
figure()
plot(e1,'c--');
hold on
plot(e2,'b--');
plot(e3,'g--');
plot(e4,'m--');
plot(ErateAvg,'k-','LineWidth',1.5);
hold off
xlabel('Distance [m]');
ylabel('E_{Rate} [m/s2]');
legend('e1', 'e2', 'e3', 'e4','eAvg');
title('E_{Rate} average and over 4 different cycles of route 401');

figure()
plot(m1.trip.EuseDrive,'c--');
hold on
plot(m2.trip.EuseDrive,'b--');
plot(m3.trip.EuseDrive,'g--');
plot(m4.trip.EuseDrive,'m--');
hold off
xlabel('Distance [m]');
ylabel('Energy Estimate [KWh]');
legend('EnergyEst1', 'EnergyEst2', 'EnergyEst3', 'EnergyEst4');
title('Energy Estimate over 4 different cycles of route 401');

figure()
plot(cumsum(Paux1*0.1)/3.6e6,'c--');
hold on
plot(cumsum(Paux2*0.1)/3.6e6,'b--');
plot(cumsum(Paux3*0.1)/3.6e6,'g--');
plot(cumsum(Paux4*0.1)/3.6e6,'m--');
plot(cumsum(PauxAvg*0.1)/3.6e6,'k-','LineWidth',1.5);
hold off
xlabel('time [s]');
ylabel('Auxiliary Energy [KWh]');
legend('EnergyEst1', 'EnergyEst2', 'EnergyEst3', 'EnergyEst4','Average EnergyEst');
title('Auxiliary Energy Consumption over 4 different cycles of route 401');

%%
% Absolute Error in the measured and estimated value (Without Correction)

TotalActualEnergyTrip1 = sum(m1.trip.EuseDrive) + sum(m1.trip.EuseAux);
TotalEstimatedEnergy   = sum(EuseDrive) + sum(EuseAux);

errorAbsolute = (TotalActualEnergyTrip1 - TotalEstimatedEnergy)/TotalActualEnergyTrip1 * 100;

% Plots of Energy Estimate without Correction
figure()
plot(m1.trip.EuseDrive);
hold on
plot(EuseDrive);
hold off
xlabel('No. of Samples');
ylabel('Drivetrain Energy [KWh]');
legend('Measured Energy','Estimated Energy (Without Correction)');
title('Drivetrain Energy Consumption and Estimation without correction');

figure()
plot(m1.trip.EuseAux);
hold on
plot(EuseAux);
hold off
xlabel('No. of Samples');
ylabel('Auxiliary Energy [KWh]');
legend('Measured Energy','Estimated Energy (Without Correction)');
title('Auxiliary Energy Consumption and Estimation without correction');

