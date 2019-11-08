close all;
clc
filz = dir('*');
allF = zeros(length(filz)-3,...
    length(fread(fopen(filz(3).name))));
fclose all;
for fi = 1:length(filz)-5
    allF(fi,:) = fread(fopen(filz(fi+2).name));
    fclose all;
end
mask = false(128);
mask(40:100,20:120) = true;
allfaces = allF(:,mask);%/
n = size(allfaces,1);
tmp = ones(n,1);
Q_M = eye(n) - (1/n)*(tmp*tmp');
allfaces = Q_M*allfaces;
covarmat = cov(allfaces);
[eigvecs,eigvals] = eig(covarmat);
eigvecs = fliplr(eigvecs);
nPCs = 50;
scores = allfaces(1,:)*eigvecs(:,1:nPCs);
imagesc(reshape(scores*eigvecs(:,1:nPCs)',61,101)'), colormap gray;