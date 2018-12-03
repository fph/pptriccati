function assertAlmostEqual(A, B)
% asserts that A and B are close (as matrices, with a relative tolerance)

if not(isnumeric(A) && isnumeric(B))
    error 'A,B are not matrices';
end
if not(isequal(size(A), size(B)))
    error 'A,B do not have the same size';
end

nrm = max(norm(A,'fro'), norm(B,'fro');

if norm(A-B,'fro') / nrm > sqrt(eps(1))
    error 'A,B are not numerically close';
end

