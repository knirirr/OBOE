function p = csm2(x,m,t)
%CSM2   Climate-Space Model Projection
%   P = CSM2(X)
%   P = CSM2(X,M)
%   P = CSM2(X,M,T)
%
%   Project X into the Climate-Space Model specified in M. T is a threshold
%   parameter specifying how many components of the model to retain. 0<T<1
%   means keep as many components as required to capture T of the total
%   variance. T>=1 means just keep T components. Default T=0.95.
%
%   See CSM1 for an explanation of the model definition M.
%
%   P is the probability density of the projection 0<P<=1. X does not need
%   to be the same data that was used to build the model given in M, though
%   the number of columns in X must match the number of components in M. If
%   M is not specified it is calculated by calling CSM1(X).
%
%   EXAMPLE
%   -------
%   % Project data set Y into the model space built on X
%   M = CSM1(X);
%   P = CSM2(Y,M,T);
%
%   or, equivalently
%
%   P = CSM(X,Y,T);
%
%   See also CSM, CSM1.
%
% Copyright (c) 1994-2013, Neil Caithness, neil.caithness@oerc.ox.ac.uk

if nargin<2
    m = csm1(x); 
end

if ~(size(x,2) == size(m.d,2))
    eid = sprintf('%s:%s:sizeError', 'csm', mfilename);
    msg = sprintf('The number of columns in the projection dataset \nmust match the number of components in the model.');
    error(eid,msg);
end

if nargin<3
    t = 0.95; 
end
t = min(size(x,2),t);
if t<1
    k = find(cumsum(m.d/sum(m.d))>=t);
    t = k(1);
end

j = 1:t;                                    % which components to keep?
m.v = m.v(:,j);                             % extract the eigenvectors 
m.d = m.d(j);                               % extract the eigenvalues 

y = autoz(x, m.mu, m.sigma);                % project into this climate data set
z = y*m.v;                                  % projected component scores 
z0 = autoz(z,zeros(size(m.d)),sqrt(m.d));   % standardized scores 
p = sdist(z0);                              % probability density 
