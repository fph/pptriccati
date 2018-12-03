function quad = randomQuadBasis(n, rB, rC)
% creates a random-generated quadBasis object of size n
n1 = randi([0,n]);
n2 = n - n1;
if not(exist('rB', 'var'))
    rB = randi([0,n1]);
end
if not(exist('rC', 'var'))
    rC = randi([0,n2]);
end
quad.X = randn(n1+rC, n2+rB);
quad.p = randperm(n1+n2);
quad.dimensions = [n1,n2];
