% This script is used to convert the Matlab Figures to the eps and jpeg
% format

%   Author: Dhruv Jagga
%   Project: Source Code - Cloud Your Bus
%   email: d.jagga@tue.nl
%   Date: 10-12-2019;
%   Revised: 06-08-2020

d=dir('*.fig'); % capture everything in the directory with FIG extension
allNames={d.name}; % extract names of all FIG-files
close all; % close any open figures
for i=1:length(allNames)
      open(allNames{i}); % open the FIG-file
      base=strtok(allNames{i},'.'); % chop off the extension (".fig")
      print('-depsc',base); % export to epsc as usual
      close(gcf); % close it ("gcf" returns the handle to the current figure)
end