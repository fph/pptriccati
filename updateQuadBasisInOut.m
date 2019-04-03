function [quad, det] = updateQuadBasisInOut(quad, i, j)
% transforms a quadBasis into an equivalent one by swapping one row of A&B
% and one column of A&C
%
% newQuad = updateQuadBasisOut(quad, i, j)
%

n1 = quad.dimensions(1);
n2 = quad.dimensions(2);

assert(i <= n1);
assert(j <= n2);

% brings the selected row into the last row of A, i.e., n1
quad.X([i n1], :) = quad.X([n1 i], :);
quad.p([i n1]) = quad.p([n1 i]);

% creates zeros in the last row of B via an orthogonal transformation
if size(quad.X,2) > n2  %skips this if B is empty
    [v, beta, s] = gallery('house', quad.X(n1, end-n2:-1:1)');
    v = v(end:-1:1);
    quad.X(1:n1-1, 1:end-n2) = quad.X(1:n1-1, 1:end-n2) - quad.X(1:n1-1, 1:end-n2)*v*beta*v';
    quad.X(n1, end-n2) = s;
    quad.X(n1, 1:end-n2-1) = 0;
end

% brings the selected column into the first column of A, i.e., end-n2+1
quad.X(:, [end-n2+j end-n2+1]) = quad.X(:, [end-n2+1 end-n2+j]);
quad.p([end-n2+j end-n2+1]) = quad.p([end-n2+1 end-n2+j]);

% creates zeros in the first column of C via an orthogonal transformation
if size(quad.X,1) > n1 %skips this is C is empty
    [v, beta, s] = gallery('house', quad.X(n1+1:end, end-n2+1));
    quad.X(n1+1:end, end-n2+2:end) = quad.X(n1+1:end, end-n2+2:end) - beta*v*(v'*quad.X(n1+1:end, end-n2+2:end));
    quad.X(n1+1, end-n2+1) = s;
    quad.X(n1+2:end, end-n2+1) = 0;
end

% updates PPT as in [PolSt, 6.2, Case 3].

alpha = quad.X(n1, end-n2+1);
if size(quad.X,2) > n2
    beta = quad.X(n1, end-n2);
else
    beta = 0;
end
if size(quad.X,1) > n1
    gamma = quad.X(n1+1, end-n2+1);
else
    gamma = 0;
end
delta = hypot(alpha, beta*gamma);

if size(quad.X,2) > n2
quad.X(n1, end-n2) = beta/delta;
end
if size(quad.X,1) > n1
quad.X(n1+1, end-n2+1) = gamma/delta;
end
quad.X(n1, end-n2+1) = conj(alpha) / delta^2;

% Update the rest of A
if size(quad.X,1) > n1 && size(quad.X,2) > n2
    quad.X(1:n1-1, end-n2+2:end) = quad.X(1:n1-1, end-n2+2:end) - quad.X(1:n1-1, end-n2:end-n2+1) * (1/delta^2*[conj(beta)*abs(gamma)^2, -alpha*conj(beta*gamma); conj(alpha), conj(gamma)*abs(beta)^2]) * quad.X(n1:n1+1, end-n2+2:end);
else
    quad.X(1:n1-1, end-n2+2:end) = quad.X(1:n1-1, end-n2+2:end) - quad.X(1:n1-1, end-n2+1) * conj(alpha)/delta^2 * quad.X(n1, end-n2+2:end);
end

% Update last row of A and first of C (if it exists)
if size(quad.X,1) > n1
    quad.X(n1:n1+1,end-n2+2:end) = [-conj(alpha)/delta^2, -conj(gamma)*abs(beta)^2/delta^2; -gamma/delta alpha/delta] * quad.X(n1:n1+1,end-n2+2:end);
else
    quad.X(n1,end-n2+2:end) = -conj(alpha)/delta^2 * quad.X(n1,end-n2+2:end);
end

% Update last column of B (if it exists) and first of A
if size(quad.X,2) > n2
    quad.X(1:n1-1, end-n2:end-n2+1) = quad.X(1:n1-1, end-n2:end-n2+1) * [-alpha/delta abs(gamma)^2*conj(beta)/delta^2; beta/delta conj(alpha)/delta^2];
else
    quad.X(1:n1-1, end-n2+1) = quad.X(1:n1-1, end-n2+1) * conj(alpha)/delta^2;
end
 
quad.p([n1 n1+1]) = quad.p([n1+1 n1]);

det = -delta^2;