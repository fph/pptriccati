function quad = quadSpecifyIndices(quad, inIndices, outIndices)
% modifies a PPT so that a few specific indices are in or out
%
% quad = quadSpecifyIndices(quad, inIndices, outIndices)
%
% return an equivalent PPT such that inIndices are inside the PPT set and
% outIndices are outside it.
% inIndices, outIndices are indices in the original matrix

% we make no other changes at the moment

% mnemonic for the permutation: if quad.p(i) contains k, then quad.X(i, :)
% contains the kth row of PPT(original matrix M). i.e., M(p,p) = quad.X

n1 = quad.dimensions(1);
n2 = quad.dimensions(2);

inIndicesMask = false(1, n1+n2);
inIndicesMask(inIndices) = true;
inIndicesMask = inIndicesMask(quad.p); % converts the mask to "quad.X ordering"

outIndicesMask = false(1, n1+n2);
outIndicesMask(outIndices) = true;
outIndicesMask = outIndicesMask(quad.p);

currentlyIn = false(1, n1+n2); currentlyIn(1:n1) = true;

toInsert = inIndicesMask & ~currentlyIn;
toRemove = outIndicesMask & currentlyIn;
stayingIn = currentlyIn & ~toRemove;
stayingOut = ~currentlyIn & ~toInsert;

p = [find(stayingIn) find(toRemove) find(toInsert) find(stayingOut)];

quad.X(1:n1,:) = quad.X(p(1:n1),:);
quad.X(:,end-n2+1:end) = quad.X(:, end-n2+p(n1+1:end)-n1);

quad.p = quad.p(p);

% now all indices to remove are in the last part of 1:n1, and all those to
% insert are in the first part of n1+1:end
% TODO: we're probably not using this property now, but it may come useful
% in future, and it clusters stuff anyway

toSwap = false(1, n1+n2);
toSwap(n1-sum(toRemove)+1 : n1+sum(toInsert)) = true;

while any(toSwap)
    n1 = quad.dimensions(1);
    n2 = quad.dimensions(2);
    I = optimalPivotQuad(quad, toSwap);
    if length(I) == 2
        quad = updateQuadBasisInOut(quad, I(1), I(2)-n1);
        toSwap([I(1) n1]) = toSwap([n1 I(1)]);
        toSwap(n1) = false;
        toSwap([I(2), n1+1]) = toSwap([n1+1, I(2)]);
        toSwap(n1+1) = false;        
    elseif I <= n1
        quad = updateQuadBasisOut(quad, I);
        toSwap([I n1]) = toSwap([n1 I]);
        toSwap(n1) = false;
    else
        quad = updateQuadBasisIn(quad, I-n1);      
        toSwap([I, n1+1]) = toSwap([n1+1, I]);
        toSwap(n1+1) = false;
    end
end
