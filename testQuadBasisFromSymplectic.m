rng('default');

for trie = 1:100
    n = 6;
    A = randn(n);
    B = randn(n,3);
    C = randn(2,n);
    
    quad1 = quadFromABC(A,B,C);
    E = [eye(n) B*B'; zeros(n) A'];
    A = [A zeros(n); -C'*C eye(n)];
    
    quad2 = quadFromSymplecticPencil(A, E);
    
    [A1,E1] = symplecticPencilFromQuad(quad1);
    assert(subspace([E';A'], [E1'; A1']) < sqrt(eps));
    
    [A2,E2] = symplecticPencilFromQuad(quad2);
    assert(subspace([E';A'], [E2'; A2']) < sqrt(eps));
end