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
    allfaces = allF;
%% Mean-center raw matrix
    mask = false(128);
    mask(40:100,20:120) = true;
    allfaces = allF(:,mask);
    meanface = mean(allfaces);
    allfaces = allfaces-meanface;
%% Calculate mean & eigenfaces
    covarmat = cov(allfaces');
    [eigvecs,eigvals] = eig(covarmat);
    eigvecs = fliplr(eigvecs);
    eigfaces = allfaces'*eigvecs(:,1:accuracy);
%% Project image vectors in new dimensions
    projectedim = zeros(1,accuracy);
    setsize2 = size(allfaces,1);
    for i = 1:setsize2
        projectedim(i,:) = allfaces(i,:)*eigvecs(:,1:accuracy);
    end
%% Extract PCA feature of test image
    inputimage = imread(inputimage);
    inputimage = inputimage(:,:,1);
    [l, h] = size(inputimage);
    inputimage = reshape(inputimage,1,l*h);
    inputimage = inputimage(:,mask);
    inputimage = double(inputimage) - meanface;
    pr_inputimage = inputimage*eigvecs(:,1:accuracy);
%% Compare distance
    d = zeros(1,size(allfaces,1));
    for ii = 1:size(allfaces,1)
        d(ii) = (norm(pr_inputimage-projectedim(ii,:)))^2; 
    end
    [dmin, recognized_index] = min(d);
    picname = strcat(int2str(recognized_index+1222),'.png');
    proximity = dmin;

picname
proximity