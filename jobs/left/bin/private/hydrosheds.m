% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
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
