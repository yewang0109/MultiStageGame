function DG_P = DG_Structured(G, B, c, sta)
   % Calculate the payoff of each individual can provide
    Sta_P = B * sta';
    % Calculate the cumulative payoff
    DG_P = -c * sum(sta, 2) .* sum(G, 2) + G * Sta_P';
end
