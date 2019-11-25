%% Create DoMiSolChord
[pfy,smprate] = audioread('DoMiSolDo-Pf.mp3');
pfy = mean(pfy,2);
for ii = 1:3
    DoMiSol(ii,:) = pfy(1+88200*(ii-1):1+88200*(ii));
end
Chord = sum(DoMiSol,1);
audiowrite('Chord.wav',Chord,44100);
[Chord,crdfs]=audioread('Chord.wav');

%% Assignment3(a)
figure(1)

subplot(2,2,1)
Do_x = (1/smprate)*(1:length(DoMiSol));
plot(Do_x,DoMiSol(1,:),'')
Do_fund = mean(pitch(DoMiSol(1,:)',44100));
txt = ['Fundamental Frequency: ' num2str(Do_fund)];
text(0.8,0.5,txt)
title('Do')
xlabel('Time');
xlim([0 2])
ylabel('Amplitude');

subplot(2,2,2)
Mi_x = (1/smprate)*(1:length(DoMiSol));
plot(Mi_x,DoMiSol(2,:),'')
Mi_fund = mean(pitch(DoMiSol(2,:)',44100));
txt = ['Fundamental Frequency: ' num2str(Mi_fund)];
text(0.8,0.5,txt)
title('Mi')
xlabel('Time');
xlim([0 2])
ylabel('Amplitude');

subplot(2,2,3)
Sol_x = (1/smprate)*(1:length(DoMiSol));
plot(Sol_x,DoMiSol(3,:),'')
Sol_fund = mean(pitch(DoMiSol(3,:)',44100));
txt = ['Fundamental Frequency: ' num2str(Sol_fund)];
text(0.8,0.5,txt)
title('Sol')
xlabel('Time');
xlim([0 2])
ylabel('Amplitude');

subplot(2,2,4)
Chord_x = (1/smprate)*(1:length(DoMiSol));
plot(Chord_x,Chord)
Chord_fund = mean(pitch(Chord,44100));
txt = ['Fundamental Frequency: ' num2str(Chord_fund)];
text(0.8,0.5,txt)
title('Chord')
xlabel('Time');
ylabel('Amplitude');
xlim([0 2])

%% Assignment3(b)
figure(2)
N = length(Chord);
Ts = 2/N;
t = (1/smprate)*(1:N);
frqdm = smprate/N*(-N/2:N/2-1);

Do_ctft = fftshift(Ts*fft(DoMiSol(1,:)));
subplot(4,2,1)
plot(frqdm,abs(Do_ctft))
title('Magitude Spectrum: Do')
xlabel('Frequency')
ylabel('Magnitude');
[~,fundf] = max(Do_ctft);
Do_fund=frqdm(fundf);
txt = ['Fundamental Frequency:' num2str(Do_fund)];
text(4500,0.03,txt)
subplot(4,2,2)
plot(frqdm,angle(Do_ctft))
title('Phase Spectrum: Do')
xlabel('Frequency')
ylabel('Phase');


Mi_ctft = fftshift(Ts*fft(DoMiSol(2,:)));
subplot(4,2,3)
plot(frqdm,abs(Mi_ctft))
title('Magnitude spectrum: Mi')
xlabel('Frequency')
ylabel('Magnitude');
[~,fundf] = max(Mi_ctft);
Mi_fund=frqdm(fundf);
txt = ['Fundamental Frequency:' num2str(Mi_fund)];
text(4500,0.03,txt)
subplot(4,2,4)
plot(frqdm,angle(Mi_ctft))
title('Phase spectrum: Mi')
xlabel('Frequency')
ylabel('Phase');


Sol_ctft= fftshift(Ts*fft(DoMiSol(3,:)));
subplot(4,2,5)
plot(frqdm,abs(Sol_ctft))
title('Magnitude spectrum: Sol')
xlabel('Frequency')
ylabel('Magnitude');
[~,fundf] = max(Sol_ctft);
Sol_fund=frqdm(fundf);
txt = ['Fundamental Frequency:' num2str(Sol_fund)];
text(4500,0.03,txt)
subplot(4,2,6)
plot(frqdm,angle(Sol_ctft))
title('Phase spectrum: Sol')
xlabel('Frequency')
ylabel('Phase');


Chord_ctft = fftshift(Ts*fft(Chord));
subplot(4,2,7)
plot(frqdm,abs(Chord_ctft))
title('Magnitude spectrum: Chord')
xlabel('Frequency')
ylabel('Magnitude');
[~,fundf] = max(Chord_ctft);
Chord_fund=frqdm(fundf);
txt = ['Fundamental Frequency:' num2str(Chord_fund)];
text(4500,0.03,txt)
subplot(4,2,8)
plot(frqdm,angle(Chord_ctft))
title('Phase spectrum: Chord')
xlabel('Frequency')
ylabel('Phase');