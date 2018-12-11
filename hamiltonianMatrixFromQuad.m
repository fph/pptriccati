function H = hamiltonianMatrixFromQuad(quad)
% recovers a Hamiltonian matrix from a quad object

n = sum(quad.dimensions)/2;
quad = quadFromQuad(quad, 1:2*n, [n n]);

H = [quad.X(1:n, end-n+1:end) -quad.X(1:n, 1:end-n)*quad.X(1:n, 1:end-n)'; 
    -quad.X(n+1:end,end-n+1:end)'*quad.X(n+1:end,end-n+1:end), -quad.X(1:n, end-n+1:end)'];
