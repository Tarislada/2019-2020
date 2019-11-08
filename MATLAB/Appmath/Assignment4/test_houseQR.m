close all;
clear all;
clc;
funded = [373 3772 10746 16903 19271 22233 22036 18823];   
unfunded = [501 4825 12516 22749 24823 44325 54831 39251]; 
timepoint = [1 2 3 4 5 6 7 8];                             
bar(timepoint+2008,[funded;unfunded]');                    
hold on;                                                   
unfunded = unfunded';
funded = funded';
unfundegree = 5;                                                
fundegree = 4;                                             


vandermat = fliplr(vander(timepoint));                     
unfunvandermat = vandermat(:,1:unfundegree+1);
unfunvandermat(:,end) = unfunded;
A = unfunvandermat;
[m,n] = size(A);
R = A;

for ii = 1:n-1
    x = R(ii:m,ii);
    e = zeros(length(x),1);
    e(1) = 1;
    u = sign(x(1))*norm(x)*e + x;
    u = u./norm(u);
    
    R(ii:m, ii:n) = R(ii:m, ii:n) - 2*u*u'*R(ii:m, ii:n);
    U(ii:m,ii) = u;
end
    
unfundsol = R(:,end);                                
unfundmat = R(:,1:end-1);                            % Separate matrix and results to solve system
unfundval = unfundmat \ unfundsol;                          % Solve
unfundval = fliplr(unfundval');   

plot(timepoint+2008,polyval(unfundval,timepoint),'r');      % plot best fit model for unfunded projects

plot(2020,polyval(unfundval,12),'ro');                      % plot 2020 estimation for unfunded projects

