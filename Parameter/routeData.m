function trip = routeData(routeInfo)

%   Author: Dhruv Jagga
%   Project: Source Code - Cloud Your Bus
%   email: d.jagga@tue.nl
%   Date: 10-12-2019;
%   Revised: 06-08-2020

% Available routes

route401_A = 4011;
route401_B = 4012;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Creating an Empty trip data structure

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Operating directory to look for relevant files
opdir = 'C:\Users\20184719\Documents\Final Project - Module 5\Source Code\MATLAB\Cloud Your Bus - Energy Estimation System for EV\Parameter\UpdatedProfile';

% Check the presence of relevent files in the directory
statusUpdatedDataFile = isfile(fullfile(opdir,'UpdatedErateProfile401_A.mat'));

% Load the relevent data set

switch(routeInfo)
    case route401_A
        if statusUpdatedDataFile == true
            trip = load('UpdatedErateProfile401_A.mat');
        else
            trip = load('ErateAvgRoute401_A.mat');
        end
    case route401_B
        trip = load('ErateAvgRoute401_B.mat');
    otherwise
        trip = trip0;
end

end

