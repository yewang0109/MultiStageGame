function DG_P = DG_Transition_Structured_New(G, N, sta, sta1, sta2, repeated_pay,stra_matrix)
    % Pre-compute factors
    factor1 = G * ((sta(:, 1) == sta1(1)) & (sta(:, 2) == sta1(2)));
    factor2 = zeros(N, 1);
    if ~isempty(sta2) && ~isequal(sta2, sta1)
        factor2 = G *((sta(:, 1) == sta2(1)) & (sta(:, 2) == sta2(2)));
    end

    % Find row indices for sta1 and sta2
    is_equal1 = ismember(stra_matrix, sta1, 'rows');
    row_indices1 = find(is_equal1);
    is_equal2 = ismember(stra_matrix, sta2, 'rows');
    row_indices2 = find(is_equal2);

    % Calculate DG_P using vectorized operations
    term1 = repeated_pay(row_indices1, row_indices1);
    term2 = repeated_pay(row_indices1, row_indices2);
    term3 = repeated_pay(row_indices2, row_indices1);
    term4 = repeated_pay(row_indices2, row_indices2);

    DG_P = zeros(N, 1);
    for i = 1:N
        if isequal(sta(i, :), sta1)
            DG_P(i) = factor1(i) * term1 + factor2(i) * term2;
        else
            DG_P(i) = factor1(i) * term3 + factor2(i) * term4;
        end
    end
end