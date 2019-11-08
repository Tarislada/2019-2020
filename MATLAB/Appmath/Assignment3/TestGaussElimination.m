%% Initalize
close all;
clear all;
clc;

%% Define elements 
narray = [2,5,10,100,1000];     % Array sizes that will be used
customtime = zeros(1,5);        % Preset vector for timestamping DIY Gaussian Elimination w partial pivotting
builtintime = zeros(1,5);       % Preset vector for timestamping MATLAB built in function

%% Solve and Measure
for i = 1:length(narray)
    testermat = rand(narray(i));            % Create random matrix to test
    testerres = rand(narray(i),1);          % Create random solution vector to test
    tic;                                    % Start timer
    GaussElimination(testermat,testerres);  % Run DIY Gaussian
    customtime(i) = toc;                    % Stop timer & save results in the vector
    tic;                                    % Start timer again
    testermat \ testerres;                  % Run MATLAB built in function
    builtintime(i) = toc;                   % Stop timer & save results in the vector
end

%% Plotting the results
plot(1:5,customtime,'b-');                  % Plot time elasped for DIY function in blue
hold on;                                    % Draw again
plot(1:5,builtintime,'r-');                 % Plot time elasped for MATLAB built in function in red

%% Interpretation
% built in function performs significantly better as the matrix gets very
% large, say, 1000