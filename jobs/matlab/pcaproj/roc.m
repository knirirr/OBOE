function a = roc(m,s,n)

if nargin<3, n = 10000; end
k = randperm(numel(m))';
k = k(1:min(numel(m),n));
scores = [m(k); s];
labels = [zeros(size(k)); ones(size(s))];
[a.X,a.Y,a.T,a.AUC,a.OPTROCPT,a.SUBY,a.SUBYNAMES] ...
    = perfcurve(labels,scores,1);
a.MAX = 1 - ((numel(s)./numel(m)) ./ 2);
