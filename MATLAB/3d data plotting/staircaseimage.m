%{
1. data 형식은 두가지로 나뉨: color & depth
2. Color 를 xy축에 플로팅하고, depth를 z축에 plotting하면 3d image를 얻을 수 있으나 경사면 때문에 distinctive 하지 않아 알아보기가 어려움
3. 따라서, depth data를 뭉뚱그리는 작업이 필요
4. 3의 결과물을 가지고 다시 colordata와 플로팅하여 일종의 '종이랜턴'같은 결과물을 생성
5. 이후, 종이랜턴의 각각 layer를 subplot하여 볼 수 있도록 arrange
  * layer간격은 별도 함수로 설정해야 나중에 편하다 1000sounds like a good #
  * layer의 대표값은 평균값으로
%}
load('color_depth.mat');
%% Data reconfig
frameNum2Use = 1;
cdat = colorFrameData(:,:,:,frameNum2Use);
ddat = depthFrameData(:,:,:,frameNum2Use);
cdat_resized = imresize(cdat,size(ddat));

%% Smoothout Depthdata & store in layers
layerdepth = 1000;                          % number range
n = (layerdepth * ceil(max(max(ddat))/layerdepth)) / layerdepth; % # of layers
n = double(n);                              % n needs to be double                      
%%layerdata = zeros([size(ddat) n]);          
newddat = ddat;                             % to conserve original data
meanstring = zeros(1,n);

for ii = 1:n
   range = layerdepth*(ii-1)<=newddat & newddat<layerdepth*ii;
   meanstring(ii) = mean(newddat(range));
   newddat(range) = meanstring(ii);
   
   %layerdata(:,:,ii) = mean(newddat(range));
        % assign the mean of the values of layers to matrix
   %newddat(range) = layerdata(:,:,ii); 
        % tear DDAT apart into layers
end
figure(1);
clf;
warp(max(max(max(newddat)))-newddat,cdat_resized);   %draw whole image


% meanstring의 각 값(총 n개)을 가지는 newddat의 index를 찾아서, (=allocationindex)
% cdat_resized에서 해당 index의 값을 보존하고 나머지를 날림 
% 문제: 해당 index부분의 r값만 보전되고, 나머지는 보전되지 않음. 즉, G값과 B값이 없는 검은 화면+ 해당부분은 붉은 화면
% allocationindex의 차원문제인가? = 확인결과, allocationindex의 값이 전체 cdat_resize의 값보다
% 터무니없이 부족함. why? 터무니 없이 부족한 것이 아니라, 3차원짜리가 아닌 2차원 따리만 측정한 index인것!
% newcdat의 (::2)와 (::3)에서도 값 보전이 이루어지면 됨!
% 해당 ddat값과 cdat값을 함께 warp
%% cdat rearrange
figure(2);
meanstring = round(meanstring);
meanstring(isnan(meanstring)) = 0;
%이렇게 안하면 숫자가 안맞고, nan때문에 n과 평균의 갯수가 일치하지 않음
zeromatrix = 255*ones(size(cdat_resized));
newcdat1 = zeromatrix(:,:,1);
newcdat2 = zeromatrix(:,:,2);
newcdat3 = zeromatrix(:,:,3);
cdat_resized1 = cdat_resized(:,:,1);
cdat_resized2 = cdat_resized(:,:,2);
cdat_resized3 = cdat_resized(:,:,3);
drawingddat = zeros(size(ddat));
for ii = 1:n
    allocationindex = find(newddat==meanstring(ii));
    newcdat1(allocationindex) = cdat_resized(allocationindex);
    newcdat2(allocationindex) = cdat_resized(allocationindex);
    newcdat3(allocationindex) = cdat_resized(allocationindex);
    newcdat = cat(3,newcdat1,newcdat2,newcdat3);
    drawingddat(allocationindex) = newddat(allocationindex);
    subplot(2,n/2,ii);
    warp(drawingddat,newcdat);

end



%{
newcdat = zeros([size(cdat_resized)]);  % create newcdat that will be used to draw layerd image
index = find(layerdata~=0);             % index info of where layerdata ~= 0
newcdat(find(layerdata~=0)) = cdat_resized(find(layerdata~=0));   % assign value of cdat in the position where layerdata is not 0


layerdata 


%% Print by layer

figure(2)
for ii = 1:n
subplot(1,n,ii);
warp(max(max(max(layerdata(:,:,ii))))-layerdata(:,:,ii),newcdat);
end
%}