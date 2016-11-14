function [d,v] = pca(x) 
%PCA    Principal Components Analysis... sans component scores
%
% Copyright (c) 1994-2013, Neil Caithness, neil.caithness@oerc.ox.ac.uk

% X will most likely already be centred and standardized.

[v,d] = eig(cov(x));                % eigenvectors and eigenvalues 
[d,i] = sort(diag(d),'descend');    % sort the eigenvalues 
v = v(:,i);                         % reorder the eigenvectors 

d = d';
