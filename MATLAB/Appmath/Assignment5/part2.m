%% Initialize
clear all;
close all;
clc;
%% Initial funtion settings
limits = [-240 240];
lambda = 0.03; 
tolerance = 1e-8; 
maxiterations = 1000;
%% Inital arm settings
joint = [0,0]'; 
degree1 = 45; degree2 = 45;
l1 = 20; l2 = 30;
arm1 = l1*cosd(degree1);
arm2 = l1*sind(degree1);
c1 = arm1 + l2*cosd(degree2);
c2 = arm2 - l2*sind(degree2);
initiald = [degree1 degree2]';
%% Start Inital Arm Configuration
figure(1)
hold on;
p0 = plot([joint(1) arm1], [joint(2) arm2],'bo-','linewidth',2);
text (-3,-5,'Base');
p1 = plot ([arm1 c1], [arm2 c2],'ro-','linewidth',2);
xlim([-50 50]); ylim([-50 50]);
[c1 c2] = ginput(1);
plot (c1,c2,'k*');
text (c1 -3,c2 -5,'User position');
%% Start Optimizing 
f = @(d1,d2) (l1*cosd(d1)+l2*cosd(d2)-c1)^2 + (l1*sind(d1)-l2*sind(d2)-c2)^2;
g1 = @(d1,d2) -2*l1*l2*cosd(d2)*sind(d1)+2*c1*l1*sind(d1)-2*l1*l2*cosd(d1)*sind(d2)-2*c2*l1*cosd(d1);
g2 = @(d1,d2) -2*l1*l2*cosd(d1)*sind(d2)+2*c1*l2*sind(d2)-2*l1*l2*sind(d1)*cosd(d2)+2*c2*l2*cosd(d2);
figure(2)
fsurf(f, [-240 240]);
hold on;
[xoptimal,foptimal,niterations] = ...
    gradient_descent(f,g1,g2,initiald,lambda,tolerance,maxiterations);
%% Re-draw optimized arm configurations
figure(1)
delete([p0,p1]); 
arm1 = l1*cosd(xoptimal(1));
arm2 = l1*sind(xoptimal(1));
c1 = arm1 + l2*cosd(xoptimal(2));
c2 = arm2 - l2*sind(xoptimal(2));
p0 = plot ([joint(1) arm1], [joint(2) arm2],'bo-','linewidth',2);
p1 = plot ([arm1 c1], [arm2 c2],'ro-','linewidth',2);