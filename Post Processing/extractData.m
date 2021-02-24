function [Erate,time,s,Paux,energyTrip,checkflag] = extractData(out)

%   Author: Dhruv Jagga
%   Project: Source Code - Cloud Your Bus
%   email: d.jagga@tue.nl
%   Date: 10-12-2019;
%   Revised: 06-08-2020

Erate     = struct();
time      = struct();
s         = struct();
Paux      = struct();
energyTrip= struct();
checkflag = struct();

checkflag1 = zeros(length(out.tout),1);
checkflag2 = zeros(length(out.tout),1);

j = 1;
k = 1;

for i = 1:length(out.tout)
    
    if out.Drivetrain.eState.Data(i) == 1 && out.postProcess.counter.Data(i) == 1
        checkflag1(i)       = true;
        ErateCycle1(j)      = out.postProcess.Erate.Data(i);
        timeCycle1(j)       = out.Drivetrain.timeRoute.Data(i);
        sCycle1(j)          = out.Drivetrain.sRoute.Data(i);
        PauxCycle1(j)       = out.Auxiliary.PauxRoute.Data(i);
        energyTripCycle1(j) = out.Total.energyActual.Data(i);
        j = j+1;
    elseif out.Drivetrain.eState.Data(i) == 1 && out.postProcess.counter.Data(i) == 2
        checkflag2(i)       = true;
        ErateCycle2(k)      = out.postProcess.Erate.Data(i);
        timeCycle2(k)       = out.Drivetrain.timeRoute.Data(i);
        sCycle2(k)          = out.Drivetrain.sRoute.Data(i);
        PauxCycle2(k)       = out.Auxiliary.PauxRoute.Data(i);
        energyTripCycle2(k) = out.Total.energyActual.Data(i);
        k = k+1;
%         if out.postProcess.stopRoute == 1
%             k = 1;
%         end
    else
        checkflag1(i) = false;
        checkflag2(i) = false;
        
        j = 1; k = 1;
    end
end


% Preprocessing the Erate data (Replace the NaN value with the last recorded value)
for ii = find(isnan(ErateCycle1))
    ErateCycle1(ii) = ErateCycle1(ii-1);
end

for ij = find(isnan(ErateCycle2))
    ErateCycle2(ij) = ErateCycle2(ij-1);
end


% Storing Data into the data structure
checkflag.checkflag1 = checkflag1;
checkflag.checkflag2 = checkflag2;

Erate.ErateCycle1 = ErateCycle1;
Erate.ErateCycle2 = ErateCycle2;

time.timeCycle1 = timeCycle1;
time.timeCycle2 = timeCycle2;

s.sCycle1 = sCycle1;
s.sCycle2 = sCycle2;

Paux.PauxCycle1 = PauxCycle1;
Paux.PauxCycle2 = PauxCycle2;

energyTrip.energyTripCycle1 = energyTripCycle1;
energyTrip.energyTripCycle2 = energyTripCycle2;


end

