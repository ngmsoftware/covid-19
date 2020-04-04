function [beta, gamma] = adaptBetaGama(beta0, gamma0, alpha, s, dt, N, N0)

    beta = beta0;
    gamma = gamma0;

    dEdBeta  = 0;
    dEdGamma  = 0;
    SIHat_n_1 = N0;
    SSHat_n_1 = N;
    dSIdBeta_n_1 = randn(1)/1000;
    dSSdBeta_n_1 = randn(1)/1000;
    dSIdGamma_n_1 = randn(1)/1000;
    dSSdGamma_n_1 = randn(1)/1000;
    n = 1;
    SIHat_n = zeros(1,round(size(s,2)/dt));
    SSHat_n = zeros(1,round(size(s,2)/dt));
    dSIdBeta_n = zeros(1,round(size(s,2)/dt));
    dSSdBeta_n = zeros(1,round(size(s,2)/dt));
    dSIdGamma_n = zeros(1,round(size(s,2)/dt));
    dSSdGamma_n = zeros(1,round(size(s,2)/dt));
    for i=1:length(SIHat_n)


        SIHat_n(n) = SIHat_n_1 + fI(SIHat_n_1, SSHat_n_1, beta, gamma, N)*dt;
        SSHat_n(n) = SSHat_n_1 + fS(SIHat_n_1, SSHat_n_1, beta, gamma, N)*dt;


        % beta computation
        
        dSIdBeta_n(n) = dSIdBeta_n_1 + dfIdSI(SIHat_n_1, SSHat_n_1, beta, gamma, N)*dSIdBeta_n_1*dt + dfIdSS(SIHat_n_1, SSHat_n_1, beta, gamma, N)*dSSdBeta_n_1*dt;
        dSSdBeta_n(n) = dSSdBeta_n_1 + dfSdSI(SIHat_n_1, SSHat_n_1, beta, gamma, N)*dSIdBeta_n_1*dt + dfSdSS(SIHat_n_1, SSHat_n_1, beta, gamma, N)*dSSdBeta_n_1*dt;

       
        
        % gamma computation
        
        dSIdGamma_n(n) = dSIdGamma_n_1 + dfIdSI(SIHat_n_1, SSHat_n_1, beta, gamma, N)*dSIdGamma_n_1 + dfIdSS(SIHat_n_1, SSHat_n_1, beta, gamma, N)*dSSdGamma_n_1;
        dSSdGamma_n(n) = dSSdGamma_n_1 + dfSdSI(SIHat_n_1, SSHat_n_1, beta, gamma, N)*dSIdGamma_n_1 + dfSdSS(SIHat_n_1, SSHat_n_1, beta, gamma, N)*dSSdGamma_n_1;

        
        
        
        
        
        SIHat_n_1 = SIHat_n(n);
        SSHat_n_1 = SSHat_n(n);
        dSIdBeta_n_1 = dSIdBeta_n(n);
        dSSdBeta_n_1 = dSSdBeta_n(n);
        dSIdGamma_n_1 = dSIdGamma_n(n);
        dSSdGamma_n_1 = dSSdGamma_n(n);
        
        n = n+1;
    end

    
    dEdBeta  = 2*sum( (SIHat_n(1:round(1/dt):end) - s).*dSIdBeta_n(1:round(1/dt):end) );
    dEdGamma  = 2*sum( (SIHat_n(1:round(1/dt):end) - s).*dSIdGamma_n(1:round(1/dt):end) );



    beta  = beta0 - alpha*dEdBeta/N;
    gamma = gamma0 - alpha*dEdGamma/N;


    
    cla();
    hold('on');
    plot(dSIdBeta_n);
    plot(dSSdBeta_n);
    plot(dSIdGamma_n);
    plot(dSSdGamma_n);
    
end



function y = fI(SI, SS, beta, gamma, N)
    y = beta*SI*SS/N - gamma*SI;
end


function y = fS(SI, SS, beta, gamma, N)
    y = -beta*SI*SS/N;
end



function y = dfIdSI(SI, SS, beta, gamma, N)
    y = beta*SS/N - gamma;
end

function y = dfIdSS(SI, SS, beta, gamma, N)
    y = beta*SI/N;
end



function y = dfSdSI(SI, SS, beta, gamma, N)
    y = -beta*SS/N;
end

function y = dfSdSS(SI, SS, beta, gamma, N)
    y = -beta*SI/N;
end

