%% Applied Mathematics Assignment#1 Part2
% This file calculates statistics of the sample data and plots them.
% Authors : Changbum Ko, Soyoung Gill and Haeji Shin
% Created : 2019/03/19

%% Clearing former settings
% to clear all variables, close all figures, and clear the command window
clear all
close all
clc
%% Load data
% loading the data and creating the statistics that will be used in the
% plot
load('experimentData');                 % loads the data members wish to work with
EDHR = experimentData(:,1);             % shorthand for Experiment Data Heart Rate
EDWt = experimentData(:,2);             % shorthand for Experiment Data Weight
EDex = experimentData(:,3);             % shorthand for Experiment Data exercise
[HRmean, HRSEM] = meanSEM(EDHR);        % calculates the mean and sem of the heart rate with the function meanSEM
[Wtmean, WtSEM] = meanSEM(EDWt);        % calculates the mean and sem of the weight
[excermean, excerSEM] = meanSEM(EDex);  % calculates the mean and sem of exercise hours


%% Plotting data

% Creates the first figure with three subplots
figure(1); 

% subplot 1 (heart rate)
subplot(3,1,1);                         % the subplots will provide additional information in the figure
plot(EDHR,'o-');                        % plots the heart rate with markers
hold on;                                % allows me to add more to the plot by temporarily holding on
plot(HRmean*ones(size(EDHR)));          % creates a subplot of the mean onto existing plot of heart rate
hold on;
plot(HRmean+HRSEM*ones(size(EDHR)),'linestyle','--'); % creates a subplot of sem above the mean using dotted lines
hold on;
plot(HRmean-HRSEM*ones(size(EDHR)),'linestyle','--'); % creates a subplot of sem below the mean using dotted lines
title('Heartrate mean & SEM') % creates a title for the plot
xlabel('Participant number') % labels the x axis
ylabel('Heart Rate') % labels the y axis

% subplot 2 (weight)
subplot(3,1,2); 
plot(EDWt,'o-'); % plots the weight with markers
hold on; % allows me to add more to the plot by temporarily holding on
plot(Wtmean*ones(size(EDWt))); % creates a subplot of the mean onto existing plot of weight
hold on;
plot(Wtmean+WtSEM*ones(size(EDWt)),'linestyle','--'); % creates a subplot of sem above the mean using dotted lines
hold on;
SE1 = plot(Wtmean-WtSEM*ones(size(EDWt)),'linestyle','--'); % creates a subplot of sem below the mean using dotted lines
title('Weight mean & SEM') % creates a title for the plot
xlabel('Participant number') % labels the x axis
ylabel('Weight(Kg)') % labels the y axis

% subplot 3 (exercise)
subplot(3,1,3) 

plot(EDex,'o-'); % plots the hours of exercise with markers
hold on; % allows me to add more to the plot by temporarily holding on
plot(excermean*ones(size(EDex))); % creates a subplot of the mean onto existing plot of exercise
hold on;
plot(excermean+excerSEM*ones(size(EDex)),'linestyle','--'); % creates a subplot of sem above the mean using dotted lines
plot(excermean-excerSEM*ones(size(EDHR)),'linestyle','--'); % creates a subplot of sem below the mean using dotted lines
title('Exercise mean & SEM') % creates a title for the plot
xlabel('Participant number') % labels the x axis
ylabel('Excercise') % labels the y axis

% saving
saveas(gcf,'analysis.fig'); % saves the figure to a file named 'analysis'

% Second figure
figure(2); 

% subplot 1 (heart rate against weight)
subplot(3,1,1) % creates the first subplot in the second figure
scatter(EDHR,EDWt); % creates a scatterplot of heart rate against the weight
title('Heartrate& Weight') % makes a title for the subplot
xlabel('Heartrate') % labels the x axis
ylabel('Weight') % labels the y axis

% subplot 2 (heart rate against exercise time)
subplot(3,1,2) % creates a second subplot
scatter(EDHR,EDex); % creates a scatterplot of heart rate against the exercise time
title('Heartrate & Excercise') % makes a title for the subplot
xlabel('Heartrate') % labels the x axis
ylabel('Excercise') % labels the y axis

%subplot 3 (weight against exercise time)
subplot(3,1,3) % creates the third subplot
scatter(EDWt,EDex); % creates a scatterplot of weight against the exercise time
title('Weight & Exercise') % makes a title for the subplot
xlabel('Weight') % labels the x axis
ylabel('Excercise') % labels the y axis

% saving
saveas(gcf,'analysis2.fig'); % saves the resulting figure as 'analysis2'

%% Final Comments
% In addition to the given statistical calculations we conducted additional analysis 
% using the correlation coefficient function that returns the correlation coefficient
% and p-value.
% [R1,P1] = corrcoef(EDWt,EDex)
% [R2,P2] = corrcoef(EDex,EDHR)
% [R3,P3] = corrcoef(EDHR,EDWt)
% With the results, we hope to provide more cautious interpretations of the
% data. 

% According to the results, there is almost no correlation(r1 = -0.2325) between weight and
% exercise, which is ignorable because of the p-value(0.4447).

% Next, there is a strong negative correlation(r2 = -0.7218) between exercise hours
% and heart rate, meaning that people who exercise more tend to have lower 
% heart rates. This correlation can be considered marginally significant with a
% p-value of 0.0053.

% Lastly, there seems to be a positive correlation (r3 = 0.4786) between heart rate and
% weight, but it is not statistically significant due to the p-value(0.0995).