%% function Mean SEM
% this file creates a function that calculates the mean and SEM of given data
%
% Inputs : targetdata - given data in double 
% Outputs : meanout - mean of targetdata
%           SEMout - SEM of targetdata
% authors: Ko, Gill, and Shin
% created: 2019/03/19
% modified: 2019/03/21

function [meanout, SEMout] = meanSEM(targetdata)
meanout = mean(targetdata); % calculates the mean of targetdata
SEMout = std(targetdata)./sqrt(length(targetdata)-1); % calculates the SEM of targetdata
return
