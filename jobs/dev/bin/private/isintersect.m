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

    



