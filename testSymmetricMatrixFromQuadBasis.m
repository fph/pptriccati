rng('default');

n = 8;

for trie = 1:100
    quad = randomQuadBasis(n, 'fullrank', true);
    X = symmetricMatrixFromQuadBasis(quad);
    assert(subspace(positiveLagrangianSubspaceFromQuadBasis(quad), [eye(n);X]) < sqrt(eps));
end