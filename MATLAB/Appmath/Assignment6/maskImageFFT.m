function im = maskImageFFT(inputimage,numclick,filtersize)
close all;
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

for i = 1 : numclick
[yfilt, xfilt] = ginput(1);
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

workimage3 = mask.* workimage2;


finalimage = abs(ifft2(ifftshift(workimage3)));

finalg = figure(3);
imshow(uint8(finalimage));
%% Save output
inputimage = inputimage(1:strfind(inputimage,'.')-1);
file_name = sprintf('%s_cleaned_%d_%d',inputimage,filtersize,numclick);
saveas(finalg,file_name,'png')
end
