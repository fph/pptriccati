rng('default');

for trie = 1:100
    
    quad = randomQuadBasis(7, 'rB', 37, 'rC', 42);
    
    quadT = quadTruncate(quad);
    
    assert(subspace(positiveLagrangianSubspaceFromQuadBasis(quad), positiveLagrangianSubspaceFromQuadBasis(quadT)) < sqrt(eps));
    
end