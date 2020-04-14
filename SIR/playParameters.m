function playParameters(beta0, gamma0, ampBeta, ampGamma)

close('all');

country = 'Brazil';
country2 = country;
%country2 = 'United States of America';

a = jsondecode(urlread('https://restcountries.eu/rest/v2/'));
idx = find(cellfun(@(x)(strcmp(x,country2)), {a.name}));
populations = [a.population];
population = populations(idx);


[date, confirmed, deaths, recovered] = getData(country);
ps = find(confirmed~=0);
firstIdx = ps(1);
confirmed(1:firstIdx) = [];
deaths(1:firstIdx) = [];
recovered(1:firstIdx) = [];
infected = confirmed - recovered + deaths;

s = [population-confirmed; recovered];


F = uifigure('Position',[150 150 800 50]);
sldBeta = uislider(F,'Position',[20 35 300 3],'Limits',beta0 + [-ampBeta ampBeta]);
sldGamma = uislider(F,'Position',[400 35 300 3],'Limits',gamma0 + [-ampGamma ampGamma]);



dt = 0.2;
N = population;
N0 = infected(1);
MAX_ITER = fix(1.05*length(s)/dt);

sldBeta.ValueChangingFcn = @(x, y)simulateAndPlot(s, y.Value, sldGamma.Value, MAX_ITER, dt, N, N0);
sldGamma.ValueChangingFcn = @(x, y)simulateAndPlot(s, sldBeta.Value, y.Value, MAX_ITER, dt, N, N0);

end



function simulateAndPlot(s, beta, gamma, MAX_ITER, dt, N, N0) 

[S_, t_] = computeSerie(MAX_ITER, dt, beta, gamma, N, N0);

subplot(3,1,1);
cla();
semilogy(t_,S_(1,:),'r');
subplot(3,1,2);
cla();
semilogy(t_,S_(2,:),'g');
subplot(3,1,3);
cla();
semilogy(t_,S_(3,:),'b');

subplot(3,1,1);
hold('on');
semilogy(1:length(s),s(1,:),'r:','linewidth',4);
subplot(3,1,2);
hold('on');
semilogy(1:length(s),N-s(1,:)-s(2,:),'g:','linewidth',4);
subplot(3,1,3);
hold('on');
semilogy(1:length(s),s(2,:),'b:','linewidth',4);

end

