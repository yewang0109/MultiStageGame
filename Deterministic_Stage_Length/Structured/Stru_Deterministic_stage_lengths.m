clear; clc;
close all;

% Initialize parameters
N = 100;               % Population size
beta = 1.1;            % Synergy factor
k = 4;                 % Degree
c = 1;                 % Cost of cooperation
w = 0.01;              % Selection strength
mu = 10^(-4);          % Mutation rate
L = 1;                 % Number of partitations
M = 1;                 % Number of stages
stra_matrix = GenerateStraMatrix(L, M); % Generate strategy matrix
T = 10^7;              % Total time steps
proportion=zeros(1,6); % Initialize cooperation proportion array
Gr=createRandRegGraph(N,k);
Gr=full(Gr);           % build up random-regular graph

% Parallel simulations for different baseline benefit values
parfor times=1:6
    b=2+times*0.75;        % Initialize baseline benefit value
    B = beta.^(0:M-1) * b; % Initialize benefit vector
    coop = 0;              % Initialize cooperation level
    for cont = 1:500       % Repeat simulations
        pre_stra = zeros(T, M); % Record strategies at each time step
        indices = randi((L+1)^M, N, 1); 
        sta = stra_matrix(indices, :); % Randomly assign strategies to population
        con = 0;           % Counter for time steps in homogeneous states

        for t = 1:T        % Iterate through time steps
            numbersta1 = sum(all(sta == sta(1, :), 2));
            sta1 = sta(1, :);
            sta2 = sta(find(~all(sta == sta1, 2), 1, 'first'), :);

            if allRowsEqual(sta) == 1
                pre_stra(t, :) = sta1; % Record the current homogeneous strategy
                con = con + 1;
                i = randi(N); % Randomly select an individual
                p = rand();   % Generate random probability
                if p < mu     % Mutation condition
                    sta(i, :) = stra_matrix(randi((L+1)^M), :);
                    if ~isequal(sta(i, :), sta1)
                        sta2 = sta(i, :);
                        numbersta1 = N - 1;
                        Pay = DG_Structured(Gr, B, c, sta);      % Calculate payoffs
                        sta = DB_Structured(Pay, Gr, N, sta, w); % Update strategies
                    end
                end
            else
                pre_stra(t, :) = zeros(1, M); % If not homogeneous, reset to zero
                Pay = DG_Structured(Gr, B, c, sta);
                sta = DB_Structured(Pay, Gr, N, sta, w);
            end
        end

        % Calculate cooperation proportion
        coop_pro = sum(sum(pre_stra, 2) ./ M) / con;
        coop = coop + coop_pro;
    end

    % Final average cooperation level
    proportion(times)=coop / cont;
end
regular_pro_L_1_M_1=proportion;
