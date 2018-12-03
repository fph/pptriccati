rng('default');

rng(2); % TODO: remove, to get a better initial case for development

n = 5;

for i = 1:100
    quad = randomQuadBasis(5);
    if size(quad.X,1) == quad.dimensions(1)
        % this swap does not make sense; C is the empty matrix and the
        % possible pivot is null
        continue
    end
    
    j = randi([1, quad.dimensions(2)]);
        
    quad2 = updateQuadBasisIn(quad, j);
    assert(subspace(positiveLagrangianSubspaceFromQuadBasis(quad), positiveLagrangianSubspaceFromQuadBasis(quad2)) < sqrt(eps));
end