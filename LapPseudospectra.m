function Pseudo = LapPseudospectra(A,Grid)
%
% A - the graph Laplacian
% Grid - A struct containing Grid.Z1 and Grid.Z2 (the X and Y parts of the 
%        LapPseudo search region, X+iY will be searched over to create the
%        level sets). THIS PARAMETER IS OPTIONAL
%
%Find the "Laplacian Pseudospectra of a Laplacian matrix... 
%The idea is to be sure not to alter the 0 eigenvalue, this one should
%remain the same.
%To do this we can use an idea from "Simultaneously diagonalizable
%matrices" in that if two matrices are simultaneously diagonalizable they
%commute, but also importantly to simultaneously diagonalizable matrices
%will also have the property that adding those two matrices together will
%cause the eigenvalues of the two to be summed together.So eig [0 1 1 1 1], 
%and the other with eig [0 2 3 4 5] summing the two simultaneously
%diagonalizable matrices will lead to a third matrix with eigenvalues [0 3
%4 5 6]. 
%It turns out this idea can be generalized to non-diagonalizable matrices 
%as well, they just must be simultaneously diagonalizable to the same
%Jordan form!

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

%The difference between this and regular pseudospectra is we leave the
%zero eigenvalue unchanged!
[Vnew T] = schur(A);
%F = find(E == min(E));
DT = diag(T);
F = find(DT==min(DT));
%So instead of I, we need I with a single 0 on the diagonal.
I = eye(size(A,1));
%Set one of the diagonal elements of I to 0
I(F(1),F(1)) = 0;
%I(1,1) = 0;
MinSig = zeros(length(X),1);
MEig = zeros(length(X),1);
%Find a matrix which is simultaneously diagonalizable (or simultaneously
%diagonalizable to the same Jordan form...)

%[Vnew J] = jordan(A);
%Change basis to ensure that the matrices change the eigenvalues in the
%proper way.
BI = Vnew*I*inv(Vnew);

for j = 1:length(X)
    z = X(j)+i*Y(j);
    
    [U Sig V] = svd(z*BI-A);
    %We are only interested in what happens to the smallest non-zero
    %singular value...
    MinSig(j) = Sig(end-1,end-1);
    MEig(j) = Sig(end,end);
    
end

Pseudo.X = Z1;
Pseudo.Y = Z2;
Pseudo.MinSig = reshape(MinSig,size(Z1));
Pseudo.MEig = MEig;