%%%% Applied Mathematics Assignment 5
%% function gradient_descent
% this file creates a function that executes the gradient descent algorithm
% of function f
%
% Inputs : f - function handle to the definition of the function
%          g1,g2 - function handle to the definition of the partial
%                  derivatives of the function f
%          xstart - array of starting values for optimization
%          lambda - update rate in the gradient descent step
%          tolerance - value of the squared norm of the gradient at which
%                      you accept that the minimum is found
%          maxiterations - maximum number of iterations
% Outputs : xoptimal - optimal point
%           foptimal - function value at xoptimal
%           niterations - number of iterations the algorithm made to reach
%                         criterion
% authors: Changbum Ko, Soyoung Gill and Haeji Shin
% created: 2019/05/23

%% define the function
function [xoptimal,foptimal,niterations] = gradient_descent(f,g1,g2,xstart,lambda, tolerance, maxiterations)
%% set starting values
iter = 0; % number of iterations starting from zero
currx1 = xstart(1); 
currx2 = xstart(2); % starting values for optimization
g1norm = inf;
g2norm = inf; % norm of the gradient starting at infinity
%% gradient descent
while (g1norm>=tolerance && iter<=maxiterations && g2norm>=tolerance) % repeat the algorithm until criterion is met
    prevx1 = currx1;
    prevx2 = currx2; % set current points as previous points
    g1norm = norm(g1(prevx1,prevx2));
    g2norm = norm(g2(prevx1,prevx2)); % calculate the norms for previous points
    currx1 = prevx1 - lambda*g1(prevx1,prevx2);
    currx2 = prevx2 - lambda*g2(prevx1,prevx2); % update current points
    plot3([prevx1 currx1], [prevx2 currx2], [f(prevx1,prevx2) f(currx1,currx2)],'ro-'); % plot the successive points of the optimization
    refresh % refresh figure
    iter = iter+1; % go on to next iteration
end
%% save output
xoptimal = [currx1,currx2]; % save the optimal point earned from gradient descent
foptimal = f(currx1, currx2); % find the function value at the optimal point
niterations = iter; % save the number of iterations the algorithm made to reach criterion
end