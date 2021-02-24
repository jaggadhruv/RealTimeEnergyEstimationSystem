% This script is used to publish plots for Scientific Paper  

%   Author: Dhruv Jagga
%   Project: Source Code - Cloud Your Bus
%   email: d.jagga@tue.nl
%   Date: 10-12-2019;
%   Revised: 22-05-2020


% Clear Workspace
clc;
clear;
close all;


figure()
subplot(2,2,1)
h1 = plot(out.Total.energyTrip,':','Color','k','DisplayName','E_{End}','LineWidth',3.0);
hold on
h2 = plot(out.Total.energyTripCurrent,':','Color','b','DisplayName','E_{Current}','LineWidth',3.0);
h3 = plot(out.Total.energyActual,'-','Color','r','DisplayName','E_{Meas}','LineWidth',1.5);
hold off
% Figure Properties
ylabel('Energy [kWh]','FontSize',12,'Color','k');
xlabel('No. of Samples','FontSize',12,'Color','k');
title('Total Estimation','FontSize',14,'FontWeight','bold','Color','k');
set(gca,'FontSize',10)
lgd = legend;
lgd.FontSize = 8;
lgd.Location = 'southeast';
grid on;

subplot(2,2,2)
h4 = plot(out.Total.error,'-','Color','k','DisplayName','Error','LineWidth',1.5);
% Figure Properties
ylabel('Amplitude [%]','FontSize',12,'Color','k');
xlabel('No. of Samples','FontSize',12,'Color','k');
title('Error in Estimation','FontSize',14,'FontWeight','bold','Color','k');
set(gca,'FontSize',10)
grid on;

subplot(2,2,3)
h7 = plot(out.Total.deviation,'-','Color','k','DisplayName','Deviation','LineWidth',1.5);
% Figure Properties
ylabel('Amplitude [%]','FontSize',12,'Color','k');
xlabel('No. of Samples','FontSize',12,'Color','k');
title('Deviation from Offline Estimation','FontSize',14,'FontWeight','bold','Color','k');
set(gca,'FontSize',10)
grid on;

subplot(2,2,4)
h8 = plot(out.reliability,'-','Color','r','DisplayName','Reliability','LineWidth',1.5);
% Figure Properties
ylabel('Amplitude [%]','FontSize',12,'Color','k');
xlabel('No. of Samples','FontSize',12,'Color','k');
title('Reliability of Estimation','FontSize',14,'FontWeight','bold','Color','k');
set(gca,'FontSize',10)
grid on;
set(gcf,'Position',[10 10 600 500])

% % Create dummy subplot for legend
% hLegend = subplot(3,2,5.5);
% posLegend = get(hLegend,'Position');
% 
% 
% leg = legend(hLegend,[h1;h2;h3;h7],'Estimation (Trip End)','Estimation (Current)','Measurement','Estimation');
% leg.FontSize = 11;
% axis(hLegend,'off');
% set(leg,'Position',posLegend);
% %set(gcf,'Position',[10 10 600 600]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure()
subplot(3,2,1);
h1 = plot(out.Drivetrain.eState,'-','Color','k','DisplayName','Active Status','LineWidth',1.5);
% Figure Properties
ylabel('Status [-]','FontSize',16,'Color','k');
ylim([0 2]);
xlabel('No. of Samples','FontSize',16,'Color','k');
title('Active Status','FontSize',16,'Color','k');
set(gca,'FontSize',11, 'TitleFontSizeMultiplier',1);
grid on;

subplot(3,2,2)
h2 = plot(out.postProcess.counter,'-','Color','r','DisplayName','Counter','LineWidth',1.5);
hold on
h3 = plot(out.postProcess.reset,'-','Color','b','DisplayName','Reset','LineWidth',1.5);
hold off
% Figure Properties
ylabel('Amplitude [-]','FontSize',16,'Color','k');
ylim([-0.5 3.5]);
xlabel('No. of Samples','FontSize',16,'Color','k');
title('Route Count','FontSize',16,'Color','k');
lgd = legend;
lgd.FontSize = 9;
lgd.Location = 'northeast';
set(gca,'FontSize',11, 'TitleFontSizeMultiplier',1);
grid on;

subplot(3,2,3)
h4 = plot(out.Drivetrain.energyDriveTrip,':','Color','k','DisplayName','E_{End}','LineWidth',3.0);
hold on
h5 = plot(out.Drivetrain.energyDriveTripCurrent,':','Color','b','DisplayName','E_{Curr}','LineWidth',3.0);
h6 = plot(out.Drivetrain.energyDriveActual,'-','Color','r','DisplayName','E_{Meas}','LineWidth',1.5);
hold off
% Figure Properties
ylabel('Energy [kWh]','FontSize',16,'Color','k');
xlabel('No. of Samples','FontSize',16,'Color','k');
title('Drivetrain Estimation','FontSize',16,'FontWeight','bold','Color','k');
set(gca,'FontSize',11, 'TitleFontSizeMultiplier',1);
lgd = legend;
lgd.FontSize = 9;
lgd.Location = 'southeast';
grid on;

subplot(3,2,4)
h7 = plot(out.Auxiliary.energyAuxTrip,':','Color','k','DisplayName','E_{End}','LineWidth',3.0);
hold on
h8 = plot(out.Auxiliary.energyAuxTripCurrent,':','Color','b','DisplayName','E_{Current}','LineWidth',3.0);
h9 = plot(out.Auxiliary.energyAuxActual,'-','Color','r','DisplayName','M','LineWidth',1.5);
hold off
% Figure Properties
ylabel('Energy [kWh]','FontSize',16,'Color','k');
xlabel('No. of Samples','FontSize',16,'Color','k');
title('Auxiliary Estimation','FontSize',16,'FontWeight','bold','Color','k');
set(gca,'FontSize',11, 'TitleFontSizeMultiplier',1);
grid on;

subplot(3,2,5)
h10 = plot(out.Drivetrain.massEstimate,':','Color','r','DisplayName','Estimation','LineWidth',3.0);
% Figure Properties
ylabel('m [Kg]','FontSize',16,'Color','k');
xlabel('No. of Samples','FontSize',16,'Color','k');
title('Mass Estimation','FontSize',12,'FontWeight','bold','Color','k');
set(gca,'FontSize',11, 'TitleFontSizeMultiplier',1);
grid on;

subplot(3,2,6)
h11 = plot(out.Auxiliary.corrGain,':','Color','r','DisplayName','Estimation','LineWidth',3.0);
% Figure Properties
ylabel('n [-]','FontSize',16,'Color','k');
xlabel('No. of Samples','FontSize',16,'Color','k');
title('Gain Estimation','FontSize',12,'FontWeight','bold','Color','k');
set(gca,'FontSize',11, 'TitleFontSizeMultiplier',1);
grid on;
set(gcf,'Position',[10 10 600 800])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot - Erate Calculation
figure()
plot(out.postProcess.Erate,'-','Color','k','DisplayName','RCI','LineWidth',1.5);
% Figure Properties
ylabel('RCI [m/s^2]','FontSize',12,'Color','k');
xlabel('No. of Samples ','FontSize',12,'Color','k');
title('RCI (Road Characteristics Index)','FontSize',12,'FontWeight','bold','Color','k');
grid on;


