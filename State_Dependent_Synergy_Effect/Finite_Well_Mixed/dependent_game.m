function expected_payoff = dependent_game(strategy1, strategy2, b, c, beta, delta, T,num)
beta_1=beta(1);
beta_0=beta(2);
beta_2=beta(3);
expected_payoff=zeros(1,2);
for cont=1:num
coop_probs = [0.5, 0.5]; 
payoff = (zeros(T, 2));
actions=[rand()<coop_probs(1), rand()<coop_probs(2)];
B=(zeros(T,1));
B(1)=b;
for t = 1:T
    for i=1:2
        payoff(t, i) = delta^(t-1)*(B(t)*actions(3-i)-c*actions(i));
    end
    if actions(1)==1 && actions(2)==1
        B(t+1)=beta_1*B(t);
        coop_probs = [strategy1(1), strategy2(1)];
    elseif actions(1)==0 && actions(2)==0
        B(t+1)=beta_2*B(t);
        coop_probs = [strategy1(2), strategy2(2)];
    else
        B(t+1)=beta_0*B(t);
        if actions(1)==0 && actions(2)==1
            coop_probs = [strategy1(1), strategy2(2)];
        else
            coop_probs = [strategy1(2), strategy2(1)];
        end
    end
    actions=[rand()<coop_probs(1), rand()<coop_probs(2)];
end
payoff=(1-delta).*payoff;
payoff=sum(payoff,1);
expected_payoff=expected_payoff+payoff;
end
expected_payoff=expected_payoff/num;
end