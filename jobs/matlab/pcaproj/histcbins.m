function h = histcbins(x,bins,color)

if nargin<2, bins = 10; end;
if nargin<3, color = 'jet'; end

if numel(bins)>1
    nbins = numel(bins);
else
    nbins = bins;
end

[n,bins] = hist(x,bins);
h = bar(bins,n,'hist');
set(h,'FaceVertexCData', ...
    eval(sprintf('%s(nbins)',color)));
