function quad = quadFromQuad(quad, newp, newdimensions)
% computes a specific PPT in quad form (even when the matrix to invert is ill-conditioned)

% build arrays that tell which indices in the initial and final matrix are PPTed in


% TODO: see if one can optimize these indexing operations

n1 = quad.dimensions(1);
n2 = quad.dimensions(2);

newIn = false(size(newp));
newIn(newp(1:newdimensions(1))) = true;

oldIn = false(size(quad.p));
oldIn(quad.p(1:n1)) = true;

toInsert = find(newIn & ~oldIn);
toRemove = find(oldIn & ~newIn);

% indices to insert/remove from the PPT inside the matrix M
toInsertIndexInM = ismember(quad.p, toInsert);
toRemoveIndexInM = ismember(quad.p, toRemove);

while sum(toInsertIndexInM) + sum(toRemoveIndexInM) > 0
    n1 = quad.dimensions(1);
    % Bunch-Parlett-style pivoting
    I = optimalPivotQuad(quad, toInsertIndexInM | toRemoveIndexInM);
    if length(I) == 2
        quad = updateQuadBasisInOut(quad, I(1), I(2)-n1);
    else
        if I <= n1
            quad = updateQuadBasisOut(quad, I);
        else
            quad = updateQuadBasisIn(quad, I-n1);
        end
    end
    
    % since the indexing changed, we need to repeat the whole thing.
    % TODO: refactor/optimize all this stuff
    % probably, the best thing to do is first moving all the "active"
    % indices to the middle of the matrix, and then working on them one by
    % one in the same function. In this way we can also reuse the zeros
    % created in the previous steps...
    newIn = false(size(newp));
    newIn(newp(1:newdimensions(1))) = true;
    
    oldIn = false(size(quad.p));
    oldIn(quad.p(1:quad.dimensions(1))) = true;
    
    toInsert = find(newIn & ~oldIn);
    toRemove = find(oldIn & ~newIn);
    
    % indices to insert/remove from the PPT inside the matrix M
    toInsertIndexInM = ismember(quad.p, toInsert);
    toRemoveIndexInM = ismember(quad.p, toRemove);

end

% now the two "In" and "Out" set are equals; we just have to reorder
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

1;