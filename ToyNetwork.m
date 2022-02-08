function [A] = ToyNetwork(n,gamma)

A = zeros(n);
A(2:end,1) = gamma;
A(end,1) = 1;

A = A + diag(ones(n-1,1),1)*(1-gamma);

A(1,2) = 0;
