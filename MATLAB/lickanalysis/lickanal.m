function aggfig = lickanal()
%% Load folder containing targetfiles that ends in ...(datalist)
datalist = ["Lick.csv","LOFF.csv","TROF.csv","TRON.csv"];
currfolder = uigetdir();
tmp = cell(1,4);
for ii = 1:length(datalist)
    location = strcat(currfolder, '\*',datalist(ii));
    filename = ls(location);
    tmp{ii} = csvread(strcat(currfolder,'\',filename),1,2);
end
%% assign each data
londata = tmp{1};
loffdata = tmp{2};
trondata = tmp{3};
trofdata = tmp{4};
%% polish data
lickdata = [londata(:,1), loffdata(:,1), loffdata(:,1)-londata(:,1)];
lickdur = lickdata(:,3);
lickoffset = lickdata(:,2);
trdata = [trondata(:,1), trofdata(:,1), trofdata(:,1)-trondata(:,1)];
trialnum = length(trdata);
%% accumulated licking duration
licktime = zeros(1,trialnum);
for ii = 1:trialnum
    licktime(ii) = sum(lickdur(trdata(ii,2)>lickoffset));
end
%% plot it
aggfig = plot([1:trialnum],licktime);