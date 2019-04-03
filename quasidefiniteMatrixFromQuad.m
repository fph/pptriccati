function X = quasidefiniteMatrixFromQuad(quad)
% recovers a quasidefinite matrix associated to a quad object

sym = symFromQuad(quad);
X(sym.p, sym.p) = sym.X;