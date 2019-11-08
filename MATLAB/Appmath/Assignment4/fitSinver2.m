%% Applied Mathematics Assignment 4
% Curve fitting 1
% This code fits a sin-function in a least-squares sense with polynomials
% of degrees 0 through 10 using the Vandermonde matrix
% Authors : Changbum Ko, Soyoung Gill and Haeji Shin
% Created : 2019/05/12
 
%% initalize
% clear all variables, close all figures, and clear the command window
clear all;
close all;
clc;
 
%% create data
x = [-pi:0.1:pi]; 
y = sin(x); % y-values corresponding to the x-values for sin function
hold on;
%% fitting
% create Vandermonde matrices and fit the data in a least-squares sense and
% calculate the residuals
vandermat = fliplr(vander(x));
maxdegree = 11;
subplot(2,1,1)
residuals = zeros(maxdegree);
plot(x,y,'r')
hold on;
for ii = 1:maxdegree
    workingvand = vandermat(:,1:ii);
    workingvand(:,ii+1) = y';
    [~,transvand] = qr(workingvand);
    solvec = transvand(:,end);
    workmat = transvand(:,1:end-1);                              
    sinval = workmat \ solvec;                               
    sinval = fliplr(sinval');
    plot(x, polyval(sinval,x));
    residuals(ii) = norm(solvec(ii+1:end)); 
end

 
% subplot 2
subplot(2,1,2)
degrees = [0:1:10]; % degrees of polynomials 0 through 10
plot(degrees,residuals); % plot the norm of the residuals as a function of the degrees
 
%% Observation
% The norm of the residuals do not gradually decrease as the polynomial
% degrees increase, because at every degree of an even number the norm does
% not show a noticeable difference than the one before. Thus when given with
% 11 chances to fit a polynomial to the sin-function, only fitting with
% polynomials of degrees of odd numbers would produce a much better fit than
% the 11 fits above. But still, the above fits did produce a close enough
% fit to the sin-function.
 

