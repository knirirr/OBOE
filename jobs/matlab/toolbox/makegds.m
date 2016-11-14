function gds = makegds(geometry,lat,lon,varargin)
% MAKEGDS   Make a Version 2 Geographic Data Structure (geostruct)
%
%   GDS = MAKEGDS(GEOMETRY,LAT,LON, ...)
%
%       GEOMETRY may be one of 'Point', 'MultiPoint', 'Line', or 'Polygon'.
%       LAT and LON are NaN separated coordinate vectors. Name/Value pairs
%       may be appended and are added as attributes to the GDS.
%
%       Special Name/Value pairs are:
%       
%           'RESOLUTION'/numeric-value used to densify latitude-longitude
%           sampling in lines or polygons. Default is no densification.
%
%           'INTERPM'/string-value may be one of 'gc', 'rh', or 'lin'.
%           Specifies the interpolation method used in distance and area
%           calculations. Default is 'rh' (rhumb line).
% 
%       For certain geometries attributes are added automatically:
%
%           Polygon, Line, MultiPoint: 
%               DIST_NS_KM
%               DIST_EW_KM
%           Polygon, Line: 
%               MULTIPART
%           Polygon:
%               AREA_KM2
%               ISPOLYCW
%
%       The Mapping Toolbox provides an easy means of displaying,
%       extracting, and manipulating collections of vector map features
%       organized in geographic data structures.
% 
%       A geographic data structure is a MATLAB structure array that has
%       one element per geographic feature. Each feature is represented by
%       coordinates and attributes. A geographic data structure that holds
%       geographic coordinates (latitude and longitude) is called a
%       geostruct, and one that holds map coordinates (projected x and y)
%       is called a mapstruct. Geographic data structures hold only vector
%       features and cannot be used to hold raster data (regular or
%       geolocated data grids or images).
%
%       See http://www.mathworks.co.uk/help/map/understanding-vector-geodata.html#f20-12375
%       for a further description of Geographic Data Structures.
%
% Copyright 2012, neil.caithness@oerc.ox.ac.uk

% Defaults
var.RESOLUTION = 0; % Implies no densification
var.INTERPM = 'rh'; % Valid strings are 'gc', 'rh', or 'lin'.
% Parameter pairs passed in varargin
for i = 1:2:numel(varargin)
    switch upper(varargin{i})
        case {'RESOLUTION' 'INTERPM'}
            var.(upper(varargin{i})) = varargin{i+1};
    end
end
% Check the parameter values passed in are valid
msg = 'The value for RESOLUTION must be numeric';
assert(isnumeric(var.RESOLUTION),msg)
msg = 'The value for INTERPM must be one of ''gc'', ''rh'', or ''lin''';
assert(ischar(var.INTERPM),msg);
assert(~isempty(intersect(var.INTERPM,{'gc' 'rh' 'lin'})),msg)

% Earth almanac values used in distance and area calculations
earth = almanac('earth','ellipsoid','km','sphere');

if ~isnan(lat(end)), lat(end+1) = nan; end
if ~isnan(lon(end)), lon(end+1) = nan; end

% Construct the GDS
boundingbox = [min(lon) min(lat) ; max(lon) max(lat)];
gds.Geometry = geometry;
switch upper(geometry)
    case {'POLYGON'} 
        gds.BoundingBox = boundingbox;
        if var.RESOLUTION
            [gds.Lat,gds.Lon] = interpm(lat,lon,var.RESOLUTION,var.INTERPM);
        else
            gds.Lat = lat;
            gds.Lon = lon;
        end
        gds.DIST_NS_KM = distance(min(lat),0,max(lat),0,earth); 
        gds.DIST_EW_KM = distance(min(abs(lat)),min(lon),min(abs(lat)),max(lon),earth);
        gds.AREA_KM2 = areaint(gds.Lat,gds.Lon,earth);
        gds.MULTIPART = double(isShapeMultipart(gds.Lon,gds.Lat));
        gds.ISPOLYCW = double(ispolycw(gds.Lon,gds.Lat));
    case {'MULTIPOINT'}
        gds.BoundingBox = boundingbox;
        gds.Lat = lat; 
        gds.Lon = lon;
        gds.DIST_NS_KM = distance(min(lat),0,max(lat),0,earth); 
        gds.DIST_EW_KM = distance(min(abs(lat)),min(lon),min(abs(lat)),max(lon),earth);
    case {'LINE'} % For a 'PolyLine', the value of the Geometry field is simply 'Line'.
        gds.BoundingBox = boundingbox;
        if var.RESOLUTION
            [gds.Lat,gds.Lon] = interpm(lat,lon,var.RESOLUTION,var.INTERPM);
        else
            gds.Lat = lat;
            gds.Lon = lon;
        end
        gds.DIST_NS_KM = distance(min(lat),0,max(lat),0,earth); 
        gds.DIST_EW_KM = distance(min(abs(lat)),min(lon),min(abs(lat)),max(lon),earth);
        gds.MULTIPART = double(isShapeMultipart(gds.Lon,gds.Lat));
    case {'POINT'}
        gds.Lat = lat; 
        gds.Lon = lon;
    otherwise
        error('Geometry ''%s'' is not valid for Geographic Data Structures',geometry)
end

% Add attribute/value pairs from varargin to the GDS 
for i = 1:2:numel(varargin)
    gds.(upper(varargin{i})) = varargin{i+1};
end
