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
%Last updated: March 31st 2023
%
%Please cite "Non-normality, Optimality and Synchronization" By Jeremie
%             Fish and Erik Bollt

E = eig(L);
E = sort(E);
Lam2 = real(E(2));
Lam_n = real(E(end));
if ~exist('Grid','var')
P = LapPseudo(L);
end
if exist('Grid','var')
    P = LapPseudo(L,Grid);
end
   
[C h] = contour(P.X,P.Y,P.MinSig,[Lam2 Lam2]);
xC = C2xyz(C);
xVals = [];
for i = 1:length(xC)
    xVals = [xVals min(xC{i})];
end
LPR1 = -min(xVals);
%LPR1 = -min(C(1,:));
%Eigs should be the same
if ~exist('Grid','var')
P = LapPseudo(L');
end
if exist('Grid','var')
    P = LapPseudo(L',Grid);
end
[C h] = contour(P.X,P.Y,P.MinSig,[Lam2 Lam2]);
xC = C2xyz(C);
xVals = [];
for i = 1:length(xC)
    xVals = [xVals min(xC{i})];
end
LPR2 = -min(xVals);
close all
LPR = max([LPR1 LPR2]);
