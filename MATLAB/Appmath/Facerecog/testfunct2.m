accuracy = 505;
inputimage = 'testimage.png';
directory = 'C:\Users\Chang Ko\Documents\MATLAB\Appmath\Final';
excess = 2;
%% Get files & create raw matrix
    filz = dir(directory);
    setsize = length(filz)-2;
    allF = zeros(setsize,...
        length(fread(fopen(filz(3).name))));
    fclose all;
    for fi = 1:setsize-excess
        allF(fi,:) = fread(fopen(filz(fi+2).name));
        fclose all;
    end
    allfaces = allF';
    meanface = mean(allfaces,2);
    allfaces = allfaces - meanface;
    
    covarmat = allfaces'*allfaces;
    [eigvecs eigvals] = eig(covarmat);
    eigvecs = eigvecs(:,end-(accuracy-1):end);
    eigfaces = allfaces * eigvecs;     

    projectedim = zeros(size(eigfaces,2),1);
    setsize = size(eigfaces,2);
    for i = 1 : setsize
        projectedim(:,i) = eigfaces'*allfaces(:,i);
    end

inputimage = imread(inputimage);
temp = inputimage(:,:,1);
[l h] = size(temp);
inputimage2 = reshape(temp',l*h,1);
ms_inputimage = double(inputimage2)-meanface; 
pr_inputimage = eigfaces'*ms_inputimage; 

dist = zeros(size(eigfaces,2),1);
for ii = 1 : setsize
    dist(ii) = (norm(pr_inputimage-projectedim(:,ii)))^2;
end
[min_dist , fileindex] = min(dist);
OutputName = filz(fileindex+2).name;
%OutputName = strcat(int2str(fileindex),'.jpg');