function sta_up = DB_WellMixed_multiple(P, N, sta, w)
    sta_up = sta;
    i = unidrnd(N); % Randomly select an individual
    fitness = 1 - w + w .* P; % Compute fitness
    pro = rand(); 
    G = ones(N, N) - eye(N); 
    neighbor_fitness = G(i, :) .* fitness'; % Calculate cumulative fitness of neighbors
    cum_neighbor_fitness = cumsum(neighbor_fitness) / sum(neighbor_fitness);

    % Find the neighbor to switch to
    switch_to = find(cum_neighbor_fitness > pro, 1);

    % Update the strategy
    sta_up(i,:) = sta(switch_to,:);
end
