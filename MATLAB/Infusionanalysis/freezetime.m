function [cstime, csfreeze, itifreeze] = freezetime()
%% Load and polish
[name, path] = uigetfile('*.csv');
data = csvread(strcat(path, name),1);
data(:,7) = [0;diff(data(:,1))];
c = find(data(:,4)==1);
data(1:c(1)-2,:) = [];
data(:,5) = data(:,3) & data(:,4);        % csfr
data(:,6) = data(:,3) & (data(:,4)-1)*-1; % itifr
%% csfreeze
csind = find(diff(data(:,4)~=0))+1;                   % csonsetoffset detector
cstime = data(csind);                                 % timestamp of onset offset
trialnum = length(cstime)/2;                                % collect # of CS trials

csind = reshape(csind,2,trialnum);
cstime = reshape(cstime,2,trialnum);                        % reshape to look better

for ii = 1:trialnum
    period = data(csind(1,ii):csind(2,ii),[5 7]);
    csfreeze(ii) = sum(period(:,1).*period(:,2));
end
%% itifreeze
itiind = [csind(:); length(data)];
itiind(1) = [];
itiind = reshape(itiind,2,trialnum);
for ii = 1:trialnum
    itiper = data(itiind(1,ii):itiind(2,ii),[6 7]);
    itifreeze(ii) = sum(itiper(:,1).*itiper(:,2));
end
end
