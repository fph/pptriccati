function X = symmetricMatrixFromQuadBasis(quad);

n = sum(quad.dimensions);
quad = quadFromQuad(quad, 1:n, [0 n]);

n2 = quad.dimensions(2);
X = quad.X(:, end-n2+1:end)' * quad.X(:, end-n2+1:end);