function plotResult(sz, dt, beta, gamma, N, N0, timeAhead)

s = sz;

[S_, t_] = computeSerie((size(s,2)+timeAhead)/dt, dt, beta, gamma, N, N0);
t_ = t_(1:round(1/dt):end);

sHat = S_(1:2,1:round(1/dt):end);


subplot(2,1,1);
cla();
plot(t_(1:length(s)),s,'linewidth',3);
hold('on');
plot(t_,sHat);
xlabel('days');
ylabel('# of people');
legend({'Suceptibles (measuredd', 'Infected (measured)', 'Suceptibles (estimated)', 'Infected (estimated)'})


subplot(2,2,3);
cla();
plot(t_(1:length(s)),s,'linewidth',3);
hold('on');
plot(t_,sHat);
axis([min(t_) max(t_(1:length(s))) min(s(1,:)) max(s(1,:))])
xlabel('days');
ylabel('# of people');

subplot(2,2,4);
cla();
plot(t_(1:length(s)),s,'linewidth',3);
hold('on');
plot(t_,sHat);
axis([min(t_) max(t_(1:length(s))) min(s(2,:)) max(s(2,:))])
xlabel('days');
ylabel('# of people');

