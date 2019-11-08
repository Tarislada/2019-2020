testrange = -pi:0.1:pi;
d=derive(@sin,testrange,0.1);
actual = cos(testrange);
plot(testrange,d,'g');
hold on;
plot(testrange,actual,'r');

h = zeros(1,11);
err = zeros(1,10);
for ii = 1:10
    h(1) = 1;
    hold on;
    d=derive(@sin,testrange,h(ii));
    err(ii) = (sum((actual-d).^2))^0.5;
    h(ii+1) = h(ii)/2;
end
figure;
loglog(h(1:10),err,'ro-');  %[0.00195312500000000]
grid;

figure(3);
xrange = 1:0.1:10;
f1 = @(x) log(x);       % 1/x
d1 = derive(f1,xrange,0.00195312500000000);
actual1 = @(x) 1./x;
plot(xrange,d1);
hold on;
plot(xrange,actual1(xrange));

figure(4);
xrange = 1:0.1:10;
f2 = @(x) x.^.5;         % (x^-.5)/2
d2 = derive(f2,xrange,0.00195312500000000);
actual2 = @(x) (x.^-.5)./2;
plot(xrange,d2);
hold on;
plot(xrange,actual2(xrange));

figure(5);
xrange = 0:0.1:pi;
f3 = @(x) sin(x)/(x+5); % xcos(x)+5cos(x)-sin(x) / (x+5)^2
d3 = derive(f3,xrange,0.00195312500000000);
actual3 = @(x) ((x+5).*cos(x) - sin(x))./((x+5).^2);
plot(xrange,d3);
hold on;
plot(xrange,actual3(xrange));
