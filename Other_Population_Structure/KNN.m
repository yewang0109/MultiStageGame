function h = KNN(N,K)
% h = KNN(N,K) returns a KNN graph with N
% nodes, N*K edges, mean node degree 2*K.

% Connect each node to its K next and previous neighbors. This constructs
% indices for a ring lattice.
s = repelem((1:N)',1,K);
t = s + repmat(1:K,N,1);
t = mod(t-1,N)+1;
h = graph(s,t);
end