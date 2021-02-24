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
addpath(genpath('./Results - Online Estimation'));      % add the folder and subfolders to the working path (workspace)
addpath(genpath('./Parameter'));                        % add the folder and subfolders to the working path (workspace)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Absolute error data over different cycles

x = [1 2 3 4 5 6 7 8 9 10]*10 ;

absError01 = [ 2.5886 1.8003 0.6713 0.0979 0.2183 0.0450 0.0096 0.0221 0.0333 1.6538];
absError02 = [17.5311 4.9065 1.9977 1.0263 0.4699 0.2527 0.1995 0.1305 0.1035 1.3630];
absError03 = [17.4093 3.3644 1.1048 0.6356 0.3045 0.1944 0.0957 1.2101 1.2353 2.1809];
absError04 = [ 4.2092 4.0580 1.8026 1.0347 0.5224 0.3114 0.1936 0.1752 0.0917 0.9345];
absError05 = [ 1.8335 0.1043 0.2733 0.1424 0.1066 0.0481 0.0197 0.0224 0.0579 2.1513];
absError06 = [ 9.5908 0.5008 0.0923 0.1871 0.3909 0.2840 0.1856 0.1176 0.0785 0.0728];
absError07 = [ 5.8435 1.4573 0.2012 0.0028 0.1424 0.0737 0.0164 0.0036 0.0125 0.0178];
absError08 = [ 8.1106 2.4612 1.3298 0.4487 0.2301 0.1419 0.1509 0.1433 0.0880 0.0677];
absError09 = [11.0278 1.1408 0.9209 0.1899 0.1751 0.0418 0.0941 0.0071 0.0154 0.0342];
absError10 = [ 4.6246 2.0940 0.1560 0.4523 0.2006 0.1080 0.0780 0.0121 0.0012 0.0186];
absError11 = [10.9403 5.4457 0.9584 0.5133 0.3078 0.2137 0.1227 0.1159 0.0719 0.0428];
absError12 = [ 8.2445 2.8423 1.2402 0.7020 0.3460 0.1815 0.1491 0.0532 0.0445 0.2086];
absError13 = [11.0640 2.4452 1.1548 0.4770 0.1777 0.1432 0.0422 0.0359 0.0456 0.3365];
absError14 = [16.1641 0.6157 0.1391 0.0348 0.0815 0.0731 0.0208 1.4466 1.2063 1.2916];
absError15 = [ 6.8537 2.4699 1.2130 0.7014 0.2745 0.2076 0.1316 0.0871 1.1791 1.2904];
absError16 = [ 6.0787 0.2751 0.8038 0.4959 0.4981 0.2161 0.1390 0.1233 0.0971 1.4541];
absError17 = [12.8295 3.2326 1.0463 0.5978 0.3663 0.2747 0.1707 0.3748 0.3311 1.1854];
absError18 = [ 9.5958 3.7416 1.5010 0.7260 0.5771 0.3654 0.2430 0.1632 1.6672 2.7289];
absError19 = [15.5932 0.1006 0.2961 0.2765 0.1994 0.0062 0.0519 1.3891 2.6642 3.4272];
absError20 = [15.7371 5.2971 2.2969 1.2432 0.7618 0.5798 0.3828 0.2447 0.2388 2.1487];
absError21 = [ 8.8482 2.1295 1.3443 0.6158 0.4873 0.2025 0.1904 0.1358 1.3245 3.4359];

% Absolute error with updated profile and test data [cycle 03 and cycle 04]
test2absError03 = [10.5115  7.0157 1.5428 0.4213 0.1989 0.2872 0.2175 0.1494 0.1837 0.1749];
test2absError04 = [43.9661 12.2461 4.0771 1.9556 0.7357 0.3024 0.1512 0.1284 0.0259 0.0345];

% Absolute error with updated profile and validation data [cycle 17 and cycle 18]
test2absError17 = [ 3.7141  1.4400 0.8485 0.7175 0.5280 0.4134 0.2697 0.2368 0.1847 0.1540];
test2absError18 = [50.2463 10.3627 3.6298 1.5236 0.6722 0.3876 0.2176 0.1520 0.0811 0.3166];

% Plotting Absolute error over different cycles
err = [15.6976 5.3451 2.2046 1.2401 0.6803 0.5736 0.3732 1.4430 2.6630 3.4181]/2;

