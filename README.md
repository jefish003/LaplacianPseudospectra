# LaplacianPseudospectra
Calculation of Laplacian pseudospectra and Laplacian pseudospectral resilience (LPR)

This code was used in the paper "Non-normality, optimality and sycnchronization" written by Jeremie Fish and Erik Bollt. Please cite that paper if you use this code.
Let's jump right in with examples. First we will generate one of the Toy networks from the paper,
```
A = ToyNetwork(6,0); %6 node toy network with gamma = 0
L = diag(sum(A,2))-A; %The graph Laplacian
P = LapPseudo(L); %The Laplacian pseudospectra
contour(P.X,P.Y,P.MinSig); %A plot of the pseudospectra
```
This should give a plot that looks something like it did in the paper.
Now for calculation of LPR of this network,
```
LPR = Compute_LPR(L)
```
this should come up with

```
LPR = 0.9367.
```
And that is it!
