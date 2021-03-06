clear();
clc();

country = 'Canada';
country2 = country;
%country2 = 'United States of America';

a = jsondecode(urlread('https://restcountries.eu/rest/v2/'));
idx = find(cellfun(@(x)(strcmp(x,country2)), {a.name}));
populations = [a.population];
population = populations(idx);


[date, confirmed, deaths, recovered] = getData(country);
infected = confirmed - recovered + deaths;
infected(infected==0) = [];

s = [population-confirmed; recovered];
index = [1 3]; % S_(index) will be the variable to match

s = infected;
index = 2; % S_(index) will be the variable to match

MAX_ITER = 1000;


dt = 0.2;

N = population;
N0 = infected(1);

Nb = 400;
Ng = 400;

E = zeros(Nb,Ng);

idxBetaMin = 1;
idxGammaMin = 1;
errMin = Inf;



% Italy
beta_1 =  0.1;
gamma_1 = 0.02;
beta_2 =  2.2;
gamma_2 = 2.03;



beta_1 =  18.0;
gamma_1 = 18.0;
beta_2 =  20.0;
gamma_2 = 20.0;




BETAS = linspace(beta_1, beta_2, Nb);
GAMMAS = linspace(gamma_1, gamma_2, Ng);

idxBeta = 1;
for beta = BETAS
    idxGamma = 1;
    for gamma = GAMMAS
        
        
        parameters = [beta, gamma];
        err = modelError(s, dt, index, beta, gamma, N, N0);
        if (errMin > err)
            idxBetaMin = idxBeta;
            idxGammaMin = idxGamma;
            errMin = err;
        end
            
            
        E(idxBeta, idxGamma) = err;
        idxGamma = idxGamma+1;
    end
    idxBeta = idxBeta+1;
end
    
beta1 = BETAS(idxBetaMin);
gamma1 = GAMMAS(idxGammaMin);


subplot(1,2,1);
hold('on');
[B, G] = meshgrid(BETAS, GAMMAS);
mesh(B, G, log(1+E));
plot3(beta1, gamma1, 0, 'ro');

subplot(1,2,2);
plotResult(s, index, dt, beta1, gamma1, N, N0)

[S_, t_] = computeSerie(MAX_ITER, dt, beta1, gamma1, N, N0);
plot(t_, S_(index,:), 'k:');




