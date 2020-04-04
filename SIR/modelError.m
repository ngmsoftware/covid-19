function err = modelError(S, dt, idxS, beta, gamma, N, N0)
    MAX_ITER = size(S,2)/dt;
    
    [S_, t_] = computeSerie(MAX_ITER, dt, beta, gamma, N, N0);
    
    s = S_(idxS,1:round(1/dt):end);
   
    err = sum(sum( ((s-S).^2)/N ));

end