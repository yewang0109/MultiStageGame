function DG_P = DG_Reactive_Structured_multiple(G, beta, delta,b, c, N, sta)
DG_P = zeros(N, 1);
for i = 1:N
    for j=i:N
        if G(i,j)==1
            sta1=sta(i,:);
            sta2=sta(j,:);
            distribution_1 = Stationary_Distribution(sta1(1), sta1(2), sta2(1), sta2(2));
            distribution_2 = Stationary_Distribution(sta2(1), sta2(2), sta1(1), sta1(2));
            DG_P(i)=DG_P(i)+b * (distribution_1(1) + distribution_1(3)) * (1 - delta) / (1 - delta * beta) - c * (distribution_1(1) + distribution_1(2));
            DG_P(j)=DG_P(j)+b * (distribution_2(1) + distribution_2(3)) * (1 - delta) / (1 - delta * beta) - c * (distribution_2(1) + distribution_2(2));
        end
    end
end
