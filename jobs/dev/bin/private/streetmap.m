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
function data = streetmap(data)
%LOCATION - Figure 1c - "Street" map of the study

bbox = data.coord.inner.poly.BoundingBox;
bboxStr = sprintf('%f,%f,%f,%f',bbox(4),bbox(2),bbox(3),bbox(1));

w = 800;
f = data.coord.inner.poly.dist_ns_km./data.coord.inner.poly.dist_ew_km;
sizeStr = sprintf('%i,%i',w,round(w*f));
typeStr = 'map';
imagetypeStr = 'png';
innerboxStr = sprintf('color:0xff0000|width:3|%f,%f,%f,%f,%f,%f,%f,%f,%f,%f', ...
    bbox(3),bbox(1),bbox(3),bbox(2),bbox(4),bbox(2),bbox(4),bbox(1),bbox(3),bbox(1));

url = 'http://open.mapquestapi.com/staticmap/v4/getmap';
filename = fullfile(data.file.outputimages,'Fig 1c - Street Map.png');
params = {'bestfit' bboxStr 'size' sizeStr 'type' typeStr 'imagetype' imagetypeStr 'polygon' innerboxStr};

count = 0;
retries = 5;
while count<retries
    count = count + 1;
    [~,status] = urlwrite(url,filename,'get',params);
    if status, break, end
    logmsg(0,'Retry %i of %i',count,retries)
end

data.streetmap.status = status;
data.streetmap.retries = count;

