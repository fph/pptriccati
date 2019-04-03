function quadO = quadOpposite(quad)
% computes the opposite (i.e., -X) of quasidefiniteMatrixFromQuad(quad)
% Should satisfy the identity quasidefiniteMatrixFromQuad(quad) +
% quasidefiniteMatrixFromQuad(quadO) = 0.

n1 = quad.dimensions(1);
n2 = quad.dimensions(2);

quadO.p = [quad.p(n1+1:end) quad.p(1:n1)];
quadO.dimensions = [n2 n1];

A = quad.X(1:n1, end-n2+1:end);
B = quad.X(1:n1, 1:end-n2);
C = quad.X(n1+1:end, end-n2+1:end);
quadO.X = [C' -A'; zeros(size(B,2), size(C,1)) B'];