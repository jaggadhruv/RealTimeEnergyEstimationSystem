function [idx_Start,idx_Stop] = idxStartStop(time,latitude,longitude,heading,start,stop)

%   Author: Dhruv Jagga
%   Project: Source Code - Cloud Your Bus
%   email: d.jagga@tue.nl
%   Date: 10-12-2019;
%   Revised: 06-08-2020

% Only to be used for analysis purpose and not for actual simulation

% Initialize flags
xStart = false;                                         % Indicate the route has started
xStop = true;                                           % Indicate the route has stopped

% Initializing the variables
routeStart = false;                                     % vector which checks if current GPS coordinate is closer to start coordinate
routeStop = false;                                      % vector which checks if current GPS coordinate is closer to stop coordinate
counterStart = 0;                                       % Count number of times the route has started
counterStop = 0;                                        % Count number of times the route has stopped

for i = 2:length(time)

    % Compare the current GPS coordinate and heading with the Fixed starting point GPS coordinate
    if abs(latitude(i) - start.lat) < start.latRange && abs(longitude(i) - start.lon) < start.lonRange && abs(heading(i) - start.head) < start.headRange
        routeStart(i) = true;
        routeStop(i) = false;
        
                if (routeStart(i-1) + routeStart(i) == 2) && xStop == true              % check if 2 consecutive points are closer to start coordinate
                    xStart = true;                                                      % then raise the flag that route has started
                    xStop = false;
                    idxStart_vec(i) = xStart;
                    idx_Start = find(idxStart_vec ~= 0);
                    
                        if xStart == true
                            counterStart = counterStart + 1;                            % update the route counter
                            counterStop = counterStop;
                        end
                end
                     
    % Compare the current GPS coordinate and heading with the Fixed stopping point GPS coordinate    
    elseif abs(latitude(i) - stop.lat) < stop.latRange && abs(longitude(i) - stop.lon) < stop.lonRange && abs(heading(i) - stop.head) < stop.headRange
        routeStart(i) = false;
        routeStop(i) = true;
        
                if (routeStop(i-1) + routeStop(i) == 2) && xStart == true               % check if 2 consecutive points are closer to stop coordinate
                    xStart = false;                                                     % then raise the flag that route has stopped
                    xStop = true;
                    idxStop_vec(i) = xStop;
                    idx_Stop  = find(idxStop_vec ~= 0);

                    if xStop == true
                        counterStop = counterStop + 1;                                  % update the route counter
                        counterStart = counterStart;
                    end
                end
        
    else
        % No changes are made if both the conditions are not met
        routeStart(i) = false;
        routeStop(i) = false;
        counterStart = counterStart;
        counterStop = counterStop;
    end
    
   
end

end

