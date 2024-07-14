function DG_P = DG_Uncertain_WellMixed(beta, delta,b, c, N, sta, sta1, sta2, numbersta1)
    DG_P = zeros(N, 1);
    
    % Pre-compute some values that are used repeatedly in the loop
    factor1 = (numbersta1 - 1) / (N - 1);
    factor2 = (N - numbersta1) / (N - 1);
    factor3 = numbersta1 / (N - 1);
    factor4 = (N - numbersta1 - 1) / (N - 1);
    
    % Iterate through each individual in the population
    for i = 1:N
        if isequal(sta(i, :), sta1)
            DG_P(i) = -c * sta1 + factor1 * sta1*b*(1-delta)/(1-delta*beta) + factor2 * sta2*b*(1-delta)/(1-delta*beta);
        else
            DG_P(i) = -c * sta2 + factor3 * sta1*b*(1-delta)/(1-delta*beta) + factor4 * sta2*b*(1-delta)/(1-delta*beta);
        end
    end
end
