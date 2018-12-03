rng('default');

n = 9;

for trie = 1:200
    quad = randomQuadBasis(n);
    if size(quad.X,1) == quad.dimensions(1)
        % this swap does not make sense; C is the empty matrix and the
        % possible pivot is null
        continue
    end
    
    j = randi([1, quad.dimensions(2)]);
        
    quad2 = updateQuadBasisIn(quad, j);
    assert(subspace(positiveLagrangianSubspaceFromQuadBasis(quad), positiveLagrangianSubspaceFromQuadBasis(quad2)) < sqrt(eps));
end

for trie = 1:200
    quad = randomQuadBasis(n);
    if size(quad.X,2) == quad.dimensions(2)
        % this swap does not make sense; B is the empty matrix and the
        % possible pivot is null
        continue
    end
    i = randi([1, quad.dimensions(1)]);
        
    quad2 = updateQuadBasisOut(quad, i);
    assert(subspace(positiveLagrangianSubspaceFromQuadBasis(quad), positiveLagrangianSubspaceFromQuadBasis(quad2)) < sqrt(eps));
end

for trie = 1:200
    quad = randomQuadBasis(n);
    if size(quad.X,2) == quad.dimensions(2) || size(quad.X,1) == quad.dimensions(1)
        % one among B,C is empty
        continue
    end
    i = randi([1, quad.dimensions(1)]);
    j = randi([1, quad.dimensions(2)]);
    
    quad2 = updateQuadBasisInOut(quad, i, j);
    
    assert(subspace(positiveLagrangianSubspaceFromQuadBasis(quad), positiveLagrangianSubspaceFromQuadBasis(quad2)) < sqrt(eps));
end
