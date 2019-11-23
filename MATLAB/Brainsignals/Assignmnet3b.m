%% Create DoMiSolChord
[pfy,pffs] = audioread('DoMiSolDo-Pf.mp3');
pfy = mean(pfy,2);
for ii = 1:3
    Domi(ii,:) = pfy(1+88200*(ii-1):1+88200*(ii));
end
DoMiSol = sum(Domi,1);
%% 

pf1 = fftshift(abs(fft(DoMiSol)));
fpf1 = (0:length(pf1)-1)*50/length(pf1);
