function err = modelError(parameters, S, idxS)

    dt = 0.2;
    MAX_ITER = size(S,2)/dt;
    
    beta = parameters(1);
    aplha = parameters(2);
    gamma = parameters(3);
    delta = parameters(4);
    kappa = parameters(5);
    lambda = parameters(6);
    N = parameters(7);
    N0 = parameters(8);
    time1 = parameters(9);
    beta2 = parameters(10);
    gamma2 = parameters(11);
    
    [S_, t_] = computeSerie(MAX_ITER, dt, beta, aplha, gamma, delta, kappa, lambda, N, N0, time1, beta2, gamma2);
    
    s = S_(idxS,1:round(1/dt):end);
    
    err = sum(sum(        log(1+(s-S).^2)     ));

end