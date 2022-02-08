function [P] = LapPseudo(L,Grid)

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

