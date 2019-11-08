%% Applied Mathematics Assignment 4
% Curve fitting 2
% This code fits & estimates 2020 data for the number of kickstarter funded/unfunded projects in a least-squares sense with polynomials
% of degrees 2 through 7 using the Vandermonde matrix
% Authors : Changbum Ko, Soyoung Gill and Haeji Shin
% Created : 2019/05/12
%% Basic settings
close all;
clear all;
clc;                                                        % initialize variables, windows, and command line
funded = [373 3772 10746 16903 19271 22233 22036 18823];    % # of funded project data points 1
unfunded = [501 4825 12516 22749 24823 44325 54831 39251];  % # of unfunded project data points 2
timepoint = [1 2 3 4 5 6 7 8];                              % # of time points
bar(timepoint+2008,[funded;unfunded]');                     % plot data points 1&2 according to timepoints
hold on;                                                    % for future plotting, hold on
unfundegree = 3;                                            % set unfunded degree    
fundegree = 4;                                              % set funded degree

%% Creating Vandermonde matrix
vandermat = fliplr(vander(timepoint));                      % the whole Vandermonde matrix
                     
%% Using Householder QR factorization for unfunded
unfunvandermat = vandermat(:,1:unfundegree+1);              % Calling & cutting Vandermonde matrix
[Q,newunfun] = qr(unfunvandermat);                          % QR factorization
unfundsol = Q'*unfunded';                                   % Same done to results
unfundval = newunfun \ unfundsol;                           % Solve
unfundval = fliplr(unfundval');                             % Flip the endresults so they can be readily used for plotting

%% Using Householder QR factorization for funded
funvandermat = vandermat(:,1:fundegree+1);                  % Calling Vandermonde matrix
[Q,newfun] = qr(funvandermat);                              % QR factorization
fundsol = Q'*funded';                                       % Same done to results
fundval = newfun \ fundsol;                                 % Solve
fundval = fliplr(fundval');                                 % Flip the endresults so they can be readily used for plotting

%% Plotting
plot(timepoint+2008,polyval(unfundval,timepoint),'r');      % plot best fit model for unfunded projects
plot(timepoint+2008,polyval(fundval,timepoint),'b');        % plot best fit model for funded projects
plot(2020,polyval(unfundval,12),'ro');                      % plot 2020 estimation for unfunded projects
plot(2020,polyval(fundval,12),'bo');                        % plot 2020 estimation for funded projects

%% Finding best fit - Calculating Residuals and predictions
fundresiduals = norm(fundsol(fundegree+2:end));              % Residuals of funded
unfundresiduals = norm(unfundsol(unfundegree+2:end));        % Residuals of unfunded
truval = [19477 18937; 33639 25530];                         % Actual funded/unfunded dataset for 2017/2018
pERR_fund = zeros(1,2);
pERR_fund(1) = (truval(1,1) - polyval(fundval,9)); 
pERR_fund(2) = truval(1,2) - polyval(fundval,10);            % Calculate prediction error for funded
pERR_unfund = zeros(1,2);
pERR_unfund(1) = (truval(2,1) - polyval(unfundval,9)); 
pERR_unfund(2) = truval(2,2) - polyval(unfundval,10);        % Calculate prediction error for unfunded
qs_funded = abs(fundresiduals) + abs(sum(pERR_fund));                                            % Overall assessment of fit - funded
qs_unfunded = abs(unfundresiduals) + abs(sum(pERR_unfund));                                      % Overall assessment of fit - unfunded

%% Interpretation and Answers
%{
     1. For unfunded projects, degree 3 is best in terms of generalizability; 
        for funded, degree 4 is best. This is because the residuals becomes
        too large and loose fit quality below this point, and becomes 
        overfitted and looses generalizability above this point. 
        To prove my point, I googled for the ICO parteners kickstarter 
        statistics and found data for 2017. The # of unfunded projects in 
        2017 were 33,393. The difference between model output and real 
        number was the smallest at degree 3, being 7.2619e+03. 
        This also holds true for 2018 data, with the smallest difference 
        found in degree 3, 3.0591e+04. Also, the # of funded projects in 
        2017 were 19,348. the difference of real number and model output 
        was smallest at degree 4, being 4.2171e+03. This also holds true for 
        2018 data, with the smallest difference found in degree 4, 6.9091e+03

    2. Degrees differ, because the pattern the data shows is different.
       Unfunded project grows very fast untill 2015 and starts to decrease at
       2016, also very rapidly. in contrast, funded projects grow relatively
       slower, start to decrease an year earlier, but in much slower pace.
       this changes the complexity of the required best fit model, thus
       changing the degree of best fit.
%}