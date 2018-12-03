rng('default');

rng(2); % TODO: remove, to get a better initial case for development

n = 5;

quad = randomQuadBasis(5);

n1 = quad.dimensions(1);
n2 = quad.dimensions(2);

j = randi([1, n2]);

quad.p = 1:n; % TODO: remove, for devel
j = 1;

quad2 = updateQuadBasisIn(quad, j);

quad3 = quadBasisFromPositiveLagrangianSubspace(positiveLagrangianSubspaceFromQuadBasis(quad), quad2.p, quad2.dimensions(1));

assert(subspace(positiveLagrangianSubspaceFromQuadBasis(quad), positiveLagrangianSubspaceFromQuadBasis(quad2)) < sqrt(eps));