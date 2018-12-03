function quad = updateQuadBasisOut(quad, i)
% transforms a quadBasis into an equivalent one by removing one row from A and
% B and adding a column to A and C
%
% newQuad = updateQuadBasisOut(quad, i)
%
% enlarges C by adding row i of A to it

n1 = quad.dimensions(1);
n2 = quad.dimensions(2);

assert(i <= n1);

assert(size(quad.X,2) > n2, 'Your quadBasis has an empty matrix B (i.e., the block B*B'' is zero), so the performed swap cannot be performed (null pivot)');

% brings the selected row into the last row of A, i.e., n1
quad.X([i n1], :) = quad.X([n1 i], :);
quad.p([i n1]) = quad.p([n1 i]);

% creates zeros in the last row of B via an orthogonal transformation
[v, beta, s] = gallery('house', quad.X(n1, end-n2:-1:1)');
v = v(end:-1:1);
quad.X(1:n1-1, 1:end-n2) = quad.X(1:n1-1, 1:end-n2) - quad.X(1:n1-1, 1:end-n2)*v*beta*v';
quad.X(n1, end-n2) = s;
quad.X(n1, 1:end-n2-1) = 0;

% updates PPT as in [PolSt, 6.2, Case 2]

quad.X(n1, end-n2) = 1 / quad.X(n1, end-n2);
quad.X(1:n1-1, end-n2) = quad.X(1:n1-1, end-n2) * quad.X(n1, end-n2);
quad.X(1:n1-1, end-n2+1:end) = quad.X(1:n1-1, end-n2+1:end) - quad.X(1:n1-1, end-n2) * quad.X(n1, end-n2+1:end);
quad.X(n1, end-n2+1:end) = -quad.X(n1, end-n2+1:end) * quad.X(n1, end-n2);

quad.X(n1+1:end, end-n2) = 0; %zeros that are inserted in the "grown" C; we can't count on them to be zero already in quad.X

quad.dimensions = [n1-1, n2+1];
