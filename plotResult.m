function plotResult(s, index, dt, p1)

[S_, t_] = computeSerie(size(s,2)/dt, dt, p1(1), p1(2), p1(3), p1(4), p1(5), p1(6), p1(7), p1(8), p1(9), p1(10), p1(11));
t_ = t_(1:round(1/dt):end);

sHat = S_(index,1:round(1/dt):end);


cla();
plot(t_,s);
hold('on');
plot(t_,sHat);
line([p1(9)*max(t_) p1(9)*max(t_)],[0 max(s)])