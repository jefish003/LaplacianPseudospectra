function [P] = LapPseudo(L,Grid)
%Inputs:
%       L    - (n x n matrix) The graph Laplacian
%       Grid - (Optional) - The grid to calculate the Laplacian pseudospectra over, Grid should be structure as follows (an example grid)
%                           [Z1,Z2] = ndgrid(-M:M/100:M,-M:M/100:M) and Grid.Z1 = Z1, Grid.Z2 = Z2. Obviously the ndgrid can be changed
%                           to match whatever search region is desired.
%
%
%Written by: Jeremie Fish
%Last updated February 8th 2022
%
[V T] = schur(L);
DT = diag(T);
F = find(DT~=min(DT));
L0 = T(F,F);
if ~exist('Grid','var')
    P = Pseudospectra(L0);
end

if exist('Grid','var')
    P = Pseudospectra(L0,Grid);
end

