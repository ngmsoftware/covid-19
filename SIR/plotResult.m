function plotResult(s, index, dt, beta, gamma, N, N0, timeAhead)

[S_, t_] = computeSerie((size(s,2)+timeAhead)/dt, dt, beta, gamma, N, N0);
t_ = t_(1:round(1/dt):end);

sHat = S_(index,1:round(1/dt):end);


cla();
plot(s','linewidth',4);
hold('on');
plot(t_,sHat);