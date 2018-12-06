function quad = quadFromQuad(quad, newp, newdimensions)
% computes a specific PPT in quad form (even when the matrix to invert is ill-conditioned)

% build arrays that tell which indices in the initial and final matrix are PPTed in


% TODO: see if one can optimize these indexing operations
    
newIn = false(size(newp));
newIn(newp(1:newdimensions(1))) = true;

oldIn = false(size(quad.p));
oldIn(quad.p(1:quad.dimensions(1))) = true;

toInsert = find(newIn & ~oldIn);
toRemove = find(oldIn & ~newIn);

% indices to insert/remove from the PPT inside the matrix M
toInsertIndexInM = ismember(quad.p, toInsert);
toRemoveIndexInM = ismember(quad.p, toRemove);

while sum(toInsertIndexInM) + sum(toRemoveIndexInM) > 0
    
    % TODO: naive choice for now, does not take into account stability
    if sum(toInsertIndexInM) > 0
        index = find(toInsertIndexInM, 1, 'first');
        j = index - quad.dimensions(1);
        quad = updateQuadBasisIn(quad, j);
    else
        i = find(toRemoveIndexInM, 1, 'first');
        quad = updateQuadBasisOut(quad, i);
    end
  
    % since the indexing changed, we need to repeat the whole thing.
    % TODO: refactor/optimize
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

1;