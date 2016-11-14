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
function data = hydrosheds(data)

% read
[data.map.hydrosheds.a, ...
 data.map.hydrosheds.bbox, ...
 data.map.hydrosheds.refmat, ...
 data.map.hydrosheds.info] = mygeotiffread( ...
    data.file.hydrosheds, ...
    data.coord.inner.poly.BoundingBox, ...
    data.tile.refmat);

data.map.hydrosheds.a = data.map.hydrosheds.a + 1;

% show
data.map.hydrosheds.color.colorbar = 'off';
data.map.hydrosheds.color.type = 'discrete';
data.map.hydrosheds.color.cmap = [0.7 0.7 0.7 ; 1 0 0];
mygeoshow(data.map.hydrosheds, data.map.mask.a);

% save
set(gcf,'Renderer','zbuffer')
saveas(gcf,fullfile(data.file.outputimages,'Fig 9 - Wetland.png'));
close
