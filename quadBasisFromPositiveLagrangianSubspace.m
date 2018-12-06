function quad = quadBasisFromPositiveLagrangianSubspace(U, p, dimensions);
[m n] = size(U);
assert(m==2*n);
n1 = dimensions(1);
n2 = dimensions(2);
assert(n1+n2 == n);

threshold = 1e-15;

quad.p = p;
quad.dimensions = [n1 n2];

U = U([quad.p n1+n2+quad.p], :);
Y = [U(1:n1, :); -U(n1+n2+n1+1:end, :)] / U([n1+n2+1:n1+n2+n1, n1+1:n1+n2], :);

if norm(Y-Y') / norm(Y) > sqrt(eps(1))
    error 'Subspace does not seem to be Lagrangian';
end
Y = (Y+Y')/2;

B= symmetricFactorization(Y(1:n1, 1:n1));
C = symmetricFactorization(-Y(n1+1:end, n1+1:end))';

rB = size(B, 2);
rC = size(C, 1);

quad.X = [B Y(1:n1, n1+1:end);zeros(rC, rB) C];

