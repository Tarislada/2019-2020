%% Assignment 4
% Part 1 : Line fitting-prediction
% this code predicts the number of facebook users based on a linear trend
% using least-sqares regression
% authors : Changbum Ko, Soyoung Gill, and Haeji Shin
% created : 2019/05/08

%% define arrays 
% take datapoints from graph and create 'members' array
members = [100 150 200 250 300 350 450 500 550 600 650 750 800 845 901 955 1000 1060 1110 1150 1184 1230 1320 1350 1390 1441 1550];
% take timepoints from graph and create 'months' array (starting from
% Aug-08)
months = [0 5 8 11 13 16 18 23 25 29 30 34 37 42 44 47 50 53 55 59 65 66 71 74 77 80 87];

%% determine covariances
% determine the covariance so that we can ascertain the slope of the data
covXY = cov(months,members);

%% determine optimal slope of line
% determine the optimal slope(w) of line
w = covXY(1,2) / var(months);

%% determine optimal intercept of line
% determine the optimal intercept(b) of line
b = mean(members)-w*mean(months);

%% plot all data and best line fit
% now plot the best line fit using the optimal slope and intercept of the
% line (a closed form solution)
figure;
scatter(months, members, 'b', '*'); % first introduce the data already given to us
xlabel('months'); % label them
ylabel('members');
hold on % to add the regression line
plot(months, w*months+b, '-r'); % plot the linear regression line in red
title ('Facebook Users in Millions'); % add title to show what the figure is about

%% prediction
% in order to predict when the number of members will approximate the
% number of humans on Earth(8billion)...
syms x % define symbolic variable x for when(in terms of month) that will happen
x = (8000-b)/w; % the number of facebook members will approximate 8 billion in about 460 months starting from August 2008.

plot(x, 8000, 'p'); % plot the predicted time
hold on; % to extend the x axis to the predicted time
plot ([1:x], w*[1:x]+b, '-');
hold on; % to add legend explaining what data the figure points to
legend('data', 'line fit', 'predicted time')

%% observation and interpretation
% Although the data points given in the graph seem to create a rather clean
% line, we did not take into account the possible noise in our
% measurements. Thus, the correlations and predictions on this dataset can never be
% considered perfect nor be trusted.