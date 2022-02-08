function Pseudo = Pseudospectra(A,Grid)
%
% A - the matrix A
% Grid - A struct containing Grid.Z1 and Grid.Z2 (the X and Y parts of the 
%        Pseudo search region, X+iY will be searched over to create the
%        level sets). THIS PARAMETER IS OPTIONAL
%


if ~exist('Grid','var')
    E = eig(A);
    M = 1.25*max(abs(E));
    [Z1,Z2] = ndgrid(-M:M/100:M,-M:M/100:M);
end
if exist('Grid','var')
    Z1 = Grid.Z1;
    Z2 = Grid.Z2;
end

X = Z1(:);
Y = Z2(:);


MinSig = zeros(length(X),1);
I = eye(size(A));
for j = 1:length(X)
    z = X(j)+i*Y(j);
    
    [U Sig V] = svd(z*I-A);
    %We are only interested in what happens to the smallest non-zero
    %singular value...
    MinSig(j) = Sig(end,end);
    %MEig(j) = Sig(end,end);
    
end

Pseudo.X = Z1;
Pseudo.Y = Z2;
Pseudo.MinSig = reshape(MinSig,size(Z1));