function X = symmetricMatrixFromQuadBasis(quad);

n = sum(quad.dimensions);
quad = quadFromQuad(quad, 1:n, [0 n]);

X = quad.X' * quad.X;