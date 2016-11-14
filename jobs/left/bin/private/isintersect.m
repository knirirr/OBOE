% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function s = isintersect(poly,shapefile)

shape = shaperead(shapefile);
k = true(size(shape));

for i = 1:numel(shape)
    [shape(i).X_,shape(i).Y_] = polybool('intersection', ...
        poly.Lon,poly.Lat, ...
        shape(i).X,shape(i).Y);
    if isempty(shape(i).X_) && isempty(shape(i).Y_)
        k(i) = false;
    end
end

s = shape(k);

    



