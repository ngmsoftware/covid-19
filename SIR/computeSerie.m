function [S_, t_] = computeSerie(MAX_ITER, dt, beta, gamma, N, N0) 

% S = State(1) - Suceptible
% I = State(3) - Infective
% R = State(5) - Recovered

S = zeros(3,1);
S(1) = N;
S(2) = N0;

t = 0;

S_ = zeros(3,MAX_ITER)*nan;
t_ = zeros(1,MAX_ITER);


for i=1:MAX_ITER
    S = stepModel(S, beta, gamma, N, dt);
    t = t+dt;

    S_(:,i) = S;
    t_(i) = t;
end