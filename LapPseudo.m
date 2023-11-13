function [P] = LapPseudo(L,Grid)
%Inputs:
%       L    - (n x n matrix) The graph Laplacian
%       Grid - (Optional) - The grid to calculate the Laplacian pseudospectra over, Grid should be structure as follows (an example grid)
%                           [Z1,Z2] = ndgrid(-M:M/100:M,-M:M/100:M) and Grid.Z1 = Z1, Grid.Z2 = Z2. Obviously the ndgrid can be changed
%                           to match whatever search region is desired.
%
%Outputs: P - P.X is the real portion of the "pertubation", P.Y is the imaginary part of the "perturbation" and P.MinSig is the minimum
%             singular value of the perturbed matrix zI-T_2, where T_2 is the submatrix of T as discussed in the paper 
%             "Non-normality, Optimality and Synchronization"
%
%Written by: Jeremie Fish
%Last updated March 23rd 2023
%
%Please cite "Non-normality, Optimality and Synchronization" By Jeremie Fish and Erik Bollt
%

%Note to force matlab to do the upper triangular (rather than block upper triangular) schur decomp. need to specify 'complex'
[V T] = schur(L,'complex');
%T = real(T);
DT = diag(T);
F = find(abs(DT)>=1e-15);
L0 = T(F,F);
if ~exist('Grid','var')
    P = Pseudospectra(L0);
end

if exist('Grid','var')
    P = Pseudospectra(L0,Grid);
end

