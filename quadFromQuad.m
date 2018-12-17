function quad = quadFromQuad(quad, newp, newdimensions)
% computes a specific PPT in quad form (even when the matrix to invert is ill-conditioned)

% build arrays that tell which indices in the initial and final matrix are PPTed in

newIn = false(size(newp));
newIn(newp(1:newdimensions(1))) = true;

quad = quadSpecifyIndices(quad, newIn, ~newIn);

% now the "In" and "Out" sets are as specified; we just have to reorder
% their entries.

n1 = newdimensions(1);
n2 = newdimensions(2);

p = 1:n1+n2;
p(quad.p) = p;
p = p(newp);
% p now is the permutation that sends quad.p into newp

quad.X(1:n1,:) = quad.X(p(1:n1),:);
quad.X(:,end-n2+1:end) = quad.X(:, end-n2+p(n1+1:end)-n1);

quad.p = newp;
