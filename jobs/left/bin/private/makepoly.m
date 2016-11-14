% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function poly = makepoly(lat,lon,varargin)

RESOLUTION = 1/360;

earthellipsoid = almanac('earth','ellipsoid','km','sphere');

poly.Geometry = 'Polygon';
poly.BoundingBox = [min(lon) min(lat) ; max(lon) max(lat)];

[poly.Lat,poly.Lon] = interpm(lat,lon,RESOLUTION,'rh');

poly.dist_ns_km = distance(min(lat),0,max(lat),0,earthellipsoid); 
% any longitude will do here

poly.dist_ew_km = distance(min(abs(lat)),min(lon),min(abs(lat)),max(lon),earthellipsoid); 
% use latitude closest to the equator
% TODO: check for date-line wrapping

poly.area_km2 = areaint(poly.Lat,poly.Lon,earthellipsoid);

for i = 1:2:numel(varargin)
    poly.(varargin{i}) = varargin{i+1};
end