% Plot - Progression of Absolute Error - Route 401 (21 Cycle)
figure()
plot(x,absError01,'DisplayName','Cycle01','LineWidth',1.5);
hold on
plot(x,absError02,'DisplayName','Cycle02','LineWidth',1.5);
plot(x,absError03,'DisplayName','Cycle03','LineWidth',1.5);
plot(x,absError04,'DisplayName','Cycle04','LineWidth',1.5);
plot(x,absError05,'DisplayName','Cycle05','LineWidth',1.5);
plot(x,absError06,'DisplayName','Cycle06','LineWidth',1.5);
plot(x,absError07,'DisplayName','Cycle07','LineWidth',1.5);
plot(x,absError08,'DisplayName','Cycle08','LineWidth',1.5);
plot(x,absError09,'DisplayName','Cycle09','LineWidth',1.5);
plot(x,absError10,'DisplayName','Cycle10','LineWidth',1.5);
plot(x,absError11,'DisplayName','Cycle11','LineWidth',1.5);
plot(x,absError12,'DisplayName','Cycle12','LineWidth',1.5);
plot(x,absError13,'DisplayName','Cycle13','LineWidth',1.5);
plot(x,absError14,'DisplayName','Cycle14','LineWidth',1.5);
plot(x,absError15,'DisplayName','Cycle15','LineWidth',1.5);
plot(x,absError16,'DisplayName','Cycle16','LineWidth',1.5);
plot(x,absError17,'DisplayName','Cycle17','LineWidth',1.5);
plot(x,absError18,'DisplayName','Cycle18','LineWidth',1.5);
plot(x,absError19,'DisplayName','Cycle19','LineWidth',1.5);
plot(x,absError20,'DisplayName','Cycle20','LineWidth',1.5);
plot(x,absError21,'DisplayName','Cycle21','LineWidth',1.5);
errorbar(x,absError21,err,'DisplayName','Error Bar','LineWidth',1.5);
hold off
% Figure Properties
ylabel('Absolute Error [%]','FontSize',12,'FontWeight','bold','Color','k');
xlabel('Route Distance Travelled [%]','FontSize',12,'FontWeight','bold','Color','k');
%title('Progression of Absolute Error - Route 401 (21 Cycle)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 6.5;
lgd.Location = 'northeast';
grid on;

% Plot - Comparison of Absolute Error (in measured and estimated energy)- Route 401 (Training Data) with base profile and updated profile
figure()
subplot(2,1,1);
w1 = 0.5;
bar(x,absError03,w1,'FaceColor',[0.2 0.2 0.5]);
w2 = 0.25;
hold on
bar(x,test2absError03,w2,'FaceColor',[0 0.7 0.7])
hold off
% Figure Properties
ylabel('Absolute Error [%]','FontSize',12,'Color','k');
xlabel('Route Distance Travelled [%]','FontSize',12,'Color','k');
%title('Comparison of Absolute Error - Route 401 (Training Data)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend('Abs. Error with Base Reference','Abs. Error with Updated Reference');
lgd.FontSize = 10;
set(gca,'FontSize',11, 'TitleFontSizeMultiplier',1);
grid on;

%figure()
subplot(2,1,2);
w1 = 0.5;
bar(x,absError04,w1,'FaceColor',[0.2 0.2 0.5]);
w2 = 0.25;
hold on
bar(x,test2absError04,w2,'FaceColor',[0 0.7 0.7])
hold off
% Figure Properties
ylabel('Absolute Error [%]','FontSize',12,'Color','k');
xlabel('Route Distance Travelled [%]','FontSize',12,'Color','k');
%title('Comparison of Absolute Error - Route 401 (Training Data)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend('Abs. Error with Base Reference','Abs. Error with Updated Reference');
lgd.FontSize = 10;
set(gca,'FontSize',11, 'TitleFontSizeMultiplier',1);
grid on;

% Plot - Comparison of Absolute Error (in measured and estimated energy)- Route 401 (Validation Data) with base profile and updated profile
figure()
subplot(2,1,1);
w1 = 0.5;
bar(x,absError17,w1,'FaceColor',[0.2 0.2 0.5]);
w2 = 0.25;
hold on
bar(x,test2absError17,w2,'FaceColor',[0 0.7 0.7])
hold off
% Figure Properties
ylabel('Absolute Error [%]','FontSize',12,'Color','k');
xlabel('Route Distance Travelled [%]','FontSize',12,'Color','k');
%title('Comparison of Absolute Error - Route 401 (Training Data)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend('Abs. Error with Base Reference','Abs. Error with Updated Reference');
lgd.FontSize = 10;
set(gca,'FontSize',11, 'TitleFontSizeMultiplier',1);
grid on;

subplot(2,1,2);
w1 = 0.5;
bar(x,absError18,w1,'FaceColor',[0.2 0.2 0.5]);
w2 = 0.25;
hold on
bar(x,test2absError18,w2,'FaceColor',[0 0.7 0.7])
hold off
% Figure Properties
ylabel('Absolute Error [%]','FontSize',12,'Color','k');
xlabel('Route Distance Travelled [%]','FontSize',12,'Color','k');
%title('Comparison of Absolute Error - Route 401 (Training Data)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend('Abs. Error with Base Reference','Abs. Error with Updated Reference');
lgd.FontSize = 10;
set(gca,'FontSize',11, 'TitleFontSizeMultiplier',1);
grid on;

% Plot - Comparison of Absolute error with Offline and Online Estimate (Correction)
x1 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21];
offline_absError = [8.2382 15.7306 32.1049 23.3071 4.2441 8.1959 17.7097 2.6124 1.1759 16.7030 34.6219 4.5323 29.8384 1.4536 30.2283...
                    39.9463 17.2104 26.3254 21.3144 21.6247 30.8518];
                
online_absError  = [1.6538 1.3630 2.1809 0.9345 2.1513 0.0728 0.0178 0.0677 0.0342 0.0186 0.0428 0.2086 0.3365 1.2916 1.2904 1.4541...
                    1.1854 2.7289 3.4272 2.1487 3.4359];
                
figure()
w1 = 0.5;
bar(x1,offline_absError,w1,'FaceColor',[0.9 0.2 0.2]);
w2 = 0.75;
hold on
bar(x1,online_absError,w2,'FaceColor',[0.0 0.0 0.0])
hold off
% Figure Properties
ylabel('Absolute Error [%]','FontSize',14,'Color','k');
xlabel('Total Number of Cycles','FontSize',14,'Color','k');
%title('Progression of Absolute Error - Route 401 (21 Cycle)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend('Abs. Error in Offline Estimation','Abs. Error in Online Estimation');
lgd.FontSize = 11;
lgd.Location = 'northwest';
grid on;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Online Estimations
%load('outcycle01.mat');
% load('test1-testdata0102-baseprofile.mat');
% load('test2-testdata03-updatedprofile.mat');
% load('test2-testdata04-updatedprofile.mat');
 load('test3-validationdata17-updatedprofile.mat');
% load('test3-validationdata18-updatedprofile.mat');

% Plot - Drivetrain Online Estimation (Route 401) - Individual Cycles
figure()
plot(out.Drivetrain.energyDriveTrip,':','Color','k','DisplayName','Estimation (Trip End)','LineWidth',3.0);
hold on
plot(out.Drivetrain.energyDriveTripCurrent,':','Color','b','DisplayName','Estimation (Current)','LineWidth',3.0);
plot(out.Drivetrain.energyDriveActual,'-','Color','r','DisplayName','Measured','LineWidth',1.5);
hold off
% Figure Properties
ylabel('Energy [kWh]','FontSize',15,'Color','k');
xlabel('No. of Samples','FontSize',15,'Color','k');
%title('Drivetrain Online Energy Estimation - Route 401 (Training Data)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 12;
lgd.Location = 'southeast';
grid on;

% Plot - Mass Estimation (Drivetrain)
figure()
plot(out.Drivetrain.massEstimate,':','Color','r','DisplayName','Estimation','LineWidth',3.0);
% Figure Properties
ylabel('m [Kg]','FontSize',15,'Color','k');
xlabel('No. of Samples','FontSize',15,'Color','k');
%title('Mass Estimation - Route 401 (Training Data)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 12;
lgd.Location = 'northeast';
grid on;

% Plot - Auxiliary Online Estimation (Route 401) - Individual Cycles
figure()
plot(out.Auxiliary.energyAuxTrip,':','Color','k','DisplayName','Estimation (Trip End)','LineWidth',3.0);
hold on
plot(out.Auxiliary.energyAuxTripCurrent,':','Color','b','DisplayName','Estimation (Current)','LineWidth',3.0);
plot(out.Auxiliary.energyAuxActual,'-','Color','r','DisplayName','Measured','LineWidth',1.5);
hold off
% Figure Properties
ylabel('Energy [kWh]','FontSize',15,'Color','k');
xlabel('No. of Samples','FontSize',15,'Color','k');
%title('Auxiliary Online Energy Estimation - Route 401 (Training Data)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 12;
lgd.Location = 'northeast';
grid on;

% Plot - Gain Estimation (Auxiliary)
figure()
plot(out.Auxiliary.corrGain,':','Color','r','DisplayName','Estimation','LineWidth',3.0);
% Figure Properties
ylabel('n [-]','FontSize',15,'Color','k');
xlabel('No. of Samples','FontSize',15,'Color','k');
%title('Gain Estimation - Route 401 (Training Data)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 12;
lgd.Location = 'northeast';
grid on;

% Plot - Total Online Estimation (Route 401) - Individual Cycles
figure()
plot(out.Total.energyTrip,':','Color','k','DisplayName','Estimation (Trip End)','LineWidth',3.0);
hold on
plot(out.Total.energyTripCurrent,':','Color','b','DisplayName','Estimation (Current)','LineWidth',3.0);
plot(out.Total.energyActual,'-','Color','r','DisplayName','Measured','LineWidth',1.5);
hold off
% Figure Properties
ylabel('Energy [kWh]','FontSize',15,'Color','k');
xlabel('No. of Samples','FontSize',15,'Color','k');
%title('Total Online Energy Estimation - Route 401 (Training Data)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 12;
lgd.Location = 'southeast';
grid on;

% Plot - Active Status
figure()
plot(out.Drivetrain.eState,'-','Color','k','DisplayName','Active Status','LineWidth',1.5);
% Figure Properties
ylabel('Status [-]','FontSize',15,'Color','k');
ylim([0 2]);
xlabel('No. of Samples','FontSize',15,'Color','k');
%title('Active Status - Route 401 (Training Data)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 12;
lgd.Location = 'northeast';
grid on;

% Plot - Error in Estimation
figure()
plot(out.Total.error,'-','Color','k','DisplayName','Error','LineWidth',1.5);
% Figure Properties
ylabel('Amplitude [%]','FontSize',15,'Color','k');
xlabel('No. of Samples','FontSize',15,'Color','k');
%title('Error in Estimation - Route 401 (Training Data)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 12;
lgd.Location = 'northeast';
grid on;

% Plot - Deviation from Offline Estimation
figure()
plot(out.Total.deviation,'-','Color','k','DisplayName','Deviation','LineWidth',1.5);
% Figure Properties
ylabel('Amplitude [%]','FontSize',15,'Color','k');
xlabel('No. of Samples','FontSize',15,'Color','k');
%title('Deviation from Offline Estimation - Route 401 (Training Data)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 12;
lgd.Location = 'northeast';
grid on;

% Plot - Erate Calculation
figure()
plot(out.postProcess.Erate,'-','Color','k','DisplayName','RCI','LineWidth',1.5);
% Figure Properties
ylabel('RCI [m/s^{2}]','FontSize',15,'Color','k');
xlabel('No. of Samples','FontSize',15,'Color','k');
%title('Calculated RCI - Route 401 (Training Data)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 12;
lgd.Location = 'northeast';
grid on;

% Plot - Counter and Reset
figure()
plot(out.postProcess.counter,'-','Color','r','DisplayName','Counter','LineWidth',1.5);
hold on
plot(out.postProcess.reset,'-','Color','b','DisplayName','Reset','LineWidth',1.5);
hold off
% Figure Properties
ylabel('Amplitude [-]','FontSize',15,'Color','k');
ylim([-0.5 3.5]);
xlabel('No. of Samples','FontSize',15,'Color','k');
%title('Route Count - Route 401 (Training Data)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 12;
lgd.Location = 'northeast';
grid on;

% Plot - Reliability
figure()
plot(out.reliability,'-','Color','r','DisplayName','Reliability','LineWidth',1.5);
% Figure Properties
ylabel('Amplitude [%]','FontSize',15,'Color','k');
ylim([0 120]);
xlabel('No. of Samples','FontSize',15,'Color','k');
%title('Estimation Reliability - Route 401 (Training Data)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 12;
lgd.Location = 'northeast';
grid on;

%%
% Comparison between base and updated profile
% Load Base and Updated Reference Profile
t1 = load('ErateAvgRoute401_A.mat');
t2 = load('UpdatedErateProfile401_A.mat');

% Base Profile Data
x1 = t1.trip.time;
y1 = t1.trip.Erate;

xp1 = t1.trip.time;
yp1 = t1.trip.Paux;

% Updated Profile Data
x2 = t2.trip.time;
y2 = t2.trip.Erate;

xp2 = t2.trip.time;
yp2 = t2.trip.Paux;

% Plot - Erate of Base and updated reference profile
figure()
line(x1,y1,'Color','r','DisplayName','RCI - Base Reference','LineWidth',1.5)
ax1 = gca; % current axes
ax1.XColor = 'r';
ax1.YColor = 'r';
ax1.YLim   = [-5 5];
ax1.XGrid  = 'on';
ax1.YGrid  = 'on';
ax1.FontSize = 16;
ax1.XLabel.String = 'No. of Samples';
ax1.XLabel.FontSize = 26;
ax1.XLabel.FontWeight = 'normal';
ax1.YLabel.String = 'RCI [m/s^{2}]';
ax1.YLabel.FontSize = 26;
ax1.YLabel.FontWeight = 'normal';
ax1.Position = [0.1100 0.1100 0.7750 0.8150];
ax1_pos = ax1.Position; % position of first axes
lgd = legend;
lgd.FontSize = 20;
lgd.Location = 'northeast';
grid on;

ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');

line(x2,y2,'Parent',ax2,'Color','k','DisplayName','RCI - Updated Reference','LineWidth',1.5);
ax2 = gca;
ax2.XGrid  = 'on';
ax2.YGrid  = 'on';
ax2.FontSize = 16;
ax2.XLabel.String = 'No. of Samples';
ax2.XLabel.FontSize = 26;
ax2.XLabel.FontWeight = 'normal';
ax2.YLabel.String = 'RCI [m/s^{2}]';
ax2.YLabel.FontSize = 26;
ax2.YLabel.FontWeight = 'normal';

% Figure Properties
%title('Comparison RCI Profile - Route 401 (Training Data)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 20;
lgd.Location = 'southeast';
grid on;


% Plot - Auxiliary Power Profile of Base and updated reference profile
figure()
line(xp1,yp1,'Color','r','DisplayName','Power - Base Reference','LineWidth',1.5)
ax1 = gca; % current axes
ax1.XColor = 'r';
ax1.YColor = 'r';
ax1.YLim   = [-7.5 3]*1e4;
ax1.XGrid  = 'on';
ax1.FontSize = 16;
%ax1.YGrid  = 'on';
ax1.XLabel.String = 'No. of Samples';
ax1.XLabel.FontSize = 26;
ax1.XLabel.FontWeight = 'normal';
ax1.YLabel.String = 'Power [W]';
ax1.YLabel.FontSize = 26;
ax1.YLabel.FontWeight = 'normal';
ax1.Position = [0.1100 0.1100 0.7750 0.8150];
ax1_pos = ax1.Position; % position of first axes
lgd = legend;
lgd.FontSize = 20;
lgd.Location = 'northeast';



ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');

line(xp2,yp2,'Parent',ax2,'Color','k','DisplayName','Power - Updated Reference','LineWidth',1.5);
ax2.XGrid  = 'on';
ax2.FontSize = 16;
%ax2.YGrid  = 'on';
ax2.XLabel.String = 'No. of Samples';
ax2.XLabel.FontSize = 26;
ax2.XLabel.FontWeight = 'normal';
ax2.YLabel.String = 'Power [W]';
ax2.YLabel.FontSize = 26;
ax2.YLabel.FontWeight = 'normal';

% Figure Properties
%title('Comparison Power Profile - Route 401 (Training Data)','FontSize',12,'FontWeight','bold','Color','k');
lgd = legend;
lgd.FontSize = 20;
lgd.Location = 'southeast';
grid on;










