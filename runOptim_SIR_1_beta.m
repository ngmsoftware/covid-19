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
active = confirmed - recovered + deaths + 1;
% active(active==0) = [];
% confirmed(1:end-length(active)) = [];
s = [population-confirmed; active];


MAX_ITER = 600;

index = [1 3]; % S_(index) will be the variable to match

dt = 0.2;

beta = 1.0;     % Infection rate (average time between contacts) : 1/day
gamma = 0.2;      % average latent time (inverse of incubation time. infected but not infecting others) : 1/day
N = population;        % population : individuals
N0 = active(1);


parameters = [beta, gamma];


% fitting the second beta
lb = parameters.*[0.0 1];
ub = parameters.*[1000 1];



options = optimoptions('ga');
%% Modify options setting
options = optimoptions(options,'MaxGenerations', 10000);
options = optimoptions(options,'PopulationSize', 2000);
options = optimoptions(options,'FunctionTolerance', 0.0);
%options = optimoptions(options,'MigrationFraction', 0.05);
options = optimoptions(options,'Display', 'off');
%options = optimoptions(options,'MutationFcn',{@mutationgaussian,1,0.95});
options = optimoptions(options,'MaxStallGenerations', inf);
options = optimoptions(options,'PlotFcn', { @gaplotbestf });
[x,fval,exitflag,output,population,score] = ...
ga(@(x)modelError(x(1),x(2),N, N0,s),2,[],[],[],[],lb,ub,[],[],options);

beta0 = x(1);
gamma0 = x(2);

plotResult(s, dt, beta0, gamma0, N, N0, 100);

