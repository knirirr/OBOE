% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function z = normalise(x,lim)

x = double(x);
xmin = min(x(:));
xmax = max(x(:));
if xmax > xmin
    z = (x - xmin) ./ (xmax - xmin);
    if nargin>1
        z = (z .* (lim(2) - lim(1))) + lim(1);
    end
else
    z = x;
end

