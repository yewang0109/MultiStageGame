function sta_up = DB_WellMixed_multiple(P, N, sta, w)
    sta_up = sta;
    i = unidrnd(N); % Randomly select an individual
    fitness = 1 - w + w .* P; % Compute fitness
    pro = rand(); % Generate a random probability
    G = ones(N, N) - eye(N); % Create G matrix with zeros on the diagonal
    % Calculate cumulative fitness of neighbors
    neighbor_fitness = G(i, :) .* fitness';
    cum_neighbor_fitness = cumsum(neighbor_fitness) / sum(neighbor_fitness);

    % Find the neighbor to switch to
    switch_to = find(cum_neighbor_fitness > pro, 1);

    % Update the strategy
    sta_up(i,:) = sta(switch_to,:);
end
