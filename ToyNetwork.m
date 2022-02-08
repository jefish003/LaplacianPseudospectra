function [A] = ToyNetwork(n,gamma)
%
%Inputs: 
%       n     - (pos. int.) The number of nodes
%       gamma - (real number) The parameter for the network creation process as discussed in "Non-normality, optimality and synchronization"
%               By Jeremie Fish and Erik Bollt
%Outputs: A - (n x n) Adjacency matrix
%
%Written by: Jeremie Fish
%Last updated February 8th 2022
%

A = zeros(n);
A(2:end,1) = gamma;
A(end,1) = 1;

A = A + diag(ones(n-1,1),1)*(1-gamma);

A(1,2) = 0;
