function [M, i, j] = maxMatrix(A)
% returns the maximum entry in a matrix, and its location

[colmaxes, is] = max(A,[],1);
[M,j] = max(colmaxes,[],2);
i = is(j);