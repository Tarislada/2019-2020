%%%% Applied Mathematics Final project

% this function recognize images from a given directory as the dataset
% 
% Inputs : inputimage - name of the image to be recognized. 
%          directory - the place where dataset is stored
%          excess - excess file in the directory, just in case
%                 - if there are nothing else, input 0
%          accuracy - how many pca scores to use to recognize face
%                   - there is a trade-off between accuracy and speed
%                   - higer the number, the more accurate and slow the
%                   fucntion is. maximum is the # of used images, minimum
%                   is 1.
% Outputs : picname - the file name of the recognized image among dataset
%           proximity - how close the target image actually is to the
%                      recognized image
% authors: Changbum Ko, Soyoung Gill and Haeji Shin
% created: 2019/05/23


function [picname,proximity] = Recognize(inputimage, directory, excess,accuracy)
%% Get files & create raw matrix
    filz = dir(directory);                          % Get all file lists in the directory
    setsize = length(filz)-2;                       % # of all files in the directory 
    allF = zeros(setsize,...
        length(fread(fopen(filz(3).name))));        % create empty matrix to store image
    fclose all;                                     % close opened file 
    for fi = 1:setsize-excess                       % merge all imagevectors into matrix
        allF(fi,:) = fread(fopen(filz(fi+2).name));
        fclose all;
    end
    allfaces = allF';                               
%% Mean-center raw matrix
    meanface = mean(allfaces,2);                    % calculate the meanface 
    allfaces = allfaces - meanface;                 % mean-center allfaces matrix
%% Calculate eigenfaces
    covarmat = allfaces'*allfaces;                  % peudo-covariance matrix for calculation
    [eigvecs eigvals] = eig(covarmat);              % attain eigenvectors and values
    eigvecs = eigvecs(:,end-(accuracy-1):end);      % trim eigenvectors to reasonable level 
    eigfaces = allfaces * eigvecs;                  % calculate eigenfaces
%% Project image vectors in new dimensions
    projectedim = zeros(size(eigfaces,2),1);        % create empty matrix to store all images projected onto eignspace
    setsize = size(eigfaces,2);                     
    for i = 1 : setsize
        projectedim(:,i) = eigfaces'*allfaces(:,i); % create matrix storing all images projected onto eignspace
    end
%% Extract PCA feature of test image & project
    inputimage = imread(inputimage);                % get target image
    temp = inputimage(:,:,1);                       % get grayscale image
    [l h] = size(temp);                             % size of the image
    inputimage2 = reshape(temp',l*h,1);             % reshape image into vector to work with
    ms_inputimage = double(inputimage2)-meanface;   % mean-center target image
    pr_inputimage = eigfaces'*ms_inputimage;        % project mean-centered target image onto eigenspace
%% Compare distance
    dist = zeros(size(eigfaces,2),1);               % create empthy matrix to measure distance
    for ii = 1 : setsize
        dist(ii) = (norm(pr_inputimage-projectedim(:,ii)))^2;   % measure distance in eigenspace between target image and dataset
    end
    [proximity , fileindex] = min(dist);            % get the most close image and how close it is
    picname = filz(fileindex+2).name;               % print its file name
end
