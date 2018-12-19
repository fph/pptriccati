function quad = quadRemoveIndices(quad, subIndices, schurIndices)
% removes specified indices from a matrix, given its quadBasis (hence
% computing a sort of combination of a submatrix and a Schur complement)
%
% function quad = quadRemoveIndices(quad, subIndices, schurIndices)
%
% subIndices, schurIndices contain the indices (vectors of positive integers or bitmasks) that should
% be removed, either in the form of a submatrix (i.e., while out of the PPT
% set) or a Schur complement (i.e., while inside the PPT set)

n1 = quad.dimensions(1);
n2 = quad.dimensions(2);

% makes sure subIndices, schurIndices are masks
subIndicesMask = false(1, n1+n2); subIndicesMask(subIndices) = true;
schurIndicesMask = false(1, n1+n2); schurIndicesMask(schurIndices) = true;

% adjusts the PPT so that the indices to remove have the right kind
quad = quadSpecifyIndices(quad, schurIndicesMask, subIndicesMask);

n1 = quad.dimensions(1);
n2 = quad.dimensions(2);

toRemove = (schurIndicesMask | subIndicesMask);
toRemove = toRemove(quad.p); % converts to quad.X ordering

rowsToKeep = [~toRemove(1:n1) true(1, size(quad.X,1)-n1)];
columnsToKeep = [true(1, size(quad.X,2)-n2) ~toRemove(n1+1:end)];

quad.X = quad.X(rowsToKeep, columnsToKeep);
% note that we may want to "recompress" the ranks of C'C and BB'. We do not
% do it here for now.

quad.dimensions = [quad.dimensions(1)-sum(toRemove(1:n1)), quad.dimensions(2)-sum(toRemove(n1+1:end))];

quad.p = quad.p(~toRemove);
% remap remaining indices to [1,n-sum(toRemove)]
[~, invp] = sort(quad.p);
quad.p(invp) = 1:sum(quad.dimensions);


