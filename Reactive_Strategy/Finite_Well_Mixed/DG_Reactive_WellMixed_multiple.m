function DG_P = DG_Reactive_WellMixed_multiple(beta, delta,b, c, N, sta,stra_matrix,M,L)
DG_P = zeros(N, 1);
cont=zeros((L-1)^M,1);
P=zeros((L-1)^M,1);
for i=1:(L-1)^M
    is_equal = ismember(sta, stra_matrix(i,:), 'rows');
    cont(i)=sum(is_equal);
end
for i=1:(L-1)^M
    sta1=stra_matrix(i,:);
    for j=1:(L-1)^M
        sta2=stra_matrix(j,:);
        distribution_1 = Stationary_Distribution(sta1(1), sta1(2), sta2(1), sta2(2));
        if j~=i
            P(i)=P(i)+(b * (distribution_1(1) + distribution_1(3)) * (1 - delta) / (1 - delta * beta) - c * (distribution_1(1) + distribution_1(2)))*(cont(j))/(N-1);
        else
            P(i)=P(i)+(b * (distribution_1(1) + distribution_1(3)) * (1 - delta) / (1 - delta * beta) - c * (distribution_1(1) + distribution_1(2)))*(cont(j)-1)/(N-1);
        end
    end
end
for i = 1:N
    is_equal = ismember(stra_matrix, sta(i,:), 'rows');
    row_indices = find(is_equal);
    DG_P(i) = P(row_indices);
end
end
