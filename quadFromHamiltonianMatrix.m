function quad = quadFromHamiltonianMatrix(H)
% creates a quadBasis from a Hamiltonian matrix

n = length(H) / 2;

A = H(1:n, 1:n);
B = symmetricFactorization(-H(1:n, n+1:end));
C = symmetricFactorization(-H(n+1:end, 1:n))';

quad = quadFromABC(A, B, C);