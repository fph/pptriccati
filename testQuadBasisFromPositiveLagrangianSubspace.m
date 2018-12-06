rng('default');

n = 5;
X = randn(n); X = X*X';
U = [eye(n); X]; U = U * randn(n);

for trie = 1:100    
    p = randperm(n);
    n1 = randi([0 n]);
    n2 = n - n1;
    quad = quadBasisFromPositiveLagrangianSubspace(U, p, [n1 n2]);
    UU = positiveLagrangianSubspaceFromQuadBasis(quad);
    assert(subspace(U, UU) < sqrt(eps(1)));
end