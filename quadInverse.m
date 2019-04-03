function [quadI, logdet] = quadInverse(quad)
% computes the inverse of quasidefiniteMatrixFromQuad(quad)
% returns also its determinant

n1 = quad.dimensions(1);
n2 = quad.dimensions(2);

p = [quad.p(n1+1:end) quad.p(1:n1)];
dimensions = [n2 n1];

[quadI, logdet] = quadFromQuad(quad, p, dimensions);

% swap sign of A in quadI: recall that we have swapped dimensions, so n2
% ends up in the first index
quadI.X(1:n2, end-n1+1:end) = -quadI.X(1:n2, end-n1+1:end);

% now quadI contains *minus* the inverse
quadI = quadOpposite(quadI);