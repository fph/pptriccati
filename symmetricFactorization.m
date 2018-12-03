function Q = symmetricFactorization(A)
% factors A = R*R'
%
% R = symmetricFactorization(A)
%
% Construct a symmetric factorization A = R*R'. Raises error if A isn't
% close enough to a positive semidefinite matrix.
% Unlike chol(), this is meant to be used for semidefinite matrices, too.

threshold = 1e-15;
assert(isequal(A,A'));

[Q,D] = eig(A);

d = diag(D);
nrm = max(abs(d));
if any(d < -threshold * nrm)
    error("A does not seem to be positive semidefinite");
end
Q = Q(:, d>threshold*nrm);
d = d(d>threshold*nrm);

Q = Q * sqrt(diag(d))';