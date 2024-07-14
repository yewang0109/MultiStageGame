clear; clc;
close all;

% Initialize parameters
N = 100;               % Population size
beta = 1.1;            % Synergy factor
c = 1;                 % Cost of cooperation
w = 0.01;              % Selection strength
mu = 10^(-4);          % Mutation rate
L = 1;                 % Number of partitations
M = 1;                 % Number of stages
stra_matrix = GenerateStraMatrix(L, M); % Generate strategy matrix
T = 10^7;              % Total time steps
proportion=zeros(1,6); % Initialize cooperation proportion array

% Parallel simulations for different baseline benefit values
parfor times=1:6
    b=2+times*0.75;        % Initialize baseline benefit value
    B = beta.^(0:M-1) * b; % Initialize benefit vector
    coop = 0;              % Initialize cooperation level
    for cont = 1:500       % Repeat simulations
        indices = randi((L+1)^M, N, 1); 
        sta = stra_matrix(indices, :); % Randomly assign strategies to population
        con = 0;           % Counter for time steps in homogeneous states
        tt=0;
        % Simulation until all individuals adopt the same strategy
        while allRowsEqual(sta) ~= 1
            Pay = DG_Deterministic_WellMixed_multiple(B, c, N, sta,stra_matrix,M,L); % Calculate payoffs
            % Use DG_Deterministic_WellMixed_multiple_large(B, c, N, sta) when (L+1)^M>N
            sta = DB_WellMixed_multiple(Pay, N, sta, w); % Update strategies
            tt=tt+1;
        end
        pre_stra = zeros(T-tt, M); % Record strategies at homogeneous states
        for t = 1:T-tt % Iterate through time steps
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
                        Pay = DG_WellMixed(B, c, N, sta, sta1, sta2, numbersta1);   % Calculate payoffs
                        sta = DB_WellMixed(Pay, N, sta, w, sta1, sta2, numbersta1); % Update strategies
                    end
                end
            else
                pre_stra(t, :) = zeros(1, M); % If not homogeneous, reset to zero
                Pay = DG_WellMixed(B, c, N, sta, sta1, sta2, numbersta1);
                sta = DB_WellMixed(Pay, N, sta, w, sta1, sta2, numbersta1);
            end
        end

        % Calculate cooperation proportion
        coop_pro = sum(sum(pre_stra, 2) ./ M) / con;
        coop = coop + coop_pro;
    end
    % Final average cooperation level
    proportion(times)=coop / cont;
end
pro_L_1_M_1=proportion;