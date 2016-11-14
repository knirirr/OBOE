% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function data = location(data)
%LOCATION - Figure 1b - World map showing location of the study

ilat1 = data.coord.inner.min.lat.deg.num;
ilat2 = data.coord.inner.max.lat.deg.num;
ilon1 = data.coord.inner.min.lon.deg.num;
ilon2 = data.coord.inner.max.lon.deg.num;
ipoly = data.coord.inner.poly;
opoly = data.coord.outer.poly;

worldmap('world');
load coast, plotm(lat,long),clear lat long 
plotm(track1('rh',ilat1,0,90),'-k')
plotm(track1('rh',ilat2,0,90),'-k')
plotm(track1('rh',0,ilon1,180),'-k')
plotm(track1('rh',0,ilon2,180),'-k')
geoshow(ipoly,'facecolor','red');
geoshow(opoly,'facecolor',[.7 .7 .7]); % grey
set(gca,'Units','Normalized','Position',[0 0 1 1])
framem off; gridm on; plabel off; mlabel off; tightmap
saveas(gcf,fullfile(data.file.outputimages,'Fig 1b - World.png'))
close
