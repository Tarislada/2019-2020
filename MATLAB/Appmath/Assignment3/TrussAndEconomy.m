%% initalize
clear all;
close all;
clc;

%% Begin Assignment (a)
Trussmat = [-0.866,0,0.5,0,0,0;-0.5,0,-0.866,0,0,0;0.866,1,0,1,0,0;0.5,0,0,0,1,0;0,0,0.866,0,0,1];
Trussres = [0;-1000;0;0;0;0];
GaussElimination(Trussmat,Trussres);

%% Begin Assignment (b)

