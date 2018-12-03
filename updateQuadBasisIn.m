function quad = updateQuadBasisIn(quad, j)
% transforms a quadBasis into an equivalent one by adding one row to A and
% B and removing a column from A and C
%
% newQuad = updateQuadBasisIn(quad, j)
%
% enlarges B by adding column j of A to it

n1 = quad.dimensions(1);
n2 = quad.dimensions(2);

assert(j <= n2);

assert(size(quad.X,1) > n1, 'Your quadBasis has an empty matrix C (i.e., the block C''*C is zero), so the performed swap cannot be performed (null pivot)');

% brings the selected column into the first column of A, i.e., end-n2+1
quad.X(:, [end-n2+j end-n2+1]) = quad.X(:, [end-n2+1 end-n2+j]);
quad.p([end-n2+j end-n2+1]) = quad.p([end-n2+1 end-n2+j]);

% creates zeros in the first column of C via an orthogonal transformation
[v, beta, s] = gallery('house', quad.X(n1+1:end, end-n2+1));
quad.X(n1+1:end, end-n2+2:end) = quad.X(n1+1:end, end-n2+2:end) - beta*v*(v'*quad.X(n1+1:end, end-n2+2:end));
quad.X(n1+1, end-n2+1) = s;
quad.X(n1+2:end, end-n2+1) = 0;

% updates PPT as in [PolSt, 6.2, Case 1]

quad.X(n1+1, end-n2+1) = 1 / quad.X(n1+1, end-n2+1);
quad.X(1:n1, end-n2+1) = quad.X(1:n1, end-n2+1) * quad.X(n1+1, end-n2+1);
quad.X(1:n1, end-n2+2:end) = quad.X(1:n1, end-n2+2:end) - quad.X(1:n1, end-n2+1) * quad.X(n1+1, end-n2+2:end);
quad.X(n1+1, end-n2+2:end) = -quad.X(n1+1, end-n2+1) * quad.X(n1+1, end-n2+2:end);

quad.X(n1+1, 1:end-n2) = 0; %zeros that are inserted in the "grown" B; we can't count on them to be zero already in quad.X

quad.dimensions = [n1+1, n2-1];
