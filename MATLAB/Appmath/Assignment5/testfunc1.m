f = @(x1,x2) x1.^2 + x1.*cos(x1.*x2/3) + 3*x2.^2;
g1 = @(x1,x2) 2*x1+cos(x1.*x2/3) - (x1.*x2.*sin(x1.*x2/3))/3;
g2 = @(x1,x2) 6*x2 - (x1.^2.*sin(x1.*x2/3))/3;
xstart = [10 10]'; lambda = 0.03; tolerance = 1e-8; maxiterations = 1000;
[xoptimal,foptimal,niterations]=gradient_descent(f,g1,g2,xstart,lambda,tolerance,maxiterations);
xoptimal
foptimal
niterations
