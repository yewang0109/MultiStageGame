function DG_P = DG_WellMixed(B, c, N, sta, sta1, sta2, numbersta1)
    DG_P = zeros(N, 1);
    
    % Pre-compute some values that are used repeatedly in the loop
    sum_sta1 = sum(sta1);
    sum_sta2 = sum(sta2);
    sum_B_sta1 = sum(B .* sta1);
    sum_B_sta2 = sum(B .* sta2);
    factor1 = (numbersta1 - 1) / (N - 1);
    factor2 = (N - numbersta1) / (N - 1);
    factor3 = numbersta1 / (N - 1);
    factor4 = (N - numbersta1 - 1) / (N - 1);
    
    % Iterate through each individual in the population
    for i = 1:N
        if isequal(sta(i, :), sta1)
            DG_P(i) = -c * sum_sta1 + factor1 * sum_B_sta1 + factor2 * sum_B_sta2;
        else
            DG_P(i) = -c * sum_sta2 + factor3 * sum_B_sta1 + factor4 * sum_B_sta2;
        end
    end
end
