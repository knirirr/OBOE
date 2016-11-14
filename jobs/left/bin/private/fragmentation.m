% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
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
