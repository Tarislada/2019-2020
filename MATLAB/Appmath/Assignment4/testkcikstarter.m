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
unfunded = unfunded';
funded = funded';
unfundegree = 3;                                                
fundegree = 4;                                              % set degree

%% Creating Vandermonde matrix
vandermat = fliplr(vander(timepoint));                      % the whole Vandermonde matrix
                     
%% Using Householder QR factorization for unfunded

unfunvandermat = vandermat(:,1:unfundegree+1);              % Calling Vandermonde matrix

[Q,newunfun] = qr(unfunvandermat)                             % QR factorization
unfundsol = Q'*unfunded                                 
unfundmat = newunfun                         % Separate matrix and results to solve system
unfundval = unfundmat \ unfundsol                          % Solve
unfundval = fliplr(unfundval')                             % Flip the endresults so they can be readily used for plotting

plot(timepoint+2008,polyval(unfundval,timepoint),'r');      % plot best fit model for unfunded projects

plot(2020,polyval(unfundval,12),'ro');                      % plot 2020 estimation for unfunded projects
