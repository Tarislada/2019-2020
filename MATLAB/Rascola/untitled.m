% function rwmodel(trialn,actualprob,saliency,learnrate)

trialn = 1000;
currtrial = 0;
actualprob = 1;
initialval = 0;

saliency = .5;
learnrate = .5;
Val = initialval;
hold on
while Val<actualprob && currtrial<trialn
    currtrial = currtrial+1;
    Val = Val+saliency*learnrate*(actualprob-Val);
    plot(trialn,Val);
    drawnow
end
