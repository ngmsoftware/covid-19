function [x,fval,exitflag,output,population,score] = untitled(MigrationFraction_Data)
%% This is an auto generated MATLAB file from Optimization Tool.

%% Start with the default options
options = optimoptions('ga');
%% Modify options setting
options = optimoptions(options,'MigrationFraction', MigrationFraction_Data);
options = optimoptions(options,'MutationFcn', {  @mutationgaussian [] [] });
options = optimoptions(options,'Display', 'off');
[x,fval,exitflag,output,population,score] = ...
ga([],[],[],[],[],[],[],[],[],[],options);
