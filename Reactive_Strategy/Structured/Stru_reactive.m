clear; clc;
close all;

% Initialize parameters
N = 100;                 % Population size
beta = 1.1;              % Synergy factor
delta=0.8;               % Continuation probability
k = 4;                   % Degree
c = 1;                   % Cost of cooperation
w = 0.01;                % Selection strength
mu = 10^(-4);            % Mutation rate
L = 3;                   % Number of partitations
MS = 2;           
stra_matrix = GenerateReactiveStraMatrix(L, MS); % Generate strategy matrix
Cooperate_Rate = zeros((L-1)^MS,1); 
T = 10^7;                % Total time steps
proportion = zeros(1,5); % Initialize cooperation proportion array
Gr = createRandRegGraph(N,k);
Gr = full(Gr);           % Build up random-regular graph

for i=1:(L-1)^MS
    Cooperate_Rate(i)=Self_Cooperation(stra_matrix(i,1),stra_matrix(i,2));
end

% Parallel simulations for different baseline benefit values
parfor times = 1:5
    b = 1.25+(times-1)*0.75; % Initialize baseline benefit value
    coop = 0;                % Initialize cooperation level
    for cont = 1:500         % Repeat simulations
        indices = randi((L-1)^MS,N,1);
        sta = stra_matrix(indices,:); % Randomly assign strategies to population
        con = 0;             % Counter for cooperation calculations
        tt = 0;
        % Simulation until all individuals adopt the same strategy
        while allRowsEqual(sta) ~= 1
            Pay = DG_Reactive_Structured_multiple(Gr, beta, delta,b, c, N, sta); % Calculate payoffs
            sta = DB_Structured(Pay, Gr, N, sta, w); % Update strategies
            tt=tt+1;
        end
        pre_stra = zeros(T-tt, 1); % Record strategies at each time step
        for t = 1:T-tt             % Iterate through time steps
            numbersta1 = sum(all(sta == sta(1, :), 2)); 
            sta1 = sta(1, :);  
            sta2 = sta(find(~all(sta == sta1, 2), 1, 'first'), :); 

            if allRowsEqual(sta) == 1
                pre_stra(t) = Cooperate_Rate(find(all(stra_matrix == sta1, 2), 2)); % Record the cooperation rate of the current homogeneous strategy
                con = con + 1;
                i = randi(N); % Randomly select an individual
                p = rand();   % Generate random probability
                if p < mu     % Mutation condition
                    sta(i, :) = stra_matrix(randi((L-1)^MS), :);
                    if ~isequal(sta(i, :), sta1)
                        sta2 = sta(i, :);
                        numbersta1 = N - 1;
                        Pay = DG_Reactive_Structured(Gr, beta, delta,b, c, N, sta, sta1, sta2); % Calculate payoffs
                        sta = DB_Structured(Pay, Gr, N, sta, w); % Update strategies
                    end
                end
            else
                pre_stra(t) = 0;
                Pay = DG_Reactive_Structured(Gr, beta, delta,b, c, N, sta, sta1, sta2);
                sta = DB_Structured(Pay, Gr, N, sta, w);
            end
        end

        % Calculate cooperation proportion
        coop_pro = sum(pre_stra) / con;
        coop = coop + coop_pro;
    end

    % Final average cooperation level
    proportion(times) = coop / cont;
end
reactive_regular_pro_positive = proportion;