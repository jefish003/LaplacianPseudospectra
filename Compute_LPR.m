function LPR = Compute_LPR(L,Grid)
%
%Inputs: L - (n x n matrix) the graph Laplacian
%        Grid - Should be structured as follows
%               [Z1,Z2] = ndgrid(-M:M/100:M,-M:M/100:M); Grid.Z1 = Z1;
%               Grid.Z2 = Z2;
%
%Outputs: LPR - The Laplacian pseudospectral resilience.
%
%
%Written by Jeremie Fish
%Last updated: February 8th 2022
%
%Please cite "Non-normality, Optimality and Synchronization" By Jeremie
%             Fish and Erik Bollt

E = eig(L);
E = sort(E);
Lam2 = real(E(2));
if ~exist('Grid','var')
P = LapPseudo(L);
end
if exist('Grid','var')
    P = LapPseudo(L,Grid);
end
   
[C h] = contour(P.X,P.Y,P.MinSig,[Lam2 Lam2]);
LPR = -min(C(1,:));
