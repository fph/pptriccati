rng('default');

n = 9;

for trie = 1:100  
    quad = randomQuadBasis(n, 'fullrank', true);
    
    in = logical(randi([0,1], 1, n));
    out = logical(randi([0,1], 1, n));
    out = out & ~in; %makes sure the two masks do not overlap
    
    quad2 = quadSpecifyIndices(quad, in, out);
    
    assert(subspace(positiveLagrangianSubspaceFromQuadBasis(quad), positiveLagrangianSubspaceFromQuadBasis(quad2)) < sqrt(eps));
    
    inMask = false(1, n); inMask(1:quad2.dimensions(1)) = true;
    
    assert(all(in(quad2.p) <= inMask));
    assert(all(out(quad2.p) <= ~inMask));
    
    quad2alt = quadSpecifyIndices(quad, find(in), find(out)); %makes sure both syntaxes work
    
    assert(subspace(positiveLagrangianSubspaceFromQuadBasis(quad), positiveLagrangianSubspaceFromQuadBasis(quad2alt)) < sqrt(eps));
    assert(all(in(quad2alt.p) <= inMask));
    assert(all(out(quad2alt.p) <= ~inMask));
end