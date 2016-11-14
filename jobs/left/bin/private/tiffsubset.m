% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function [a,r,bbox] = tiffsubset(readfile,writefile,bbox)

warning off map:geotiffinfo:tiffWarning
info = geotiffinfo(readfile);
warning on map:geotiffinfo:tiffWarning
bitdepth = info.BitDepth;
refmat = info.RefMatrix;
lon = bbox([1 2],1);
lat = bbox([2 1],2);
[row,col] = map2pix(refmat,lon,lat);
% don't really want to have to round here
% - could there be something off with the refmat?
row = round(row);
col = round(col);
warning off map:geotiffinfo:tiffWarning
im = imread(readfile,'PixelRegion',{row,col});  
warning on map:geotiffinfo:tiffWarning
bbox = [lon' fliplr(lat)'];

% [option bbox] = make_option([lon;lat]);
option.GTModelTypeGeoKey = 2;
option.GTRasterTypeGeoKey = 1;
option.GeographicTypeGeoKey = 4326;
option.GeogGeodeticDatumGeoKey = 6326;
option.GeogPrimeMeridianGeoKey = 8901;
option.GeogAngularUnitsGeoKey = 9102;
option.GeogEllipsoidGeoKey = 7030;
option.GeogAzimuthUnitsGeoKey = 9102;
  
geotiffwrite(writefile,bbox,im,bitdepth,option);
[a,r,bbox] = geotiffread(writefile);

return

% Here is an alternative to make the refmat
%
% info = imfinfo(readfile);
% dlon = info.ModelPixelScaleTag(1);
% dlat = (-1) .* info.ModelPixelScaleTag(2);
% lon11 = info.ModelTiepointTag(4) + dlon ./2;
% lat11 = info.ModelTiepointTag(5) + dlat ./2;
% refmat = makerefmat(lon11,lat11,dlon,dlat);

