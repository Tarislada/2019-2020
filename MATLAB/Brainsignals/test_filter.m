[chord_sample1,fs_cs]=audioread('DoMiSolChord.mp3');
h = spectrum.welch;

y1 = filter(dofiltertest,1,chord_sample1);
audiowrite('dofiltertest.wav',y1*15,fs_cs);