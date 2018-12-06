function quad = randomQuadBasis(n, rB, rC, varargin)
% creates a random-generated quadBasis object of size n
% can append a last argument 'int' to make it with integer entries
n1 = randi([0,n]);
n2 = n - n1;
if not(exist('rB', 'var')) || isempty(rB)
    rB = randi([0,n1]);
end
if not(exist('rC', 'var')) || isempty(rC)
    rC = randi([0,n2]);
end
if not(isempty(varargin)) && strcmp(varargin{1}, 'int')
    quad.X = randi([-100,100],n1+rC, n2+rB);
else
    quad.X = randn(n1+rC, n2+rB);
end
quad.p = randperm(n1+n2);
quad.dimensions = [n1,n2];
