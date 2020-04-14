clear();
clc();
cla();

MAX_ITER = 600;
plotType = 3;

% S = State(1) - Suceptible
% E = State(2) - Exposed 
% I = State(3) - Infective
% Q = State(4) - Quarentined
% R = State(5) - Recovered
% D = State(6) - Death
% P = State(7) - Insuceptible

dt = 0.2;

% COVID  / SEIR  / MSEIR
beta = 1/1.0;     % Infection rate (average time between contacts) : 1/day
aplha = 1/5.8;    % protection rate : 1/day
gamma = 1/2;      % average latent time (inverse of incubation time. infected but not infecting others) : 1/day
delta = 1/9;      % average quarentine time (time until being imunized / quarentined after exposed. during this time, one can infect others. This is the dangerous time) : 1/day
kappa = 1/1;      % cure rate : 1/day
lambda = 1/10;    % mortality rate : 1/day
N = 200e6;        % population : individuals
N0 = 10;

%SIR model
beta = 0.8;
gamma = 0.2;



[S_, t_] = computeSerie(MAX_ITER, dt, beta, aplha, gamma, delta, kappa, lambda, N, N0, 0.2, beta*2);


if plotType==3
    plot(t_,S_');
else
    
    for i=1:MAX_ITER

        S = S_(:,i);
        t = t_(i);

        if (plotType == 1)
            plot(t_(1:i),S_(:,1:i)','linewidth',3);
            legend({'Suceptible','Exposed','Infective','Quanrentined','Recovered','Death','Insuceptive'});
        elseif (plotType == 2)

            patch([t t t+dt t+dt],[0 S(2) S(2) 0],'yellow','edgealpha',0.1);
            patch([t t t+dt t+dt],[S(2) S(2)+S(3) S(2)+S(3) S(2)],'red','edgealpha',0.1);
            patch([t t t+dt t+dt],[S(2)+S(3) S(2)+S(3)+S(4) S(2)+S(3)+S(4) S(2)+S(3) ],'blue','edgealpha',0.1);
            patch([t t t+dt t+dt],[S(2)+S(3)+S(4) S(2)+S(3)+S(4)+S(1) S(2)+S(3)+S(4)+S(1) S(2)+S(3)+S(4)],'green','edgealpha',0.1);
        end

        xlabel('time');
        ylabel('number of individuals');

        axis([0 dt*MAX_ITER 0 N]);

        drawnow();

        if mod(i,100) == 0
            fprintf('iter %d of %d\n',i,MAX_ITER);
        end
    end
end