function [A, B, C] = ABCFromQuad(quad)
% returns the block A, B, C of quad.X, ignoring the permutation

n1 = quad.dimensions(1);
n2 = quad.dimensions(2);

A = quad.X(1:n1, end-n2+1:end);
B = quad.X(1:n1, 1:end-n2);
C = quad.X(n1+1:end, end-n2+1:end);
