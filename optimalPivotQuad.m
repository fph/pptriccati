function [I, M] = optimalPivotQuad(quad, index_mask);
% returns the optimal pivot to choose among the indices in index_mask
%
% returns i, j, or [i,j].
%
% index_mask is on indices in Y=[BB' A; A' C'C], not in the original X
% Uses Bunch-Parlett pivoting, essentially

n1 = quad.dimensions(1);
n2 = quad.dimensions(2);

in = false(1, n1+n2);
in(1:n1) = true;

row_index_mask = false(1,size(quad.X,1));
row_index_mask(1:n1) = index_mask(1:n1);
%row_index_mask = index_mask & in;

column_index_mask = false(1,size(quad.X,2));
column_index_mask(end-n2+1:end) = index_mask(end-n2+1:end);
%column_index_mask = index_mask & ~in;

%index_helper = 1:n1+n2;

% looks for maxima in BB' and C'C (which must be on the diagonal)
[Bmax, pos] = max(vecnorm(quad.X(row_index_mask, 1:end-n2), 2, 2)); 
% index_helper2 maps a row index in quad.X(row_index_mask,:) into one in Y
index_helper2 = find(row_index_mask);
if isempty(Bmax)
    Bmax = 0;
end
Bmax = Bmax^2; i = index_helper2(pos);

[Cmax, pos] = max(vecnorm(quad.X(n1+1:end, column_index_mask), 2, 1));
% index_helper3 maps a column index in quad.X(:,column_index_mask) into one
% in Y
%index_helper3 = index_helper(column_index_mask);
index_helper3 = find(column_index_mask) + n1 + n2 - size(quad.X,2);
if isempty(Cmax)
    Cmax = 0;
end
Cmax = Cmax^2; j = index_helper3(pos);

% looks for maximum in A
[Amax, i2, j2] = maxMatrix(abs(quad.X(row_index_mask, column_index_mask)));
i2 = index_helper2(i2);
j2 = index_helper3(j2);

% we need to choose between Bmax, [i]; Cmax, [j]; Amax, [i2 j2]

alpha = (1+sqrt(17))/8; % Bunch-Parlett magic number

if alpha*Amax > max(Bmax,Cmax)
    I = [i2,j2];
    M = Amax;
else
    if Bmax > Cmax
        I = [i];
        M = Bmax;
    else
        I = [j];
        M = Cmax;
    end
end
