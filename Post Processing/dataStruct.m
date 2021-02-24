function [trip] = dataStruct(ErateExt,timeExt,sExt,PauxExt,energyTripExt,out)

%   Author: Dhruv Jagga
%   Project: Source Code - Cloud Your Bus
%   email: d.jagga@tue.nl
%   Date: 10-12-2019;
%   Revised: 06-08-2020

trip = struct();

trip0 = struct();
trip1 = struct();
trip2 = struct();


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
trip1.mveh   = 19000;                                                                   % Kg
dt1          = [0,diff(timeExt.timeCycle1)];                                            % used as weighted sample space

trip1.s      = max(sExt.sCycle1);
trip1.sRoute = [1:1:max(sExt.sCycle1)]';                                                % distance vector with sample of '1m' for particular route
ds1          = [0;diff(trip1.sRoute)];                                                  % used as weighted sample space

[sIntp,index]  = unique(sExt.sCycle1);
trip1.time     = interp1(sIntp,timeExt.timeCycle1(index),trip1.sRoute);                 % interpolating the time vector at every 1 m distance

% Saving updated Erate profile
Erate = ErateExt.ErateCycle1;

trip1.Erate      = interp1(sIntp,Erate(index),trip1.sRoute);                            % interpolating the Erate vector at every 1 m distance

% Saving updated Paux profile
trip1.Paux = PauxExt.PauxCycle1';

% Creating Drivetrain trip profile
trip1.EuseDrive = cumsum(trip1.Erate)*trip1.mveh/3.6e6;

% Creating Auxiliary trip profile
trip1.EuseAux   = cumsum(trip1.Paux.*dt1')/3.6e6;
trip1.timeAux   = timeExt.timeCycle1';

% Saving only the legit data and throwing away NaN data 
energyTripCycle1 = energyTripExt.energyTripCycle1;
idx1 = (~isnan(energyTripCycle1));
energyTripCycle1 = energyTripCycle1(idx1);
trip1.Etrip_measured = energyTripCycle1(length(energyTripCycle1));

% Checking health status of the stored data
trip1.tripDataHealth = all(~isnan(trip1.Erate(:))) && all(~isnan(trip1.Paux(:))) && (trip1.Etrip_measured ~=0 || ~isnan(trip1.Etrip_measured));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

trip2.mveh   = 19000;                                                                   % Kg
dt2          = [0,diff(timeExt.timeCycle2)];                                            % used as weighted sample space

trip2.s      = max(sExt.sCycle2);
trip2.sRoute = [1:1:max(sExt.sCycle2)]';                                                % distance vector with sample of '1m' for particular route
ds2          = [0;diff(trip2.sRoute)];                                                  % used as weighted sample space

[sIntp,index]  = unique(sExt.sCycle2);
trip2.time     = interp1(sIntp,timeExt.timeCycle2(index),trip2.sRoute);                 % interpolating the time vector at every 1 m distance

% Saving updated Erate profile
Erate = ErateExt.ErateCycle2;

trip2.Erate      = interp1(sIntp,Erate(index),trip2.sRoute);                            % interpolating the Erate vector at every 1 m distance

% Saving updated Paux profile
trip2.Paux = PauxExt.PauxCycle2';

% Creating Drivetrain trip profile
trip2.EuseDrive = cumsum(trip2.Erate)*trip2.mveh/3.6e6;

% Creating Auxiliary trip profile
trip2.EuseAux   = cumsum(trip2.Paux.*dt2')/3.6e6;
trip2.timeAux   = timeExt.timeCycle2';

% Saving only the legit data and throwing away NaN data 
energyTripCycle2 = energyTripExt.energyTripCycle2;
idx2 = (~isnan(energyTripCycle2));
energyTripCycle2 = energyTripCycle2(idx2);
trip2.Etrip_measured = energyTripCycle2(length(energyTripCycle2));

% Checking health status of the stored data
trip2.tripDataHealth = all(~isnan(trip2.Erate(:))) && all(~isnan(trip2.Paux(:))) && (trip2.Etrip_measured ~=0 || ~isnan(trip2.Etrip_measured));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

trip0.mveh   = 19000;                                     % Kg
trip0.s      = 0;
trip0.sRoute = zeros(10000,1);

trip0.time      = zeros(10000,1);

% Saving updated Erate profile
trip0.Erate = zeros(10000,1);

% Saving updated Paux profile
trip0.Paux = zeros(10000,1);

% Creating Drivetrain trip profile
trip0.EuseDrive = zeros(10000,1);

% Creating Auxiliary trip profile
trip0.EuseAux   = zeros(10000,1);
trip0.timeAux   = zeros(10000,1);

trip0.Etrip_measured = 0;
trip0.tripDataHealth = false;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

trip.trip0 = trip0;
trip.trip1 = trip1;
trip.trip2 = trip2;


end

