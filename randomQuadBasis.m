function quad = randomQuadBasis(n, varargin)
% creates a random-generated quadBasis object of size n
% can append a last argument 'int' to make it with integer entries
%
% Options: rB (rank of B), rC (rank of C), fullrank, int (integer entries

o = Options(varargin{:});

n1 = o.get('n1', randi([0,n]));
n2 = n - n1;

if o.get('fullrank', false)
    rB = n1;
    rC = n2;
else
    rB = o.get('rB', randi([0,n1]));
    rC = o.get('rC', randi([0,n2]));
end

if o.get('int', false)
    quad.X = randi([-100,100],n1+rC, n2+rB);
else
    quad.X = randn(n1+rC, n2+rB);
end
quad.p = randperm(n1+n2);
quad.dimensions = [n1,n2];
