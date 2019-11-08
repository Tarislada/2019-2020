function [CStime, csfreeze, itifreeze]= clacond(targetfile)
% need: duration of freezing during CS and ITI
% need: use error function for broken CS or too short iti

% CStime = CS Onset/offset 
% csfreeze = freezing counts of each training sessions
% freezesum = total freezing in each traininig sessions

%% when CS is on, 
csonoff = diff(targetfile(:,4));                            % csonsetoffset detector
temp = find(csonoff~=0);                                    % find onset offset 
temp(2:2:end) = temp(2:2:end)+1;
CStime = targetfile(temp);                                  % timestamp of onset offset
targetfile(1:temp(1)-1,:) = [];                             % trim original data for habituation
csseries = targetfile(:,4);                                 % save csserial for future use
trialnum = length(CStime)/2;                                % collect # of CS trials
CStime = reshape(CStime,2,trialnum);                        % reshape to look better
accuracy = 1.5;                                             % temporal difference that will be considered as a different account
%{
for ii = 1:length(CStime)
    if CStime(ii+1) - CStime(ii) <= error
        error('Broken CS / Too short ITI')
    end
end
%}
%% Count the number of freezing accounts
freezeraw = targetfile(:,3);                            % raw data of freezing accounts
%% find freezing during CS
csfr = freezeraw & csseries;                                % freezing accounts when cs is on
%csfrtime = targetfile(csfr==1);                             % timestamp of cs & freeze

csfronoff = diff(csfr);
tmp = find(csfronoff~=0);
csfrtime = targetfile(tmp);
%이제 이 바로 위에 걸 CStime이랑 비교 후 빼서 더하기 ㅇㅋ
temp = [];                                                  % temporary variable for calculation of cs freezing duration
csfreeze = zeros(1,trialnum);                                      % preset size of cs freezing
for ii = 1:trialnum-1
    temp = csfrtime(CStime(2*ii-1)<=csfrtime & csfrtime<CStime(2*ii+1));      
    if temp ~=0
        temp2=diff(temp);                                   % duration of each time frame that fits the condition - iith CS, freeze
        csfreeze(ii) = sum(temp2(1:2:end));                 % sum of those duration - consider it a different account of freezing if time difference >1
    end
end                                                         % when cs is on, duration of freezing = beginning of freezing - end of freezing
temp = csfrtime(CStime(2*trialnum-1)<=csfrtime & csfrtime<=CStime(end));
temp2 = diff(temp);
csfreeze(trialnum) = sum(temp2(1:2:end));
%% iti freezing
itifr = freezeraw & (csseries-1)*-1;                        % freezing acocunts when iti
%itifrtime = targetfile(itifr==1);                           % timestamp of iti & freeze

itifronoff = diff(itifr);
tmp = find(itifronoff~=0);
itifrtime = targetfile(tmp);
temp = [];                                                 % temporary variable for calcuation of iti freezing duration
itifreeze = zeros(1,trialnum);                                     % preset size of iti freezing
for ii = 1:trialnum-1
    temp = itifrtime(CStime(2*ii)<=itifrtime & itifrtime<CStime(2*ii+2));
    if temp ~=0
       temp2=diff(temp);
       itifreeze(ii) = sum(temp2(1:2:end));
    end
end                                                         % iti freezing duration calcuations until second to last time
temp = itifrtime(CStime(2*trialnum)<=itifrtime & itifrtime<=itifrtime(end));    % final iti freezing duration
if rem(temp,2) ~=0
    temp = [temp;targetfile(end,1)];
end
temp2 = diff(temp);
itifreeze(trialnum) = sum(temp2(1:2:end));
end