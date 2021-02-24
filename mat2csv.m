% This script can be used to convert the matlab data into .csv

%   Author: Dhruv Jagga
%   Project: Source Code - Cloud Your Bus
%   email: d.jagga@tue.nl
%   Date: 10-12-2019;
%   Revised: 06-08-2020

% Simulation outputs (For csv)

output.time                     = out.Drivetrain.timeRoute.Data;
output.EnergyBat                = out.Drivetrain.EbatRoute.Data;
output.EnergyDrive              = out.Drivetrain.EdriveRoute.Data;

output.EnergyAuxActual          = out.Auxiliary.energyAuxActual.Data;
output.EnergyAuxTrip            = out.Auxiliary.energyAuxTrip.Data;
output.EnergyAuxTripCurrent     = out.Auxiliary.energyAuxTripCurrent.Data;

output.EnergyDriveActual        = out.Drivetrain.energyDriveActual.Data;
output.EnergyDriveTrip          = out.Drivetrain.energyDriveTrip.Data;
output.EnergyDriveTripCurrent   = out.Drivetrain.energyDriveTripCurrent.Data;

output.EnergyActual             = out.Total.energyActual.Data;
output.EnergyTrip               = out.Total.energyTrip.Data;
output.EnergyTripCurrent        = out.Total.energyTripCurrent.Data;

output.massEstimate             = out.Drivetrain.massEstimate.Data;
output.corrGain                 = out.Auxiliary.corrGain.Data;
output.distanceRoute            = out.Drivetrain.sRoute.Data;
output.eState                   = out.Drivetrain.eState.Data;

output.error                    = out.Total.error.Data;
output.Deviation                = out.Total.deviation.Data;

T = struct2table(output);
writetable(T,'SimulationOutput.csv');

% Simulation inputs (For csv)

input.EnergyAux     = EnergyAux;
input.EnergyBat     = EnergyBat;
input.EnergyDrive   = EnergyDrive;

input.head          = head(idx_Start:idx_Stop,1);
input.lat           = lat(idx_Start:idx_Stop,1);
input.lon           = lon(idx_Start:idx_Stop,1);

input.PowerAux      = PowerAux;
input.PowerBat      = PowerBat;
input.PowerDrive    = PowerDrive;

input.s             = s;
input.time          = time;
input.v             = v;

T1 = struct2table(input);
writetable(T1,'SimulationInput.csv');

% Trip Data (for csv)

load('ErateAvgRoute401.mat');

T2 = struct2table(trip);
writetable(T2,'TripData.csv');
