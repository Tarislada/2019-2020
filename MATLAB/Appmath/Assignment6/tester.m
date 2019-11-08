A=imread('assignment6.png'); % image size is 200 x 200
B=fftshift(fft2(A));
imshow(B);
pause;
mask=zeros(size(A));
mask(80:120,80:120)=1;
C=mask.*B;
D=ifft2(C);
D=uint8(D);
imshow(D);