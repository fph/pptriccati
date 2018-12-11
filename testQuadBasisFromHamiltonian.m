rng('default');

for trie = 1:100
    n = 5;
    A = randn(n);
    B = randn(n,3);
    C = randn(2,n);
    
    quad1 = quadFromABC(A,B,C);
    H = [A -B*B'; -C'*C -A'];
    
    quad2 = quadFromHamiltonianMatrix(H);
    
    assertAlmostEqual(H, hamiltonianMatrixFromQuad(quad1));
    assertAlmostEqual(H, hamiltonianMatrixFromQuad(quad2));
    assert(subspace(positiveLagrangianSubspaceFromQuadBasis(quad1), positiveLagrangianSubspaceFromQuadBasis(quad2)) < sqrt(eps));
end