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
function data = fragmentation(data)

% read
[data.map.fragmentation.a, ...
 data.map.fragmentation.bbox, ...
 data.map.fragmentation.refmat, ...
 data.map.fragmentation.info] = mygeotiffread( ...
    data.file.fragmentation, ...
    data.coord.inner.poly.BoundingBox, ...
    data.tile.refmat);

% show
data.map.fragmentation.color.colorbar = 'on';
data.map.fragmentation.color.type = 'continuous';
mygeoshow(data.map.fragmentation, data.map.mask.a);

% save
set(gcf,'Renderer','zbuffer')
saveas(gcf,fullfile(data.file.outputimages,'Fig 7 - Fragmentation.png'));
close
