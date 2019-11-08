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


%% fitting
% create Vandermonde matrices and fit the data in a least-squares sense
% using Householder QR factorization and calculate the residuals
for f = 1:11                   % for the number of polynomial degrees
    x = [-pi:0.1:pi];          
    y = sin(x)';               % create data
    Vand = fliplr(vander(x));  % create Vandermonde matrix for polynomial degree of 11 as a whole
    V = Vand(:,1:f);           % and select "the" Vandermonde matrix for the current polynomial degree for calculation

    e = zeros(63,1);           % prepare a vector of zeros to create the e vector
    for d = 1:f                    % for each degree
        e(d,1) = 1;                % insert 1 in the dth element and create the e vector
        Vqr = zeros(63,1);         % prepare vector Vqr to calculate v
        Vqr(d:end) = V(d:end,d);   % and fill it in with the dth column of the Vandermonde matrix for the current degree
        
        if Vqr(d,1) > 0                                 % to avoid cancellation check the first element of Vqr 
            v = Vqr + (sqrt(sum(Vqr(:).^2))) * e;       % calculate v for when the first element is positive
            else v = Vqr - (sqrt(sum(Vqr(:).^2))) * e;  % calculate v for when the first element is negative
        end
        
        H = eye(63) - (2 * (v * v') / (v' * v)); % calculate H to use in Householder transformation
        V = H * V; % Householder transformation
        y = H * y; % Householder transformation
        e = zeros(63,1); % reset vector e of zeros for next calculation
    end
    
    R = V(1:f,:); % select the upper triangular matrix R
    c = y(1:f); % select the corresponding vector c
    coef{f} = R \ c; % calculate the coeffient through back-substitution
    fitted{f} = Vand(:,1:f) * coef{f}; % calculate the estimates
    
    res = y(f+1:end); % take the rest of y (elements below c) to calculate the residuals
    norm(f) = sqrt(sum(res(:).^2)); % calculate the norm of the residuals
    
end

%% plotting results
% create figure
figure(1)

% subplot 1
subplot(2,1,1)
plot(x,sin(x),'bo')         % plot the original sin-function in blue circles
hold on                     % temporarily hold on to add more to the plot
for f = 1:11                % for the number of fits
    plot(x,fitted{f},'r-')  % plot all the fits in red lines
    hold on
end

% subplot 2
subplot(2,1,2)
degrees = [0:1:10]; % degrees of polynomials 0 through 10
plot(degrees,norm) % plot the norm of the residuals as a function of the degrees


%% Observation
% The coefficients show a decreasing trend as the polynomial degrees
% increase. The norm of the residuals do not gradually decrease as the polynomial
% degrees increase, because at every degree of an even number the norm does
% not show a noticeable difference than the one before. Thus when given with
% 11 chances to fit a polynomial to the sin-function, only fitting with
% polynomials of degrees of odd numbers might produce a much better fit than
% the 11 fits above. However, it is important to always remember the fact
% that if the polynomial degree gets excessively large, overfitting could
% become a problem.


