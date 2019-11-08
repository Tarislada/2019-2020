%% initialize
close all;
filtersize = 40;
inputimage = 'assignment6.png';
numclick = 1;
workimage1 = rgb2gray(imread(inputimage));
%% settings
mask = ones(size(workimage1));
midpoint = size(workimage1)/2;
%% display grayscaled image
figure(1);
imshow(workimage1)
%% display fft magnitude spectrum
workimage2 = fftshift(fft2(workimage1));

fftimage = fftshift(log(abs(fft2(workimage1))));
figure(2);
colormap gray;
imagesc(fftimage);
%% get input for masking
for i = 1 : 5
[yfilt, xfilt] = ginput(numclick);
hold on;

scatter(yfilt, xfilt, 'r+');
drawnow;

symx = abs(midpoint(1)-xfilt);
symy = abs(midpoint(2)-yfilt);
mask(round(xfilt-filtersize/2) : round(xfilt+filtersize/2),...
     round(yfilt-filtersize/2) : round(yfilt+filtersize/2)) = 0;
mask(round(midpoint(1)+symx-filtersize/2) : round(midpoint(1)+symx+filtersize/2),...
     round(midpoint(2)+symy-filtersize/2) : round(midpoint(2)+symy+filtersize/2)) = 0;
end
%% apply mask and show me
figure(3)
%/ 마스크 범위가 이미지 범위를 넘지r 않도록 if~~
%/ 마스크를 어떻게 해야 적용시킬수 있지? 마스크란 뭐지? 난 누구고 여긴어디고 난 시발 뭘하고있는거지?
%/ TTlqkfTlqkfTLqkfTlqkfTlqkfTlqkf

workimage3 = mask.* workimage2;

%/ ????뭔가 마스킹이 안되고 있음
finalimage = abs(ifft2(ifftshift(workimage3)));

%finalimage = ifftshift(abs(ifft2(workimage3)));
%/ 다시 정렬은 안해줬는데 이미지가 그대로네?!?!??!?!?!?!??!
figure(4);
imshow(uint8(finalimage));
