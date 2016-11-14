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
function a = indexedmap(data,bbox,name,title,mask) 

% read 
% [a,r,bb] = geotiffsubset(readfile,writefile,bbox,refmat,name,b)
[a,refmat,bbox] = geotiffsubset( ...
    data.file.(name), ...
    fullfile(data.file.outputdata,[name '.tif']), ...
    bbox, ...
    data.tile.refmat, ...
    name, ...
    []);
% mask
if ~strcmp(name,'globcover')
    r = uint8(zeros(size(mask)));
    m = min(size(a,1),size(r,1));
    n = min(size(a,2),size(r,2));
    r(1:m,1:n) = a(1:m,1:n);
    a = r .* mask;
end
% plot
worldmap(bbox(:,2),bbox(:,1));
geoshow(a,cmap(name,a),refmat);
% colorbar
switch name
    case {'vulnerability','fragmentation','migratoryspecies','summation'}
        c = cmap(name,a);
        c(isnan(c(:,1)),:) = [];
        colormap(c);
        colorbar;
        try
            caxis([min(a(:)) max(a(:))]);
        catch ME
            logmsg(ME,'Can''t set CAXIS for %s - invariant data?',name)
        end
end
% scaleruler
g = get(gca);
yloc = g.YLim(1) - (g.YLim(2) - g.YLim(1)) .* 0.1;
xloc = g.XLim(1);
myscaleruler('RulerStyle','patches','Units','km', ...
    'YLoc',yloc,'XLoc',xloc);
% northarrow
g = getm(gca);
lon = g.maplonlimit(1) - (g.maplonlimit(2) - g.maplonlimit(1)) .* 0.2;
lat = g.maplatlimit(1) + (g.maplatlimit(2) - g.maplatlimit(1)) ./ 2;
northarrow('latitude',lat,'longitude',lon);
% settings
framem on; gridm on; plabel on; mlabel on; tightmap
axis tight 
% save
set(gcf,'Renderer','zbuffer')
saveas(gcf,fullfile(data.file.outputimages,[title '.png']))
close


function myscaleruler(varargin)

scaleruler(varargin{:})
h = handlem('scaleruler');
s = getm(h);
setm(h,'MinorTick',[0],'MajorTick',[0 max(s.MajorTick)]);
