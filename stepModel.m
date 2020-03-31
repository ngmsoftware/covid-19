function StateOut = stepModel(StateIn, parameters, dt)

    % Euler
     StateOut = StateIn + derivative(StateIn, parameters)*dt;
    
    
    % RK
%     k1 = derivative(StateIn, parameters)*dt;
%     k2 = derivative(StateIn+k1/2, parameters)*dt;
%     k3 = derivative(StateIn+k2/2, parameters)*dt;
%     k4 = derivative(StateIn+k3, parameters)*dt;
%     StateOut = StateIn + (1/6)*(k1 + 2*k2 + 2*k3 + k4);
    

end


function dState = derivative(State, parameters)

    beta = parameters(1);     % Infection rate
    alpha = parameters(2);    % protection rate
    gamma = parameters(3);    % average latent time
    delta = parameters(4);    % average quarentine time
    lambda = parameters(5);   % cure rate
    kappa = parameters(6);    % mortality rate
    N = parameters(7);        % population 

    S = State(1); % Suceptible
    E = State(2); % Exposed 
    I = State(3); % Infective
    Q = State(4); % Quarentined
    R = State(5); % Recovered
    D = State(6); % Death
    P = State(7); % Insuceptible
    

    % SIR model 
    dS = -beta*I*S/N;
    dE = 0;
    dI = beta*I*S/N - gamma*I;
    dQ = 0;
    dR = gamma*I;
    dP = 0;
    dD = 0;    
    
    % SEIR model 
%     dS = -beta*S*I/N;
%     dE = beta*S*I/N - gamma*E;
%     dI = gamma*E - delta*I;
%     dQ = delta*I;
%     dR = 0;
%     dP = 0;
%     dD = 0;
    

    % COVID-19 model
%     dS = -beta*S*I/N - alpha*S;
%     dE = beta*S*I/N - gamma*E;
%     dI = gamma*E - delta*I;
%     dQ = delta*I - lambda*Q - kappa*Q;
%     dR = lambda*Q;
%     dP = kappa*Q;
%     dD = alpha*S;

    dState = [dS; dE; dI; dQ; dR; dP; dD];

end