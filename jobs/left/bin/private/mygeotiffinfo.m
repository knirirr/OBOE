% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function info = mygeotiffinfo(file,refmat)
%GEOTIFFINFO Information about GeoTIFF file

info = geotiffinfo(file);

% If a REFMAT is supplied, then move the one encoded in the geotiff
% metatdata aside and replace it with the supplied one.
if nargin>1
    info.RefMatrix_ = info.RefMatrix;
    info.RefMatrix = refmat;
end

