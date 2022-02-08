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
However it should be noted that the "automatic grid" that is implemented can fail. If you run into a case where the network is so sensitive that Compute_LPR returns nothing, then you will have to adjust the grid. To do so you should do something like the following:
```
M = 10;
[Z1,Z2] = ndgrid(-M:M/100:M,-M:M/100:M);
Grid.Z1 = Z1;
Grid.Z2 = Z2;
LPR = Compute_LPR(L,Grid)
```
Of course you can change M to whatever you need it to be, and you can make the grid more or less fine by dividing by some number other
than 100. The more points in the grid the longer it will take to compute the LPR so beware of this point.
