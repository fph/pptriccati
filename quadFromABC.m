function quad = quadFromABC(A, B, C)
% creates a quadBasis from a triple A, B, C in system theory
%
% quad = quadFromABC(A, B, C)
%
% the triple may represent either a discrete-time or a continuous-time
% system

quad.X = [B A; zeros(size(C,1), size(B,2)) C];
quad.dimensions = size(A);
quad.p = 1:sum(quad.dimensions);
