function quadSum = signOneIteration(quad)
% computes one iteration of the matrix sign iteration
%
% tested only when p==identity for now

[quadI, logdet] = quadJInverseJ(quad);

n = sum(quad.dimensions);
scaling_factor = exp(-1/n*logdet);

assert(all(quad.p == quadI.p));
[A1, B1, C1] = ABCFromQuad(quad);
[A2, B2, C2] = ABCFromQuad(quadI);
quadSum.X = [sqrt(scaling_factor)/sqrt(2)*B1 1/sqrt(scaling_factor)/sqrt(2)*B2 1/2*(scaling_factor*A1+1/scaling_factor*A2);
 zeros(size(C1,1), size(B1,2)+size(B2,2)) 1/sqrt(2)*sqrt(scaling_factor)*C1;
 zeros(size(C2,1), size(B1,2)+size(B2,2)) 1/sqrt(scaling_factor)/sqrt(2)*C2];
quadSum.dimensions = quad.dimensions;
quadSum.p = quad.p;
