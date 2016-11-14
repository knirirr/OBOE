% Copyright 2012, neil.caithness@oerc.ox.ac.uk
%
% This source is subject to the CC BY-NC-SA 3.0 license
% http://creativecommons.org/licenses/by-nc-sa/3.0/
% Please see the URL above for more information.
% All other rights reserved.
%
% THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY 
% KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
% PARTICULAR PURPOSE.
function [a,newbbox,newrefmat,info] = mygeotiffread(filename,bbox,refmat)

try
    info = geotiffinfo(filename);
catch ME
    logmsg(2,'Can''t read geotiff file %s',filename)
    rethrow(ME)
end

if nargin<3
    refmat = info.RefMatrix;
    if isempty(refmat)
        logmsg(2,'Empty RefMatrix field for geotiff file %s',filename)
    end
end

lat = bbox([2 1],2); 
lon = bbox([1 2],1);
dlon = refmat(2,1); 
dlat = refmat(1,2);

[row,col] = latlon2abspix(refmat,lat,lon);
a = imread(filename,'PixelRegion',{row,col});
[newlat,newlon] = pix2latlon(refmat,row,col);

newrefmat = makerefmat(newlon(1),newlat(1),dlon,dlat);
newbbox = [ newlon(1)-(dlon/2)  newlat(2)+(dlat/2)
            newlon(2)+(dlon/2)  newlat(1)-(dlat/2) ];
