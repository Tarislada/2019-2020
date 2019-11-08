x1 = @(t) exp(t)*sin(20*pi*t) + exp(-t/2)*sin(19*pi*t);
x2 = @(t) rectangularPulse(t)*cos(20*pi*t);
c1 = @(t) x2(x1(t));
fplot(c1,[-2.5 3])