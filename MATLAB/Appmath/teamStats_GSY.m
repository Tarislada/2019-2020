
clear all
close all
clc


member = struct('firstname',{'Changbum','Soyoung','Haeji'},'lastname',{'Ko','Gill','Shin'},'birthday',{'19930523','19940324','19960130'});

for i = 1:length(member)
    ageinsecs(1,i) = yyyymmdd2secs(member(i).birthday);
    Bday(i,:) = [member(i).birthday(1:4) '/' member(i).birthday(5:6) '/' member(i).birthday(7:8)];
end


file = fopen('teamStats.txt','w');
for k = 1:length(member)
    fprintf(file, '%s\n',member(k).firstname);
    fprintf(file, '%s\n',member(k).lastname);
    fprintf(file, '%s\n',Bday(k,:));
    fprintf(file, '%s\n\n',ageinsecs(1,k));
end
fclose(file);

