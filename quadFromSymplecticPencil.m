function quad = quadFromSymplecticPencil(A, E)
% create a quad object from a symplectic matrix/pencil
%
% the pencil is A-lambda*E, with E defaulting to the identity matrix

n = size(A) / 2;
if not(exist('E', 'var'))
    E = eye(n);
end

% "block magic formula"
M = [E(:, 1:n) A(:, n+1:end)] \ [A(:, 1:n) E(:, n+1:end)];

A = M(1:n, 1:n);
B = symmetricFactorization(M(1:n, n+1:end));
C = symmetricFactorization(-M(n+1:end, 1:n))';

assertAlmostEqual(A, M(n+1:end,n+1:end)');

quad = quadFromABC(A, B, C);