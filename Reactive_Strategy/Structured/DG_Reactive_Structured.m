function DG_P = DG_Reactive_Structured(G, beta, delta,b, c, N, sta, sta1, sta2)
     DG_P = zeros(N, 1);
    
    % Pre-compute stationary distributions
    distribution11 = Stationary_Distribution(sta1(1), sta1(2), sta1(1), sta1(2));
    distribution12 = Stationary_Distribution(sta1(1), sta1(2), sta2(1), sta2(2));
    distribution21 = Stationary_Distribution(sta2(1), sta2(2), sta1(1), sta1(2));
    distribution22 = Stationary_Distribution(sta2(1), sta2(2), sta2(1), sta2(2));

    % Pre-compute factors
    factor1 = G * ((sta(:, 1) == sta1(1)) & (sta(:, 2) == sta1(2)));
    factor2 = zeros(N, 1);
    if ~isempty(sta2) && ~isequal(sta2, sta1)
        factor2 = G *((sta(:, 1) == sta2(1)) & (sta(:, 2) == sta2(2)));
    end

    % Iterate through each individual in the population
    for i = 1:N
        if isequal(sta(i, :), sta1)
            term1 = b * (distribution11(1) + distribution11(3)) * (1 - delta) / (1 - delta * beta) - c * (distribution11(1) + distribution11(2));
            term2 = b * (distribution12(1) + distribution12(3)) * (1 - delta) / (1 - delta * beta) - c * (distribution12(1) + distribution12(2));
            DG_P(i) = factor1(i) * term1 + factor2(i) * term2;
        else
            term3 = b * (distribution21(1) + distribution21(3)) * (1 - delta) / (1 - delta * beta) - c * (distribution21(1) + distribution21(2));
            term4 = b * (distribution22(1) + distribution22(3)) * (1 - delta) / (1 - delta * beta) - c * (distribution22(1) + distribution22(2));
            DG_P(i) = factor1(i) * term3 + factor2(i) * term4;
        end
    end
end