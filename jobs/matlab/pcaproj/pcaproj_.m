function [p,model] = pcaproj(x,y,t,option)
%PCAPROJ    Principal Components Projection
%
%   Model and projection
%         [P,MODEL] = PCAPROJ(X)
%         [P,MODEL] = PCAPROJ(X,Y)
%         [P,MODEL] = PCAPROJ(X,Y,T)
%         [P,MODEL] = PCAPROJ(X,[],T)
%
%   X is the sample data used to build the model, a k-by-n matrix of k
%   observation on n covariates.
%
%   Y is the projection data at which the model is evaluated, a j-by-n
%   matrix of j observations on the same n covariates as X. If Y is omitted
%   then X is used as both the sample and projection datasets.
%
%   T is a threshold parameter specifying how many components of the model
%   to keep. 0<T<1 means keep as many components as required to capture T
%   of the total variance. T>=1 means keep T components. If T is not
%   specified then all the components are kept.
%
%   P is the probability density of the model as conditioned on X and
%   evaluated at observations in Y.
%
%   MODEL is a struct that captures model parameters and metadata about the
%   run. It typically looks something like this:
%
%     MODEL = 
% 
%                            mu: [0.5059 0.5011 0.5010 0.4976 0.5000 0.5009]
%                         sigma: [0.2879 0.2891 0.2880 0.2893 0.2866 0.2870]
%                   eigenvalues: [1.0332 1.0189 1.0027 0.9929 0.9820 0.9703]
%                  eigenvectors: [6x6 double]
%                     threshold: 0.9500
%                    components: 6
%
%   Projection using pre-computed model
%         P = PCAPROJ(Y,MODEL)
%
%   Projection into multiple datasets 
%         [~,MODEL] = PCAPROJ(X)
%         P1 = PCAPROJ(Y1,MODEL)
%         P2 = PCAPROJ(Y2,MODEL)
%         PN = PCAPROJ(YN,MODEL)
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

% Option to standardize component scores
% ... default is don't standardize
if nargin<4
    option = false;
end

% No projection data supplied?
% ... as in [P,MODEL] = PCAPROJ(X)
% ... project the sample data into itself
if nargin<2 || isempty(y)
    y = x;
end

% Use a pre-computed model?
% ... as in P = PCAPROJ(Y,MODEL)
if isstruct(y)
    model = y;
    y = x;
else
    % ... build a new model here
    [z, model.mu, model.sigma] = zscore(x); 
    [model.eigenvalues, model.eigenvectors] = pca(z); 
end

% Which components to keep?
if ~isfield(model,'threshold') 
    if ~exist('t','var')
        t = size(x,2);                      % default threshold
    end
    model.threshold = t;
else
    t = model.threshold;
end
t = min(size(x,2),t);
if t<1
    d = model.eigenvalues;
    k = find(cumsum(d/sum(d))>=t);
    t = k(1);
end
model.components = t;
j = 1:t;                                    % keep these components
v = model.eigenvectors(:,j);
d = model.eigenvalues(j);

% Project the model into Y
y = autoz(y, model.mu, model.sigma);        % rescale Y on model parameters
z = y*v;                                    % component scores 
if option
    z = autoz(z, zeros(size(d)), sqrt(d));  % standardized scores 
end
p = sdist(z);                               % probability density 

return


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [d,v] = pca(x)                     % basic PCA - no component scores
[v,d] = svd(cov(x));
d = diag(d)';
% [v,d] = eig(cov(x));                      % ... or use EIG if you prefer
% d = fliplr(diag(d)');
% v = fliplr(v);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [p,q] = sdist(z)
n = size(z,2);
q = z.^2;
if n>1, q = sum(q,2); end                   % sum of squares 
p = 1-chi2cdf(q,n);
% p = 1-gammainc(q/2,n/2);                  % ... or use GAMMAINC if you prefer


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function z = autoz(x,mu,sigma)
sigma0 = sigma;
sigma0(sigma0==0) = 1;
z = bsxfun(@minus,x,mu);
z = bsxfun(@rdivide,z,sigma0);

