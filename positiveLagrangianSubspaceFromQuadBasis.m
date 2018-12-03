function U = positiveLagrangianSubspaceFromQuadBasis(quad);
% transforms our internal representation into a subspace basis

n1 = quad.dimensions(1);
n2 = quad.dimensions(2);

U = zeros(2*(n1+n2), n1+n2);

%P*[BB'  A ]
%  [ 0   I ]
%P*[ I   0 ]
%  [-A' C'C]

% to

% [B A]
% [0 C]

U(1:n1, 1:n1) = quad.X(1:n1, 1:end-n2) * quad.X(1:n1, 1:end-n2)';
U(1:n1, n1+1:end) = quad.X(1:n1, end-n2+1:end);
U(n1+1:n1+n2, n1+1:end) = eye(n2);

U(n1+n2+1:n1+n2+n1, 1:n1) = eye(n1);
U(n1+n2+n1+1:end, 1:n1) = -quad.X(1:n1, end-n2+1:end)';
U(n1+n2+n1+1:end, n1+1:end) = quad.X(n1+1:end, end-n2+1:end)' * quad.X(n1+1:end, end-n2+1:end);
U([quad.p n1+n2+quad.p], :) = U;
