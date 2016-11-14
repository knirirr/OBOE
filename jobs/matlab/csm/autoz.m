function [z,mu,sigma] = autoz(x,mu,sigma)
%AUTOZ  Centre and standardize (with optional parametric input)
%
%   [Z,MU,SIGMA] = AUTOZ(X)
%   [Z,~,~] = AUTOZ(X,MU,SIGMA)
%
% Copyright (c) 1994-2013, Neil Caithness, neil.caithness@oerc.ox.ac.uk

% Handle empty input 
if isequal(x,[])
    [z,mu,sigma] = deal([]);
    return
end

flag = 0; % use the default normalization by N-1
dim = 1; % assume X is a 2d array and use first dimension

% Compute X's mean and std, and standardize it
%   ...unless MU and SIGMA are supplied, in which
%   case use the supplied values instead
if nargin==1
    mu = mean(x,dim);
    sigma = std(x,flag,dim);
end
sigma0 = sigma;
sigma0(sigma0==0) = 1;
z = bsxfun(@minus,x,mu);
z = bsxfun(@rdivide,z,sigma0);
