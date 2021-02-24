function [start,stop,routeState] = routeParameter(routeInfo)

%   Author: Dhruv Jagga
%   Project: Source Code - Cloud Your Bus
%   email: d.jagga@tue.nl
%   Date: 10-12-2019;
%   Revised: 06-08-2020

route401_A = 4011;
route401_B = 4012;

routeState = routeInfo;

switch(routeInfo)
    case route401_A
    
    % Define starting point and ending point of the route using GPS coordinates
    % [The below entered route coordinates is for line 401 moving in between Eindhoven Station and Airport]
    % Direction - Station to Airport
    
    start.lat = 51.4442;                                    % Physically/manually entered GPS latitude
    start.lon = 5.4788;                                     % Physically/manually entered GPS longitude
    start.head = 278;                                       % Physically/manually entered GPS heading
    
    % Allowing variation/deviation with following range [in degrees] around GPS coordinate
    start.latRange = 0.0004;                                % Physically/manually entered
    start.lonRange = 0.0004;                                % Physically/manually entered
    start.headRange= 50;                                    % Physically/manually entered
    
    stop.lat = 51.4567;                                     % Physically/manually entered GPS latitude
    stop.lon = 5.3933;                                      % Physically/manually entered GPS longitude
    stop.head = 309;                                        % Physically/manually entered GPS heading
    
    % Allowing variation/deviation with following range [in degrees] around GPS coordinate
    stop.latRange = 0.0004;                                 % Physically/manually entered
    stop.lonRange = 0.0004;                                 % Physically/manually entered
    stop.headRange= 50;                                     % Physically/manually entered
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    case route401_B

    % Direction - Airport to Station
    
    start.lat = 51.4501;                                    % Physically/manually entered GPS latitude
    start.lon = 5.4027;                                     % Physically/manually entered GPS longitude
    start.head = 154;                                       % Physically/manually entered GPS heading
    
    % Allowing variation/deviation with following range [in degrees] around GPS coordinate
    start.latRange = 0.0003;                                % Physically/manually entered
    start.lonRange = 0.0003;                                % Physically/manually entered
    start.headRange= 5;                                     % Physically/manually entered
    
    stop.lat = 51.4442;                                     % Physically/manually entered GPS latitude
    stop.lon = 5.4788;                                      % Physically/manually entered GPS longitude
    stop.head = 72;                                         % Physically/manually entered GPS heading
    
    % Allowing variation/deviation with following range [in degrees] around GPS coordinate
    stop.latRange = 0.0004;                                 % Physically/manually entered
    stop.lonRange = 0.0004;                                 % Physically/manually entered
    stop.headRange= 5;                                      % Physically/manually entered
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    otherwise
    start.lat = 0;                                          % Physically/manually entered GPS latitude
    start.lon = 0;                                          % Physically/manually entered GPS longitude
    start.head = 0;                                         % Physically/manually entered GPS heading
    
    % Allowing variation/deviation with following range [in degrees] around GPS coordinate
    start.latRange = 0;                                     % Physically/manually entered
    start.lonRange = 0;                                     % Physically/manually entered
    start.headRange= 0;                                     % Physically/manually entered
    
    stop.lat = 0;                                           % Physically/manually entered GPS latitude
    stop.lon = 0;                                           % Physically/manually entered GPS longitude
    stop.head = 0;                                          % Physically/manually entered GPS heading
    
    % Allowing variation/deviation with following range [in degrees] around GPS coordinate
    stop.latRange = 0;                                      % Physically/manually entered
    stop.lonRange = 0;                                      % Physically/manually entered
    stop.headRange= 0;                                      % Physically/manually entered
end
end

