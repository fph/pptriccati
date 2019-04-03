function quad = quadTruncate(quad)
% reduces the number of columns of B and C' of quad() via rank truncation

[A, B, C] = ABCFromQuad(quad);

[U, S, V] = svd(B, 'econ');
s = diag(S);
tol = max(size(A)) * eps(max(s));
r = sum(s > tol);
B = U(:, 1:r) * S(1:r, 1:r);

[U, S, V] = svd(C', 'econ');
s = diag(S);
tol = max(size(A)) * eps(max(s));
r = sum(s > tol);
C = (U(:, 1:r) * S(1:r, 1:r))';

quad.X = [B A; zeros(size(C,1), size(B,2)) C];