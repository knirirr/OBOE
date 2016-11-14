function p = csm(x,y,t)
%CSM    Climate-Space Model
%   P = CSM(X)
%   P = CSM(X,Y)
%   P = CSM(X,Y,T)
%
%   Project data set Y into the model space built on X. If Y is not
%   specified then X is projected into itself. See CSM2 for an explanation
%   of the threshold parameter T. The output P is a vector of the
%   probability densities of the projection 0<P<=1.
%
%   P = CSM(X,Y,T)
%   
%   is equivalent to calling 
%
%   M = CSM1(X)
%   P = CSM2(Y,M,T)
%
%   See also CSM1, CSM2.
%
% Copyright (c) 1994-2013, Neil Caithness, neil.caithness@oerc.ox.ac.uk

if nargin<2
    y = x; 
end

m = csm1(x);

if nargin<3
    p = csm2(y,m);
else
    p = csm2(y,m,t);
end
