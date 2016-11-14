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
function mygeoshow(map, mask)

% We're going to convert everything to a UINT8 idexed map

% no mask?
if nargin<2
    mask = ones(size(map.a));
end

% switch MASK==0 to MASK==NAN
map.a = double(map.a);
k = mask(:)==0;
map.a(k) = nan;

% color limits?
if ~isfield(map.color, 'clim')
    map.color.clim = double([min(map.a(:)) max(map.a(:))]);
end

% type?
switch map.color.type
    case 'discrete'
        span = diff(map.color.clim)+1;
    case 'continuous'
        span = 255;
end

% cmap
if ~isfield(map.color, 'cmap')
    map.color.cmap = colormap(jet(span));
    map.a = normalise(map.a,[1 span]);
end

% re-apply the mask
map.a(k) = 0;
map.a = uint8(round(map.a));

% color for MASK==0
map.color.cmap = [0 0 0 ; map.color.cmap];

% axes
worldmap(map.a, map.refmat);

% show
geoshow(map.a, map.color.cmap, map.refmat);

% colorbar
if strcmp(map.color.colorbar, 'on')
    hcb = colorbar;
    switch map.color.type
        case 'discrete'
            caxis(map.color.clim + [0 1])
            ytick = get(hcb,'YTick');
            ytick = ytick((ytick-floor(ytick))==0);
            set(hcb,'YTick',ytick+0.5);
            ticklabels = cellstr(num2str(ytick'));
            set(hcb,'YTickLabel', ticklabels(:));
            set(hcb,'YTickMode','manual')
        case 'continuous'
            caxis(map.color.clim)
    end
end

% annotations
mymapsettings

