function [x,fval,exitflag,output,population,score] = optminCode(nvars,lb,ub,MaxGenerations_Data,FunctionTolerance_Data,ConstraintTolerance_Data)
%% This is an auto generated MATLAB file from Optimization Tool.

%% Start with the default options
options = optimoptions('ga');
%% Modify options setting
options = optimoptions(options,'MaxGenerations', MaxGenerations_Data);
options = optimoptions(options,'FunctionTolerance', FunctionTolerance_Data);
options = optimoptions(options,'ConstraintTolerance', ConstraintTolerance_Data);
options = optimoptions(options,'Display', 'off');
options = optimoptions(options,'PlotFcn', { @gaplotbestf });
[x,fval,exitflag,output,population,score] = ...
ga(@(x)modelError(x,s,[2]),nvars,[],[],[],[],lb,ub,[],[],options);
