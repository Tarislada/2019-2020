field1 = 'firstname'; value1 = {'Changbum','Seoyoung','Hyeji'};
field2 = 'lastname'; value2 = {'Ko','Gil','Shin'};
field3 = 'birthday'; value3 = {'19930523', '19950318', '19950806'};
member = struct(field1,value1,field2,value2,field3,value3);
file = fopen('teamStats.text','w');
for ii = 1:size(member,2)
    byear = str2double(member(ii).birthday(1:4));
    bmonth = str2double(member(ii).birthday(5:6));
    bdate = str2double(member(ii).birthday(7:8));
    secage = yyyymmdd2secs(member(ii).birthday);
    fprintf(file, '%s\n%s\n%d / %d / %d\n%d\n',...
        member(ii).firstname, member(ii).lastname,...
        byear, bmonth, bdate, secage);
end
fclose(file);



