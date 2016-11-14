function mygeoshow(map, mask)

if isfield(map, 'color')
    if isfield(map.color, 'cmap') && isa(map.a,'uint8')
    % assume an indexed map is requested
        if nargin>1, 
            map.a = map.a .* mask.a;
        end
    else
    % make sure map.a is double
        map.a = normalise(map.a,[1 255]);
    end
end

% axis
worldmap(map.a, map.refmat);

% show
switch class(map.a)
    case 'uint8'
        geoshow(map.a, map.color.cmap, map.refmat);
    case 'double'
        geoshow(map.a, map.refmat, 'DisplayType', 'texturemap');
end

% annotations
mymapsettings

% color
if isfield(map, 'color')
    low = double(min(map.a(:)));
    high = double(max(map.a(:)));
    if isfield(map.color, 'colorbar') ...
            && strcmp(map.color.colorbar, 'on')
        hcb = colorbar;
        switch map.color.type
            case 'continuous'
            case 'discrete'
                colormap(jet(high-low+1));
                if ~isfield(map.color, 'caxis')
                    caxis([low high+1])
                    ytick = get(hcb,'YTick');
                    ytick = ytick((ytick-floor(ytick))==0);
                    set(hcb,'YTick',ytick+0.5);
                    ticklabels = cellstr(num2str(ytick'));
                    set(hcb,'YTickLabel', ticklabels(:));
                    set(hcb,'YTickMode','manual')            
                end
        end
    end
    if isfield(map.color, 'caxis')
        caxis(map.color.caxis)
    end
end