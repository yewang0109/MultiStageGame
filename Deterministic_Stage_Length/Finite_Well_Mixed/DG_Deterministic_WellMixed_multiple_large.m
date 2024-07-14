function DG_P = DG_Fixed_WellMixed_multiple_large(B, c, N, sta)
DG_P = zeros(N, 1);
for i=1:N
    sta1=sta(i,:);
    for j=1:N
        sta2=sta(j,:);    
        if j~=i
            DG_P(i)=DG_P(i)+(-c * sum(sta1) + sum(B .* sta2))/(N-1);
        end
    end
end
end
