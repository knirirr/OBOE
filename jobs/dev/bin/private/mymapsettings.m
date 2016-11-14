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
function mymapsettings

% frame edge
setm(gca,'fedgecolor','none')

% background color
% setm(gca,'ffacecolor',[1 1 1]);

% Longitude label position
setm(gca,'MLabelParallel','north');

% projection name in lower right corner
idstr = getm(gca,'MapProjection');
idlist = cellstr(maps('idlist'));
namelist = cellstr(maps('namelist'));
namestr = char(namelist(strcmp(idlist,idstr)));
caption = sprintf('%s',namestr);
g = get(gca);
yloc = g.YLim(1) - (g.YLim(2) - g.YLim(1)) .* 0.04;
xloc = g.XLim(2);
text(xloc,yloc,caption, ...
    'HorizontalAlignment','right', ...
    'VerticalAlignment','baseline', ...
    'FontAngle','italic');

% scaleruler in lower left corner
g = get(gca);
yloc = g.YLim(1) - (g.YLim(2) - g.YLim(1)) .* 0.04;
xloc = g.XLim(1);
scaleruler( ...
    'RulerStyle','patches', ...
    'Units','km', ...
    'YLoc',yloc, ...
    'XLoc',xloc);
h = handlem('scaleruler');
r = getm(h);
setm(h,'MinorTick',0,'MajorTick',[0 max(r.MajorTick)]);

% northarrow in left border
g = getm(gca);
lat = g.maplatlimit(1) + (g.maplatlimit(2) - g.maplatlimit(1)) ./ 2;
lon = g.maplonlimit(1) - (g.maplonlimit(2) - g.maplonlimit(1)) .* 0.2;
% lat = g.maplatlimit(1) - (g.maplatlimit(2) - g.maplatlimit(1)) .* 0.05;
% lon = g.maplonlimit(1) + (g.maplonlimit(2) - g.maplonlimit(1)) .* 0.5;
northarrow('latitude',lat,'longitude',lon,'scaleratio',0.1);

% other settings
tightmap
framem on
gridm on
plabel on
mlabel on
axis tight

