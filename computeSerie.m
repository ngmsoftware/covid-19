function [S_, t_] = computeSerie(MAX_ITER, dt, beta, aplha, gamma, delta, kappa, lambda, N, N0, time1, beta2, gamma2) 

% S = State(1) - Suceptible
% E = State(2) - Exposed 
% I = State(3) - Infective
% Q = State(4) - Quarentined
% R = State(5) - Recovered
% D = State(6) - Death
% P = State(7) - Insuceptible

parameters = [beta, aplha, gamma, delta, lambda, kappa, N];

S = zeros(7,1);
S(1) = N;
S(3) = N0;

t = 0;

S_ = zeros(7,MAX_ITER)*nan;
t_ = zeros(1,MAX_ITER);


for i=1:MAX_ITER
    S = stepModel(S, parameters, dt);
    t = t+dt;

    if ~isnan(time1)
        parameters(1) = (0.5+atan((i-MAX_ITER*time1)*10)/pi)*(beta2-beta)+beta;
        parameters(3) = (0.5+atan((i-MAX_ITER*time1)*10)/pi)*(gamma2-gamma)+gamma;
    end
    
    S_(:,i) = S;
    t_(i) = t;
end