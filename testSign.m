rng('default');

n = 8;
m = 3;
p = 2;

A = randn(n);
B = randn(n, m);
C = randn(p, n);

quad = quadFromABC(A, B, C);

M = quasidefiniteMatrixFromQuad(quad);

J = [zeros(n) eye(n); -eye(n) zeros(n)];

quadI = quadJInverseJ(quad);

assert(all(quad.p == quadI.p));

MM = quasidefiniteMatrixFromQuad(quadI);
assert(norm(MM - J*inv(M)*J) / norm(MM) < sqrt(eps));

quadSum = signOneIteration(quad);

assertAlmostEqual(1/2*(M + MM), quasidefiniteMatrixFromQuad(quadSum));
