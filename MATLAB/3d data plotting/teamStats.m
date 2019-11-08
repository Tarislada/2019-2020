% teamStats: Create a text file that contains firstnames, lastnames,
% birthdays and seconds the members of the team has been alive
% authors: Ko, Gill, and Shin
% created: 2019/03/19
% modified: 2019/03/21

%% Initialize 
clear all;  %/ claer workspace
close all;  %/ close all figures
clc;        %/ clear commandlines

%% Preset the values that will be used to make the structure
field1 = 'firstname'; value1 = {'Changbum','Seoyoung','Hyeji'};     %/1st field and value
field2 = 'lastname'; value2 = {'Ko','Gil','Shin'};                  %/2nd field and value
field3 = 'birthday'; value3 = {'19930523', '19940324', '19960130'}; %/3rd field and value

%% Structure creation
member = struct(field1,value1,field2,value2,field3,value3);         %/create structure with preset values

%% Start writing file
file = fopen('teamStats.text','w');                                 %/ open file with file name 'teamStats' in writing status
for ii = 1:size(member,2)                                           %/ for the numberof the the members, repeat the following
    %% Shorthand for values to be used
    byear = str2double(member(ii).birthday(1:4));                   %/ shorthand for the birth year of the member
    bmonth = str2double(member(ii).birthday(5:6));                  %/ shorthand for the birth month of the member
    bdate = str2double(member(ii).birthday(7:8));                   %/ shorthand for the birth date of the member
    secage = yyyymmdd2secs(member(ii).birthday);                    %/ shorthand for the seconds that member has been alive
    %% Content of the file
    fprintf(file, '%s\n%s\n%d / %d / %d\n%d\n\n',...                %/ write
        member(ii).firstname, member(ii).lastname,...               %/ the firstname, lastname 
        byear, bmonth, bdate, secage);                              %/ birth year, birth month, birth date, seconds that the member has lived
end
%% Close and exit
fclose(file);