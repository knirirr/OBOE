% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function [a,r,bb] = geotiffsubset(readfile,writefile,bbox,refmat,name,b)

% TODO - this code is crap, do something about it

info = geotiffinfo(readfile);
bitdepth = info.BitDepth;
% refmat = info.RefMatrix;
lon = bbox([1 2],1);
lat = bbox([2 1],2);

[row,col] = latlon2abspix(refmat,lat,lon);

a = imread(readfile,'PixelRegion',{row,col});  

switch name
    case 'globcover'
    case 'vulnerability'
    case 'fragmentation'
    case 'migratoryspecies'
        a = a - min(a(:));
    case 'wetland'
    case 'resilience'
    case 'dissimilarity' % hack from LEFT
        a = double(a).*b;
    case 'summary' % hack from LEFT
        a = b;
end

% [option bbox] = make_option([lon;lat]);
option.GTModelTypeGeoKey = 2;
option.GTRasterTypeGeoKey = 1;
option.GeographicTypeGeoKey = 4326;
option.GeogGeodeticDatumGeoKey = 6326;
option.GeogPrimeMeridianGeoKey = 8901;
option.GeogAngularUnitsGeoKey = 9102;
option.GeogEllipsoidGeoKey = 7030;
option.GeogAzimuthUnitsGeoKey = 9102;
  
%geotiffwrite(writefile,bbox,a,bitdepth,option);
geotiffwrite(writefile,a,refmat);
[a,r,bb] = geotiffread(writefile);
