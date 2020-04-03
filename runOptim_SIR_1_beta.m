clear();
clc();

country = 'Brazil';
country2 = country;
%country2 = 'United States of America';

a = jsondecode(urlread('https://restcountries.eu/rest/v2/'));
idx = find(cellfun(@(x)(strcmp(x,country2)), {a.name}));
populations = [a.population];
population = populations(idx);


[date, confirmed, deaths, recovered] = getData(country);
active = confirmed - recovered + deaths;
active(active==0) = [];
s = active;


MAX_ITER = 600;

index = 3; % S_(index) will be the variable to match

dt = 0.2;

beta = 1.0;     % Infection rate (average time between contacts) : 1/day
gamma = 1.0;      % average latent time (inverse of incubation time. infected but not infecting others) : 1/day
N = population;        % population : individuals
N0 = active(1);


parameters = [beta, 0.0, gamma, 0.0, 0.0, 0.0, N, N0, 1, 0 0 0];


% fitting the second beta
lb = parameters.*[0.0   0   0.0    0 0 0   1      1        1    0.0   0.0    0];
ub = parameters.*[ 10   0    10    0 0 0   1      1    1   0.0,   0.0   0];



options = optimoptions('ga');
%% Modify options setting
options = optimoptions(options,'MaxGenerations', 10000);
options = optimoptions(options,'PopulationSize', 2000);
options = optimoptions(options,'FunctionTolerance', 0.0);
%options = optimoptions(options,'MigrationFraction', 0.05);
options = optimoptions(options,'Display', 'off');
%options = optimoptions(options,'MutationFcn',{@mutationgaussian,1,0.95});
options = optimoptions(options,'MaxStallGenerations', inf);
options = optimoptions(options,'PlotFcn', { @gaplotbestf, @(a,b,c)customPlotfun(a,b,c,s,index,dt) });
[x,fval,exitflag,output,population,score] = ...
ga(@(x)modelError(x,s,[index]),12,[],[],[],[],lb,ub,[],[],options);

p1 = x.*[1 nan 1 nan nan nan 1 1 1 1 1 1];


plotResult(s, index, dt, p1);

[S_, t_] = computeSerie(MAX_ITER, dt, p1(1), p1(2), p1(3), p1(4), p1(5), p1(6), p1(7), p1(8), p1(9), p1(10), p1(11));

plot(t_,S_(index,:),':k');
