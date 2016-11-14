function poly = makepoly(lat,lon,varargin)

RESOLUTION = 1/360;

earthellipsoid = almanac('earth','ellipsoid','km','sphere');

poly.Geometry = 'Polygon';
poly.BoundingBox = [min(lon) min(lat) ; max(lon) max(lat)];

[poly.Lat,poly.Lon] = interpm(lat,lon,RESOLUTION,'rh');

poly.DIST_NS_KM = sprintf('%0.2f',distance(min(lat),0,max(lat),0,earthellipsoid)); 
poly.DIST_EW_KM = sprintf('%0.2f',distance(min(abs(lat)),min(lon),min(abs(lat)),max(lon),earthellipsoid)); 
poly.AREA_KM2 = sprintf('%0.2f',areaint(poly.Lat,poly.Lon,earthellipsoid));

for i = 1:2:numel(varargin)
    poly.(varargin{i}) = varargin{i+1};
end
