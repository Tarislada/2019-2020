[chord_sample1,fs_cs]=audioread('DoMiSolChord.mp3');
h = spectrum.welch;

y1 = filter(dofilttest,1,chord_sample1);
audiowrite('dofilttest.wav',y1*20,fs_cs);