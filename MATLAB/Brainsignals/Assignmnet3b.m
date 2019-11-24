%% Create DoMiSolChord
[pfy,pffs] = audioread('DoMiSolDo-Pf.mp3');
pfy = mean(pfy,2);
for ii = 1:3
    DoMiSol(ii,:) = pfy(1+88200*(ii-1):1+88200*(ii));
end
Chord = sum(DoMiSol,1);
%% Assignment3(a)
figure(1)
Do_x = (0:length(DoMiSol(1,:))-1)*50/length(DoMiSol(1,:));
plot(Do_x,DoMiSol(1,:))
Do_fund = mean(pitch(DoMiSol(1,:)',44100));

figure(2)
Mi_x = (0:length(DoMiSol(2,:))-1)*50/length(DoMiSol(2,:));
plot(Mi_x,DoMiSol(2,:))
Mi_fund = mean(pitch(DoMiSol(2,:)',44100));

figure(3)
Sol_x = (0:length(DoMiSol(3,:))-1)*50/length(DoMiSol(3,:));
plot(Sol_x,DoMiSol(3,:))
Sol_fund = mean(pitch(DoMiSol(3,:)',44100));

figure(4)
Chord_x = (0:length(Chord)-1)*50/length(Chord);
plot(Chord_x,Chord)
Chord_fund = mean(pitch(Chord',44100));

%% Assignment3(b)