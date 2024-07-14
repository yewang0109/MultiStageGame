function DG_P = DG_Uncertain_Structured(G, beta,delta, b, c, sta)
   % Calculate the payoff of each individual can provide
    DG_P = -c* sta.* sum(G, 2) + b*(1-delta)/(1-delta*beta)*(G * sta);
end
