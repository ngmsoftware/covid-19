function [beta, gamma] = adaptBetaGama(s, dt, N)

NSamples = size(s,2);

S = s(1,:);
I = s(2,:);

beta = 0;
gamma = 0;

for n=2:NSamples
    beta = beta + (N*(S(n-1) - S(n))/dt)/(S(n-1)*I(n-1));
end
beta = beta/(NSamples-1);

for n=2:NSamples
    gamma = gamma + (beta*S(n-1)*I(n-1)/N -(I(n) - I(n-1))/dt)/I(n-1);
end
gamma = gamma/(NSamples-1);

 

M = zeros(2*(NSamples-1),2);
D = zeros(2*(NSamples-1),1);
for n=1:size(S,2)-1
    M(2*n-1,:) = [-S(n)*I(n)/N 0];
    M(2*n,:) = [S(n)*I(n)/N -I(n)];
    D(2*n-1,:) = S(n+1)-S(n)/dt;
    D(2*n,:) = I(n+1)-I(n)/dt;
end

betaGamma = pinv(M)*D;

beta = betaGamma(1);
gamma = betaGamma(2);




