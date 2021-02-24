function [absError,checkflag] = absoluteError(out)

%   Author: Dhruv Jagga
%   Project: Source Code - Cloud Your Bus
%   email: d.jagga@tue.nl
%   Date: 10-12-2019;
%   Revised: 06-08-2020

absError = struct();
checkflag = struct();

errorCycle1 = struct();
errorCycle2 = struct();

checkflag1 = zeros(length(out.tout),1);
checkflag2 = zeros(length(out.tout),1);

j = 1;
k = 1;

for i = 1:length(out.tout)
    if out.Drivetrain.eState.Data(i) == 1 && out.postProcess.counter.Data(i) == 1
        energyTripCurrentCycle1(j) = out.Total.energyTripCurrent.Data(i);
        energyActualCycle1(j)      = out.Total.energyActual.Data(i);
        j = j+1;
        checkflag1(i)       = true;
        
    elseif out.Drivetrain.eState.Data(i) == 1 && out.postProcess.counter.Data(i) == 2
        energyTripCurrentCycle2(k) = out.Total.energyTripCurrent.Data(i);
        energyActualCycle2(k)      = out.Total.energyActual.Data(i);
        k = k+1;
        checkflag2(i)       = true;
    else
        checkflag1(i) = false;
        
        checkflag2(i) = false;
    end
    
end

% Preprocessing the data (Replace the NaN value with 0)
for ii = find(isnan(energyTripCurrentCycle1))
    energyTripCurrentCycle1(ii) = 0;
end

for ij = find(isnan(energyTripCurrentCycle2))
    energyTripCurrentCycle2(ij) = 0;
end

% Calculating Absolute Error (at 50,75,90 and 100% of the total trip)
errorCycle1.errorAbs100 = abs(sum(energyTripCurrentCycle1) - sum(energyActualCycle1))./sum(energyActualCycle1) * 100;
errorCycle1.errorAbs90 = abs(sum(energyTripCurrentCycle1(1:(0.9)*end)) - sum(energyActualCycle1(1:(0.9)*end)))./sum(energyActualCycle1(1:(0.9)*end)) * 100;
errorCycle1.errorAbs75 = abs(sum(energyTripCurrentCycle1(1:(0.75)*end)) - sum(energyActualCycle1(1:(0.75)*end)))./sum(energyActualCycle1(1:(0.75)*end)) * 100;
errorCycle1.errorAbs50 = abs(sum(energyTripCurrentCycle1(1:(0.5)*end)) - sum(energyActualCycle1(1:(0.5)*end)))./sum(energyActualCycle1(1:(0.5)*end)) * 100;

errorCycle2.errorAbs100 = abs(sum(energyTripCurrentCycle2) - sum(energyActualCycle2))./sum(energyActualCycle2) * 100;
errorCycle2.errorAbs90 = abs(sum(energyTripCurrentCycle2(1:(0.9)*end)) - sum(energyActualCycle2(1:(0.9)*end)))./sum(energyActualCycle2(1:(0.9)*end)) * 100;
errorCycle2.errorAbs75 = abs(sum(energyTripCurrentCycle2(1:(0.75)*end)) - sum(energyActualCycle2(1:(0.75)*end)))./sum(energyActualCycle2(1:(0.75)*end)) * 100;
errorCycle2.errorAbs50 = abs(sum(energyTripCurrentCycle2(1:(0.5)*end)) - sum(energyActualCycle2(1:(0.5)*end)))./sum(energyActualCycle2(1:(0.5)*end)) * 100;

absError.errorCycle1 = errorCycle1;
absError.errorCycle2 = errorCycle2;

end

