function DG_P = DG_Dependent_WellMixed_New(N, sta, sta1, sta2, repeated_pay, stra_matrix, numbersta1)
    DG_P = zeros(N, 1);
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
    % Pre-compute factors
    factor1 = (numbersta1 - 1) / (N - 1);
    factor2 = (N - numbersta1) / (N - 1);
    factor3 = numbersta1 / (N - 1);
    factor4 = (N - numbersta1 - 1) / (N - 1);

    % Iterate through each individual in the population
    for i = 1:N
        if isequal(sta(i, :), sta1)
            DG_P(i) = factor1 * term1 + factor2 * term2;
        else
            DG_P(i) = factor3 * term3 + factor4 * term4;
        end
    end
end