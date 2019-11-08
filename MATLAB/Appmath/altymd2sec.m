% yyyymmdd2secs: converts a birthdate of the form "YYYYMMDD" into the
% number of seconds that this person has been alive until now
% 
% INPUT: bdaynum - YYYYMMDD of birthdate in string
% 
% OUTPUT: lifesecs - seconds that person has been alive until now
% 
% authors: Ko, Gill, and Shin
% created: 2019/03/19
% modified: 2019/03/21

function lifesecs = altymd2sec(targetdate)
%% Ceconfigure data
targetdate = num2str(targetdate);           %/ turn numbers into string so they can be seperated easily
byear = str2double(targetdate(1:4));  %/ birth year data
bmonth = str2double(targetdate(5:6)); %/ birth month data
bdate = str2double(targetdate(7:8));  %/ birth date data
% Seperating year/month/date data out of the given date

%% Preset values to work with
currenttime = clock;

year = currenttime(1);
month = currenttime(2);
day = currenttime(3);
dayarray = [31 28 31 30 31 30 31 31 30 31 30 31];

monthyears = ((year-1)*12+(month - 1)...         % 2018년 12월 + 2019년 1~2월
-(byear-1)*12+(bmonth-1));           % 94년 +93년 6~12월

yearcount = fix(monthyears/12)*365;
monthcount = sum(dayarray(1:rem(monthyears,12)));
remainingdays = (day - bdate);

sec = currenttime(4:6) * [3600; 60; 1];
% Translate hours/minutes/seconds into seconds

%% Calculate seconds lived
lifesecs = (yearcount+monthcount+remainingdays)*86400 + sec;                                         %/ seconds that were processed earlier

% ex) 2019.03.19 = 2018.14.49 - so you don't get negative values when subtracting 
  
return