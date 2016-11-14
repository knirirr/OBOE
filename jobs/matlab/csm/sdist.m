function [p,q] = sdist(z) 
%SDIST  Probability density
%
% Copyright (c) 1994-2013, Neil Caithness, neil.caithness@oerc.ox.ac.uk

n = size(z,2);
q = z.^2;                       % sum of squares 
if n>1
    q = sum(q,2); 
end                 
p = 1-chi2cdf(q,n);             % probability density
% p = 1-gammainc(q/2,n/2);      % ... or use gammainc if you prefer
