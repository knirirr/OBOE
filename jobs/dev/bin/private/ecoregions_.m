function data = ecoregions(data)

opoly = data.coord.outer.poly;
ipoly = data.coord.inner.poly;

% read the ecoregions shape file
[eco] = shaperead(data.file.ecoregions, ...
    'UseGeocoord',true, ...
    'BoundingBox',opoly.BoundingBox);
% it is necessary to explicitly check each intersection
% - shaperead using BoundingBox is too generous
iseco = false(1,numel(eco));
for i = 1:numel(eco)
    [eco(i).Lon, eco(i).Lat] = polybool('intersection', ...
        opoly.Lon, opoly.Lat, ...
        eco(i).Lon, eco(i).Lat);
    iseco(i) = ~isempty(eco(i).Lat);
end
eco = eco(iseco); 

% find unique ECO_IDs
eco_id = extractfield(eco,'ECO_ID');
eco_name = extractfield(eco,'ECO_NAME');
[~,kid] = unique(eco_id);
eco_id = eco_id(kid);
eco_name = eco_name(kid);

% now make the union of the intersections that also intersect with ipoly
lonu = [];
latu = [];
lonx = [];
latx = [];
star = repmat({''},1,numel(eco));
for i = 1:numel(eco)
    [lon,lat] = polybool('intersection', ...
        ipoly.Lon, ipoly.Lat, ...
        eco(i).Lon, eco(i).Lat);
    if ~isempty(lat)
        for j = i:numel(eco)
            if eco(i).ECO_ID == eco(j).ECO_ID
                star{j} = '*';
                [lon,lat] = polybool('intersection', ...
                    opoly.Lon, opoly.Lat, ...
                    eco(j).Lon,eco(j).Lat);
                [lonu,latu] = polybool('union', ...
                    lonu, latu, lon, lat);
            end
        end
    else
        for j = i:numel(eco)
            if eco(i).ECO_ID == eco(j).ECO_ID
                [lon,lat] = polybool('intersection', ...
                    opoly.Lon, opoly.Lat, ...
                    eco(j).Lon,eco(j).Lat);
                [lonx,latx] = polybool('union', ...
                    lonx, latx, lon, lat);
            end
        end
    end
end
upoly = makepoly(latu,lonu,'NAME','Union of intersecting ecoregions');
data.coord.isecoregion.poly = upoly;
xpoly = makepoly(latx,lonx,'NAME','Union of non-intersecting ecoregions');
data.coord.notisecoregion.poly = xpoly;

% % make the corresponding subtraction poly
% [lon_,lat_] = polybool('subtraction',opoly.Lon,opoly.Lat,upoly.Lon,upoly.Lat);
% xpoly = makepoly(lat_,lon_,'NAME','Not union of intersecting ecoregions');
% data.coord.notisecoregion.poly = xpoly;

% color rules
[symbolspec,rules] = eco_symbolspec;

% axes
worldmap(opoly.BoundingBox(:,2),opoly.BoundingBox(:,1));
setm(gca,'ffacecolor',[0 0 0]); % black background
geoshow(eco,'symbolspec',symbolspec)
plotm(ipoly.Lat,ipoly.Lon,'-r','LineWidth',2);
plotm(upoly.Lat,upoly.Lon,'-k','LineWidth',2);

% standard annotations and settings
mymapsettings

% save figure
saveas(gcf,fullfile(data.file.outputimages,'Fig 3 - Ecoregions.png'))
close

% convert colors to hex equivalents
for i = 1:numel(rules)
    if ~strcmp(rules{i}{1},'Default')
        hex_id{i} = rules{i}{2};
        hex_str{i} = char(rgb2hex(rules{i}{4}));
    end
end

% build the html table legend
[~,kex] = intersect(cell2mat(hex_id),eco_id);
ecocel = [hex_str(kex)' eco_name' star(kid)']';
ecostr = sprintf('<tr><td bgcolor=%s width="10%%"></td><td width="90%%">%s%s</td></tr>',ecocel{:});
ecotable = sprintf('<table style="font-family:calibri; font-size:11px" align="left" width="100%%" border="0">%s</table>',ecostr);
data.output.table_of_ecoregions = sprintf('%s',ecotable);
data.output.ecoregion_labels = sprintf('%s<br>\n',eco(kid).ECO_NAME);

