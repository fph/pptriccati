function quadReduced = quadCayley(quad, gamma)
% gives the factorized Cayley transform of hamiltonianMatrixFromQuad(quad)

if not(exist('gamma', 'var'))
    gamma = 1;
end

assert(quad.dimensions(1) == quad.dimensions(2));
assert(all(quad.p == 1:sum(quad.dimensions)));

[A, B, C] = ABCFromQuad(quad);

n = quad.dimensions(1);

BB = [zeros(n, size(B,2)); B];
CC= [zeros(size(C,1), n) C];
AA = [eye(n) sqrt(2*gamma)*eye(n); -sqrt(2*gamma)*eye(n) A - gamma*eye(n)];

quadDoubled = quadFromABC(AA, BB, CC);

newp = [1:n 3*n+1:4*n 2*n+1:3*n n+1:2*n];
newdimensions = [2*n 2*n];

quadC = quadFromQuad(quadDoubled, newp, newdimensions);

quadReduced.X = quadC.X([1:n, 2*n+1:end], [1:end-n]);
quadReduced.p = [1:2*n];
quadReduced.dimensions = [n n];

%symReduced = symFromQuad(quadReduced);
%symReduced.X
%symC = symFromQuad(quadC);
%symC.X([1:n 2*n+1:3*n], [1:n 2*n+1:3*n])
%symC.X
