%% Assignment 5-(a)
% this script tests the function of gradient descent algorithm and plots
% the results
% authors: Changbum Ko, Soyoung Gill and Haeji Shin
% created: 2019/05/26

%% initialize
clear all
close all
clc
%% test the gradient descent function with given function and parameters
% define function f and partial derivatives
f = @(x1,x2) x1.^2 + x1.*cos(x1.*x2/3) + 3*x2.^2;
g1 = @(x1,x2) 2*x1+cos(x1.*x2/3) - (x1.*x2.*sin(x1.*x2/3))/3;
g2 = @(x1,x2) 6*x2 - (x1.^2.*sin(x1.*x2/3))/3;
% create grid vector for the surface plot
[surfx,surfy] = meshgrid(-15:15,-15:15);
% create surface plot
surf(surfx,surfy,f(surfx,surfy)); hold on
% define given input parameters for testing the gradient descent function
xstart = [10 10]'; lambda = 0.03; tolerance = 1e-8; maxiterations = 1000;
% utilize the pre-defined gradient_descent function using given parameters 
[xoptimal,foptimal,niterations]= ...
    gradient_descent(f,g1,g2,xstart,lambda,tolerance,maxiterations);

%% observations
% the value of lambda that will result in non-convergence : 0.34
% the value of lambda that has the minimum number of steps to reach the
% minimum point : 0.26