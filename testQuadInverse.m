rng('default');

n = 16;

% [A, G, Q] = carex(5);
% B = symmetricFactorization(G);
% C = symmetricFactorization(Q)';
% quad = quadFromABC(A, B, C);

for trie = 1:100
    quad = randomQuadBasis(n);
    
    % test quadOpposite first
    
    quadO = quadOpposite(quad);
    X = quasidefiniteMatrixFromQuad(quad);
    OX = quasidefiniteMatrixFromQuad(quadO);
    assertAlmostEqual(-X, OX);
    
    if cond(X) < 1/sqrt(eps) %skips non-invertible tests        
        [quadI, thedet] = quadInverse(quad);
        X = quasidefiniteMatrixFromQuad(quad);
        IX = quasidefiniteMatrixFromQuad(quadI);
        assertAlmostEqual(inv(X), IX);
        assertAlmostEqual(thedet, det(X));
    end
end