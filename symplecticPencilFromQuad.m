function [A, E] = symplecticPencilFromQuad(quad)
% constructs a symplectic pencil from a quad
%
% for now, it returns the pencil in the "standard form" [I G; 0 A'] \ [A 0;
% -H I], even if it is not the most stable one

n = sum(quad.dimensions)/2;
quad = quadFromQuad(quad, 1:2*n, [n n]);

A = [quad.X(1:n, end-n+1:end) zeros(n); -quad.X(n+1:end,end-n+1:end)'*quad.X(n+1:end,end-n+1:end) eye(n)];
E = [eye(n) quad.X(1:n, 1:end-n)*quad.X(1:n, 1:end-n)'; zeros(n) quad.X(1:n, end-n+1:end)'];