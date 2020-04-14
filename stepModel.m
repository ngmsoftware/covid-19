function StateOut = stepModel(StateIn, beta, gamma, N, dt)

    % Euler
     StateOut = StateIn + derivative(StateIn, beta, gamma, N)*dt;
    
    
    % RK
%     k1 = derivative(StateIn, parameters)*dt;
%     k2 = derivative(StateIn+k1/2, parameters)*dt;
%     k3 = derivative(StateIn+k2/2, parameters)*dt;
%     k4 = derivative(StateIn+k3, parameters)*dt;
%     StateOut = StateIn + (1/6)*(k1 + 2*k2 + 2*k3 + k4);
    

end


function dState = derivative(State, beta, gamma, N)


    S = State(1); % Suceptible
    I = State(2); % Infective
    R = State(3); % Recovered
    

    % SIR model 
    dS = -beta*I*S/N;
    dI = beta*I*S/N - gamma*I;
    dR = gamma*I;
    
    dState = [dS; dI; dR];

end