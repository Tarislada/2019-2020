[pfy,pffs] = audioread('DoMiSolDo-Pf.mp3');
[vny,vnfs] = audioread('DoMiSolDo-Vn.mp3');
pfperiod = 1/pffs;
pfdur = 0:pfperiod:(length(pfy)*pfperiod)-pfperiod;
vnperiod = 1/vnfs;
vndur = 0:vnperiod:(length(vny)*vnperiod)-vnperiod;
figure(1);
subplot(2,2,1)
plot(pfdur,pfy(:,1)); title('Pf-side1');
subplot(2,2,2)
plot(pfdur,pfy(:,2)); title('Pf-side2');
subplot(2,2,3)
plot(vndur,vny(:,1)); title('Vn-side1');
subplot(2,2,4)
plot(vndur,vny(:,2)); title('Vn-side2')
figure(2);
hold on
for ii = 1:4
    plot(pfdur(1:88201),pfy(1+88200*(ii-1):1+88200*(ii),1))
end
figure(3);
hold on
for ii = 1:4
    plot(pfdur(1:88201),pfy(1+88200*(ii-1):1+88200*(ii),2))
end
vndur = vndur(4411:end);
vny = vny(4411:end,:);
figure(4);
hold on
for ii = 1:4
    plot(vndur(1:92610),vny(1+92610*(ii-1):92610*(ii),1))
end
figure(5);
hold on
for ii = 1:4
    plot(vndur(1:92610),vny(1+92610*(ii-1):92610*(ii),2))
end
