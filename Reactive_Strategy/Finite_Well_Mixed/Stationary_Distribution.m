function pi=Stationary_Distribution(p,q,f,g)
Tran_Matrix=[p*f p*(1-f) (1-p)*f (1-p)*(1-f);
    q*f q*(1-f) (1-q)*f (1-q)*(1-f);
    p*g p*(1-g) (1-p)*g (1-p)*(1-g);
    q*g q*(1-g) (1-q)*g (1-q)*(1-g)];
[V, D] = eig(Tran_Matrix'); % Calculate the eigenvectors and eigenvalues of the transpose of P
[~, idx] = max(diag(D)); % Find the index of the eigenvalue closest to 1
pi = V(:, idx)'; % Get the corresponding eigenvector
pi = pi / sum(pi); % Normalize the eigenvector to get the stationary distribution
end