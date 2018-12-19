rng('default');

n = 7;

for trie = 1:100
    quad = randomQuadBasis(n, 'fullrank', true);
    kinds = randi([1,3], 1, n);
    subIndices = find(kinds==1);
    schurIndices = find(kinds==2);
    
    subIndices = subIndices(randperm(length(subIndices)));
    schurIndices = schurIndices(randperm(length(schurIndices)));
    
    quad2 = quadRemoveIndices(quad, subIndices, schurIndices);
    
    X = symmetricMatrixFromQuadBasis(quad);
    subIndices_logical = false(1, n); subIndices_logical(subIndices) = true;
    schurIndices_logical = false(1, n); schurIndices_logical(schurIndices) = true;
    X(~schurIndices_logical, ~schurIndices_logical) = X(~schurIndices_logical, ~schurIndices_logical) - X(~schurIndices_logical, schurIndices_logical) / X(schurIndices_logical, schurIndices_logical) * X(schurIndices_logical, ~schurIndices_logical);
    % we don't need to do the rest of the PPT since it will be removed anyway
    X = X(~(subIndices_logical | schurIndices_logical), ~(subIndices_logical | schurIndices_logical));
    
    assertAlmostEqual(symmetricMatrixFromQuadBasis(quad2), X);
end