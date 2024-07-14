function sta_up = DB_WellMixed(P, N, sta, w, sta1, sta2, numbersta1)
    sta_up = sta;
    i = unidrnd(N); % Randomly select an individual
    fitness = 1 - w + w .* P; % Compute fitness
    pro = rand(); % Generate a random probability
    
    % Check if the selected individual has strategy sta1
    if isequal(sta_up(i, :), sta1)
        % Compute the probability of switching to sta2
        fitness1 = fitness(i) * (numbersta1 - 1) / (sum(fitness) - fitness(i));
        if pro >= fitness1
            sta_up(i, :) = sta2;
        end
    else
        % Compute the probability of switching to sta1
        fitness1 = fitness(i) * (N - numbersta1 - 1) / (sum(fitness) - fitness(i));
        if pro >= fitness1
            sta_up(i, :) = sta1;
        end
    end
end
