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

G = M(1:n, n+1:end);
Q = -M(n+1:end, 1:n);

assertAlmostEqual(G, G');
assertAlmostEqual(Q, Q');

G = 1/2*(G + G');
Q = 1/2*(Q + Q');

A = M(1:n, 1:n);
B = symmetricFactorization(G);
C = symmetricFactorization(Q)';

assertAlmostEqual(A, M(n+1:end,n+1:end)');

quad = quadFromABC(A, B, C);