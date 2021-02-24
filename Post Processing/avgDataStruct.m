function [tripUpdate] = avgDataStruct(out,tripPost)

%   Author: Dhruv Jagga
%   Project: Source Code - Cloud Your Bus
%   email: d.jagga@tue.nl
%   Date: 10-12-2019;
%   Revised: 06-08-2020

% Averaging 'n' number of cycles;
n = 2;

% Operating directory to look for relevant files
opdir = 'C:\Users\20184719\Documents\Final Project - Module 5\Source Code\MATLAB\Cloud Your Bus - Energy Estimation System for EV\Post Processing\DataProfile-Route_401';

% Check the presence of relevent files in the directory
statusDataFile1 = isfile(fullfile(opdir,'ErateProfile401_A_01.mat'));
statusDataFile2 = isfile(fullfile(opdir,'ErateProfile401_A_02.mat'));

% Checking when to activate averaging (Average when the counter is set to desired number)
for z = 1:length(out.tout)
    if out.postProcess.counter.Data(z) == n
        activateAvg = true;
    else
        activateAvg = false;
    end
end

% Load the files if the files are present in the directory
if statusDataFile1 == true
    m1 = load("ErateProfile401_A_01.mat");
end

if statusDataFile2 == true
    m2 = load("ErateProfile401_A_02.mat");
end

switch activateAvg
    case true

        e1 = m1.trip.Erate;
        e2 = m2.trip.Erate;
        
        % Creating averaged Erate Profile
        e = min([length(e1),length(e2)]);
        s = min([m1.trip.s,m2.trip.s]);
        
        ErateAvg = zeros(e,1);
        timeAvg = zeros(e,1);
        
        % Averaging the Erate and corresponding time array
        for y = 1:e
            ErateAvg(y) = (m1.trip.Erate(y)+m2.trip.Erate(y))/n;
            timeAvg(y)  = (m1.trip.time(y)+m2.trip.time(y))/n;
        end
        
        mveh = 19000;
        
        %         ErateAvg = ErateAvg';
        %         timeAvg  = timeAvg';
        
        % Creating time varying Auxiliary Power Profile
        f = min([length(m1.trip.time),length(m2.trip.time)]);
        
        % Extracting the time array from the data structure
        timeAux1 = m1.trip.timeAux;
        timeAux2 = m2.trip.timeAux;
        
        % Extracting the Power array from the data structure
        Paux1 = m1.trip.Paux;
        Paux2 = m2.trip.Paux;
        
        % Interpolating the Power according to the distance-time interpolation
        Paux1 = interp1(timeAux1,Paux1,m1.trip.time);
        Paux2 = interp1(timeAux2,Paux2,m2.trip.time);
        
        % Averaging the Auxiliary Power and corresponding time array
        for j = 1:f
            PauxAvg(j)    = (Paux1(j) + Paux2(j))/n;
            timeAuxAvg(j) = (m1.trip.time(j) + m2.trip.time(j))/n;
        end
        
        PauxAvg     = PauxAvg';
        timeAuxAvg  = timeAuxAvg';
        dt          = [0;diff(timeAuxAvg)];                              % used as weighted sample space
        
        sRoute      = [1:1:s]';                                          % distance vector with sample of '1m' for particular route
        ds          = [0;diff(sRoute)];                                  % used as weighted sample space
        
        EuseDrive  = cumsum(ErateAvg.*ds)*mveh/3.6e6;
        EuseAux    = cumsum(PauxAvg.*dt)/3.6e6;
        
        Etrip_measured = mean([m1.trip.Etrip_measured m2.trip.Etrip_measured]);
        
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
        
        % Checking health status of the stored data
        trip.tripDataHealth = all(~isnan(trip.Erate(:))) && all(~isnan(trip.Paux(:))) && (trip.Etrip_measured ~=0 || ~isnan(trip.Etrip_measured));
        
        tripUpdate = trip;
        
    otherwise
        
        tripUpdate = tripPost.trip0;
end

end

