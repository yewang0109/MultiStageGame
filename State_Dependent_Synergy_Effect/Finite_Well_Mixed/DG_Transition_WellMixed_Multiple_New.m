function DG_P = DG_Transition_WellMixed_Multiple_New(N, sta,stra_matrix,M,L,repeated_pay)
DG_P = zeros(N, 1);
cont=zeros((L-1)^M,1);
P=zeros((L-1)^M,1);
for i=1:(L-1)^M
    is_equal = ismember(sta, stra_matrix(i,:), 'rows');
    cont(i)=sum(is_equal);
end
for i=1:(L-1)^M
    for j=1:(L-1)^M
        benefit=repeated_pay(i,j);
        if j~=i
            P(i)=P(i)+benefit*(cont(j))/(N-1);
        else
            P(i)=P(i)+benefit*(cont(j)-1)/(N-1);
        end
    end
end
for i = 1:N
    is_equal = ismember(stra_matrix, sta(i,:), 'rows');
    row_indices = find(is_equal);
    DG_P(i) = P(row_indices);
end
end
