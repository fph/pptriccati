rng('default');

% n = 8;
% m = 3;
% p = 2;
% 
% A = randn(n);
% B = randn(n, m);
% C = randn(p, n);

% quad = quadFromABC(A, B, C);

%addpath('~/ref/math/matlab/carex/');

%[A,G,Q,X,parout,B,R,C,Q0] = carex(5);

eady = load('eady.mat');
A = eady.A;
B = eady.B;
C = eady.C;
quad = quadFromABC(A, B, C);

for i = 1:20
    quad = signOneIteration(quad);
    quad = quadTruncate(quad);

    

%     quadC = quadCayley(quad, 1);
%     [AA, BB, CC] = ABCFromQuad(quadC);
%     X = CC'* CC;
%     norm(A'*X + X*A + C'*C - X*B*B'*X)
end

%M = quasidefiniteMatrixFromQuad(quad);
%J = [zeros(n) eye(n); -eye(n) zeros(n)];
% for i = 1:20
%     M = 1/2*(M + J*inv(M)*J);
% end
% 
% norm(M - quasidefiniteMatrixFromQuad(quad))

