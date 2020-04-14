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
s = active;


MAX_ITER = 600;

index = 3; % S_(index) will be the variable to match

dt = 0.2;

N = population;
N0 = active(1);

Nb = 200;
Ng = 200;

E = zeros(Nb,Ng);

idxBetaMin = 1;
idxGammaMin = 1;
errMin = Inf;

% italy
beta0 =  3.6734;
gamma0 = 3.4623;


% brasil
beta0 =  3.0;
gamma0 = 3.0;


betaAmp = 3.0;
gammaAmp = 3.0;

BETAS = beta0 + linspace(-betaAmp, betaAmp, Nb);
GAMMAS = gamma0 + linspace(-gammaAmp,gammaAmp, Ng);

idxBeta = 1;
for beta = BETAS
    idxGamma = 1;
    for gamma = GAMMAS
        err = modelError(beta, gamma, s, index);
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
plotResult(s, index, dt, beta1, gamma1, N, N0, 1)
