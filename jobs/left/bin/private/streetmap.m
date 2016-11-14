% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
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
keyStr = 'Fmjtd%7Cluubnuur2h%2Crw%3Do5-9uyg5u';
% name of the key is left
%   the client ID is 118881
%   the key type is Community Edition and 
%   it's associated with peter.long@zoo.ox.ac.uk

url = 'http://open.mapquestapi.com/staticmap/v4/getmap';
filename = fullfile(data.file.outputimages,'Fig 1c - Street Map.png');
params = {'bestfit' bboxStr 'size' sizeStr 'type' typeStr 'imagetype' imagetypeStr 'polygon' innerboxStr 'key' keyStr};

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

