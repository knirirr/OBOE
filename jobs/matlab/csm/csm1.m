function m = csm1(x)
%CSM1   Climate-Space Model Definition
%   M = CSM1(X)
%
%   X is an m-by-n matrix of data organised with records in rows and
%   variables in columns. The definition of a Climate-Space Model is 
%   simply the means and standard deviations used to centre and standardize
%   columns of the raw input data, and the eigenvalues and eigenvectors of
%   a Principal Components Analysis. M is usually used as input to CSM2.
%
%   M contains the model definition in fields as follows:
%
%       M.mu    means
%       M.sigma standard deviations
%       M.d     eigenvalues
%       M.v     eigenvectors
%
%   See also CSM, CSM2.
%
% Copyright (c) 1994-2013, Neil Caithness, neil.caithness@oerc.ox.ac.uk

[z, m.mu, m.sigma] = autoz(x);   % centre and standardise
[m.d, m.v] = pca(z);             % eigenvalues and eigenvectors 

