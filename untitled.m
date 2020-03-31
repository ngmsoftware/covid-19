function [x,fval,exitflag,output,population,score] = untitled(PopulationSize_Data)
%% This is an auto generated MATLAB file from Optimization Tool.

%% Start with the default options
options = optimoptions('ga');
%% Modify options setting
options = optimoptions(options,'PopulationSize', PopulationSize_Data);
options = optimoptions(options,'Display', 'off');
[x,fval,exitflag,output,population,score] = ...
ga([],[],[],[],[],[],[],[],[],[],options);
