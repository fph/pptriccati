rng('default');

n = 7;

quad = randomQuadBasis(n, 'fullrank', true);

quadX = randomQuadBasis(n); %used only to get random "target" values of quad.p and quad.n
quad2 = quadBasisFromPositiveLagrangianSubspace(positiveLagrangianSubspaceFromQuadBasis(quad), quadX.p, quadX.dimensions);

quad2alt = quadFromQuad(quad, quad2.p, quad2.dimensions);

assert(subspace(positiveLagrangianSubspaceFromQuadBasis(quad2), positiveLagrangianSubspaceFromQuadBasis(quad2alt)) < sqrt(eps));