% yyyymmdd2secs: converts a birthdate of the form "YYYYMMDD" into the
% number of seconds that this person has been alive until now
% 
% INPUT: bdaystring - YYYYMMDD of birthdate in string
% 
% OUTPUT: s - seconds that person has been alive until now
% 
% authors: Ko, Gill, and Shin
% created: 2019/03/19
% modified: 2019/03/


function s = yyyymmdd2secs(bdaystring)

    year = str2double(bdaystring(1:4));
    month = str2double(bdaystring(5:6));
    day = str2double(bdaystring(7:8));
    
    Bday = [year month day];
    
    daysofmonth = [31 28 31 30 31 30 31 31 30 31 30 31];
    
    currenttime = clock;
    secsfromnewyears = (31+28+currenttime(3)-1)*24*60*60 + currenttime(4)*60*60 + currenttime(5)*60 + currenttime(6); % secs from 2019.01.01 until current time
    yearslived = currenttime(1) - (Bday(1)) - 1; % days lived from the year after which they were born until 2018.12.31 midnight
   
%     monthtodays = zeros(12,1);
%     for m = Bday(2)+1:12
%         monthtodays(m) = daysofmonth(m);
%     end

    dayslived = sum(daysofmonth((Bday(2)+1):12)) + (daysofmonth(Bday(2))-Bday(3)) + 1;
    s = secsfromnewyears + yearslived*365*24*60*60 + dayslived*24*60*60; 
   
end
%     etimed = etime(clock,[1994 03 24 0 0 0])
