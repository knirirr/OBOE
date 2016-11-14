% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function data = schematic(data)
%SCHEMATIC - Figure 1a - Schematic of the study area

ilat1 = data.coord.inner.min.lat.deg.num;
ilat2 = data.coord.inner.max.lat.deg.num;
ilon1 = data.coord.inner.min.lon.deg.num;
ilon2 = data.coord.inner.max.lon.deg.num;
ipoly = data.coord.inner.poly;

hlat = (ilat2 - ilat1);
hlon = (ilon2 - ilon1);
fb = ilat1 - hlat.*0.3;
ft = ilat2 + hlat.*1;
fl = ilon1 - hlon.*0.3;
fr = ilon2 + hlon.*1;

worldmap([fb ft],[fl fr]);
geoshow(ipoly,'facecolor','red');

ib = data.coord.inner.min.lat.dms.str;
it = data.coord.inner.max.lat.dms.str;
il = data.coord.inner.min.lon.dms.str;
ir = data.coord.inner.max.lon.dms.str;

h = textm(ilat1,ilon2,ib); set(h,'FontSize',18)
h = textm(ilat2,ilon2,it); set(h,'FontSize',18)
h = textm(ilat2,ilon1,il); set(h,'FontSize',18,'Rotation',90)
h = textm(ilat2,ilon2,ir); set(h,'FontSize',18,'Rotation',90)

ew = sprintf('%0.2f km',ipoly.dist_ew_km);
ns = sprintf('%0.2f km',ipoly.dist_ns_km);
h = textm(ilat2,ilon1+hlon./2,ew); 
set(h,'FontSize',14,'HorizontalAlignment','center','VerticalAlignment','bottom')
h = textm(ilat1+hlat./2,ilon1,ns); 
set(h,'FontSize',14,'HorizontalAlignment','center','VerticalAlignment','bottom','Rotation',90)

set(gca,'Units','Normalized','Position',[0 0 1 1])
axis off; framem off; gridm off; plabel off; mlabel off; tightmap
saveas(gcf,fullfile(data.file.outputimages,'Fig 1a - Schematic.png'))
close
