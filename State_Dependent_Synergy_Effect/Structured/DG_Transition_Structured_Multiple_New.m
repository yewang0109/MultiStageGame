function DG_P = DG_Transition_Structured_Multiple_New(G, N, sta,repeated_pay,stra_matrix)
DG_P = zeros(N, 1);
for i = 1:N
    for j=i:N
        if G(i,j)==1
            sta1=sta(i,:);
            sta2=sta(j,:);
            is_equal1 = ismember(stra_matrix, sta1, 'rows');
            row_indices1 = find(is_equal1);
            is_equal2 = ismember(stra_matrix, sta2, 'rows');
            row_indices2 = find(is_equal2);
            DG_P(i)=DG_P(i)+repeated_pay(row_indices1, row_indices2);
            DG_P(j)=DG_P(j)+repeated_pay(row_indices2, row_indices1);
        end
    end
end
