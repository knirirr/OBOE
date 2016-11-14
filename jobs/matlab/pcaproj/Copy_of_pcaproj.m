function [m,s,r] = pcaproj(x,y)
%PCAPROJ    Principal Components Projection
%
%   [M,S] = PCAPROJ(X,Y)
%
%   X and Y are sample and background datasets with observations (in rows)
%   on a set of covariates (in columns). The number of columns in X and Y
%   must be the same.
%
%   M is a vector of the probability densities conditioned on the the
%   sample dataset X and evaluated at observations in the background
%   dataset Y. S is the corresponding probability densities for the sample
%   dataset X.
%
% Copyright (c) 1994-2012, neil.caithness@oerc.ox.ac.uk

% This source is subject to the CC BY-NC-SA 3.0 license
% http://creativecommons.org/licenses/by-nc-sa/3.0/
% Please see the URL above for more information.
% All other rights reserved.
%
% THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY 
% KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
% PARTICULAR PURPOSE.

% Standardized scores
[xx,xmu,xsigma] = zscore(x); 
[yy,ymu,ysigma] = zscore(y); 

% Reciprocal scaling
xy = autoz(x,ymu,ysigma);
yx = autoz(y,xmu,xsigma);

% Eigenvectors
xv = pca(xx);
yv = pca(yy);

% Projections
pxx = sdist(xx*xv);
pyx = sdist(yx*xv);
pxy = sdist(xy*yv);
pyy = sdist(yy*yv);

X = -20;
Y = 20;
r = nan(numel(X),numel(Y));

count = 0;
h = waitbar(0,'Progress...');
for i = 1:numel(X)
    for j = 1:numel(Y)

    PXX = tfunc(pxx,X(i));
    PYX = tfunc(pyx,X(i));
    PXY = tfunc(pxy,Y(j));
    PYY = tfunc(pyy,Y(j));

    m = mdist(PYX,PYY);
    s = mdist(PXX,PXY);
    
    [~,~,r(i,j)] = roc(m,s,10000);
    
    count = count+1;
    waitbar(count./numel(r));
    end
end
close(h)

fprintf(1,'Min AUC = %f',min(r(:)));
fprintf(1,'Max AUC = %f',max(r(:)));


function z = autoz(x,mu,sigma)
sigma(sigma==0) = 1;
z = bsxfun(@minus,x,mu);
z = bsxfun(@rdivide,z,sigma);

function v = pca(x)
[v,~,~] = svd(cov(x));

function p = sdist(z)
p = 1-chi2cdf(sum(z.^2,2),size(z,2));

function p = mdist(x,y)
p = (((x-y) ./ (x+y)) +1) ./ 2;

function y = tfunc(x,k)
if k==0, y = x;
else y = (exp(x.*k) - 1) ./ (exp(k) - 1);
end

function [X,Y,AUC] = roc(m,s,n)
k = randperm(numel(m));
scores = [m(k(1:n));s];
labels = [zeros(n,1);ones(size(s))];
[X,Y,~,AUC] = perfcurve(labels,scores,1);



