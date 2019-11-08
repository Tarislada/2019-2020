%% CTFT
[pfy,pffs] = audioread('DoMiSolDo-Pf.mp3');
[vny,vnfs] = audioread('DoMiSolDo-Vn.mp3');
pf1 = fft(pfy(:,1));
pf2 = fft(pfy(:,2));
vn1 = fft(vny(:,1));
vn2 = fft(vny(:,2));
fpf1 = (0:length(pf1)-1)*50/length(pf1);
fpf2 = (0:length(pf2)-1)*50/length(pf2);
fvn1 = (0:length(vn1)-1)*50/length(vn1);
fvn2 = (0:length(vn2)-1)*50/length(vn2);
figure(1)
subplot(4,1,1)
plot(fpf1,abs(pf1))
title('PF1 MAgnitude')

subplot(4,1,2)
plot(fpf2,abs(pf2))
title('PF2 MAgnitude')

subplot(4,1,3)
plot(fvn1,abs(vn1))
title('VN1 MAgnitude')

subplot(4,1,4)
plot(fvn2,abs(vn2))
title('VN2 MAgnitude')

%% DFT
N = 2^15;
pf1df = abs(fft(pf1,N));
pff1 = (0:length(pf1df)-1)*100/length(pf1df);

pf2df = abs(fft(pf2,N));
pff2 = (0:length(pf2df)-1)*100/length(pf2df);

vn1df = abs(fft(vn1,N));
vnf1 = (0:length(vn1df)-1)*100/length(vn1df);

vn2df = abs(fft(vn2,N));
vnf2 = (0:length(vn2df)-1)*100/length(vn2df);

figure(2)
subplot(4,1,1)
plot(pff1,pf1df)
title('PF1 magnitude')
subplot(4,1,2)
plot(pff2,pf2df)
title('PF2 magnitude')
subplot(4,1,3)
plot(vnf1,vn1df)
title('VN1 magnitude')
subplot(4,1,4)
plot(vnf2,vn2df)
title('vn2 magnitude')