rng('default');

n = 3;
m = 3;
p = 2;

A = randn(n);
B = randn(n, m);
C = randn(p, n);

quad = quadFromABC(A, B, C);

gamma = 1.7;

H = [A B*B'; C'*C -A'];
magic = [H-gamma*eye(2*n) H+gamma*eye(2*n)];
GEFH = magic(:,[1:n,3*n+1:4*n]) \ magic(:,[n+1:2*n,2*n+1:3*n]);

% M = [zeros(n) eye(n) zeros(n) -sqrt(2*gamma)*eye(n);
%     eye(n) zeros(n) sqrt(2*gamma)*eye(n)  zeros(n);
%      zeros(n) sqrt(2*gamma)*eye(n) -B*B' A-gamma*eye(n);
%      -sqrt(2*gamma)*eye(n) zeros(n) A'-gamma*eye(n) C'*C];
% 
% SC = M(1:2*n, 1:2*n) - M(1:2*n, 2*n+1:end)/M(2*n+1:end,2*n+1:end)*M(2*n+1:end,1:2*n)

quadC = quadCayley(quad, gamma);
symC = symFromQuad(quadC);

assert(norm(GEFH - symC.X) < sqrt(eps));

