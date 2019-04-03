function sym = symFromQuad(quad)
% creates a 'symBasis', i.e., an object representing a PPT in non-factored form, from a factored quadBasis

sym.p = quad.p;
sym.dimensions = quad.dimensions;

n1 = quad.dimensions(1);
n2 = quad.dimensions(2);

A = quad.X(1:n1, end-n2+1:end);
B = quad.X(1:n1, 1:end-n2);
C = quad.X(n1+1:end, end-n2+1:end);

sym.X = [-B*B' A; A' C'*C];