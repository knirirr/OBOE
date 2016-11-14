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
function info = mygeotiffinfo(file,refmat)
%GEOTIFFINFO Information about GeoTIFF file

info = geotiffinfo(file);

% If a REFMAT is supplied, then move the one encoded in the geotiff
% metatdata aside and replace it with the supplied one.
if nargin>1
    info.RefMatrix_ = info.RefMatrix;
    info.RefMatrix = refmat;
end

