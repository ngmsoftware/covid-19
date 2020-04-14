function err = modelError(beta, gamma, N, N0, sIn)

    dt = 0.2;
    MAX_ITER = size(sIn,2)/dt;

    [S_, t_] = computeSerie(MAX_ITER, dt, beta, gamma, N, N0);
    
    s = S_(1:2,1:round(1/dt):end);

    err = sum(sum( ((s-sIn).^2)/N ));

end