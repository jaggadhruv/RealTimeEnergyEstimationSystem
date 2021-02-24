% This script is used to calculate the Absolute Error for the selected
% route from Simulation Results

%   Author: Dhruv Jagga
%   Project: Source Code - Cloud Your Bus
%   email: d.jagga@tue.nl
%   Date: 10-12-2019;
%   Revised: 06-08-2020


% Absolute Error
j = 1;
for i = 1:length(out.tout)
    if out.Drivetrain.eState.Data(i) == 1 && out.postProcess.counter.Data(i) == 1
        energyTripCurrentCycle1(j) = out.Total.energyTripCurrent.Data(i);
        energyActualCycle1(j)      = out.Total.energyActual.Data(i);
        GPSTripLat(j)              = GPSlat.Data(i);
        GPSTripLon(j)              = GPSlon.Data(i);
        GPSTriphead(j)             = GPShead.Data(i);        
        j = j+1;
        checkflag1(i)       = true;
    else
        checkflag1(i) = false;
        j = 1;
    end
    
end

% Preprocessing the data (Replace the NaN value with 0)
for ii = find(isnan(energyTripCurrentCycle1))
    energyTripCurrentCycle1(ii) = 0;
end

errorCycle1.errorAbs100 = abs(sum(energyTripCurrentCycle1) - sum(energyActualCycle1))./sum(energyActualCycle1) * 100;
errorCycle1.errorAbs90 = abs(sum(energyTripCurrentCycle1(1:(0.9)*end)) - sum(energyActualCycle1(1:(0.9)*end)))./sum(energyActualCycle1(1:(0.9)*end)) * 100;
errorCycle1.errorAbs80 = abs(sum(energyTripCurrentCycle1(1:(0.8)*end)) - sum(energyActualCycle1(1:(0.8)*end)))./sum(energyActualCycle1(1:(0.8)*end)) * 100;
errorCycle1.errorAbs70 = abs(sum(energyTripCurrentCycle1(1:(0.7)*end)) - sum(energyActualCycle1(1:(0.7)*end)))./sum(energyActualCycle1(1:(0.7)*end)) * 100;
errorCycle1.errorAbs60 = abs(sum(energyTripCurrentCycle1(1:(0.6)*end)) - sum(energyActualCycle1(1:(0.6)*end)))./sum(energyActualCycle1(1:(0.6)*end)) * 100;
errorCycle1.errorAbs50 = abs(sum(energyTripCurrentCycle1(1:(0.5)*end)) - sum(energyActualCycle1(1:(0.5)*end)))./sum(energyActualCycle1(1:(0.5)*end)) * 100;
errorCycle1.errorAbs40 = abs(sum(energyTripCurrentCycle1(1:(0.4)*end)) - sum(energyActualCycle1(1:(0.4)*end)))./sum(energyActualCycle1(1:(0.4)*end)) * 100;
errorCycle1.errorAbs30 = abs(sum(energyTripCurrentCycle1(1:(0.3)*end)) - sum(energyActualCycle1(1:(0.3)*end)))./sum(energyActualCycle1(1:(0.3)*end)) * 100;
errorCycle1.errorAbs20 = abs(sum(energyTripCurrentCycle1(1:(0.2)*end)) - sum(energyActualCycle1(1:(0.2)*end)))./sum(energyActualCycle1(1:(0.2)*end)) * 100;
errorCycle1.errorAbs10 = abs(sum(energyTripCurrentCycle1(1:(0.1)*end)) - sum(energyActualCycle1(1:(0.1)*end)))./sum(energyActualCycle1(1:(0.1)*end)) * 100;


% GPS Coordinates at 30% of the trip and 80% of the trip
GPSCoord.GPSlat30 = GPSTripLat(length(GPSTripLat(1:0.3*end)));
GPSCoord.GPSlon30 = GPSTripLon(length(GPSTripLon(1:0.3*end)));
GPSCoord.GPShead30 = GPSTriphead(length(GPSTriphead(1:0.3*end)));

GPSCoord.GPSlat80 = GPSTripLat(length(GPSTripLat(1:0.8*end)));
GPSCoord.GPSlon80 = GPSTripLon(length(GPSTripLon(1:0.8*end)));
GPSCoord.GPShead80 = GPSTriphead(length(GPSTriphead(1:0.8*end)));

