% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function data = ecoregions(data)

% inner and outer zone polygons
ipoly = data.coord.inner.poly;
opoly = data.coord.outer.poly;

% read the ECOREGION shape file
eco = shaperead(data.file.ecoregions, ...
    'UseGeocoord',true, ...
    'BoundingBox',opoly.BoundingBox);

% combine polygon segments by ECO_ID
%   NB. attributes will no longer be current
eco_id = extractfield(eco,'ECO_ID');
[~,kid] = unique(eco_id,'first');
for i = kid
    k = find(eco_id==eco(i).ECO_ID);
    if numel(k)>1
        for j = k(2:end)
            [eco(i).Lon, eco(i).Lat] = polybool('union', ...
                eco(i).Lon, eco(i).Lat, eco(j).Lon, eco(j).Lat);
        end
    end
end
eco = eco(kid);


% clip each polygon with OPOLY
%   and remove if intersection is empty
isin = false(1,numel(eco));
for i = 1:numel(eco)
    [eco(i).Lon, eco(i).Lat] = polybool('intersection', ...
        opoly.Lon, opoly.Lat, eco(i).Lon, eco(i).Lat);
    isin(i) = ~isempty(eco(i).Lat);
end
eco = eco(isin);
eco_id = extractfield(eco,'ECO_ID');

% which polygons intersect with IPOLY?
isin = false(1,numel(eco));
for i = 1:numel(eco)
    [~, lat] = polybool('intersection', ...
        ipoly.Lon, ipoly.Lat, eco(i).Lon, eco(i).Lat);
    isin(i) = ~isempty(lat);
end

% make two new polygons
%   UPOLY - union of those that DO intersect with IPOLY
%   XPOLY - union of those that do NOT intersect with IPOLY
[ulon, ulat, xlon, xlat, upoly, xpoly] = deal([]);
for i = 1:numel(eco)
    switch isin(i)
        case true
            [ulon, ulat] = polybool('union', ...
                ulon, ulat, eco(i).Lon, eco(i).Lat);
        case false
            [xlon, xlat] = polybool('union', ...
                xlon, xlat, eco(i).Lon, eco(i).Lat);
    end
end
try
    upoly = makepoly(ulat,ulon,'NAME','Union of intersecting ecoregions');
catch ME
end
try
    xpoly = makepoly(xlat,xlon,'NAME','Union of non-intersecting ecoregions');
catch ME
end

% pass the new polygons to DATA
data.coord.isecoregion.poly = upoly;
data.coord.notisecoregion.poly = xpoly;

% display the figure
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
[~,kex] = intersect(cell2mat(hex_id),eco_id);
hex_str = hex_str(kex);

% build the html table legend
eco_name = extractfield(eco,'ECO_NAME');
star = repmat({''},1,numel(isin));
star(isin) = {'*'};
ecocel = [hex_str' eco_name' star']';
ecostr = sprintf('<tr><td bgcolor=%s width="10%%"></td><td width="90%%">%s%s</td></tr>',ecocel{:});
ecotable = sprintf('<table style="font-family:calibri; font-size:11px" align="left" width="100%%" border="0">%s</table>',ecostr);
data.output.table_of_ecoregions = sprintf('%s',ecotable);
data.output.ecoregion_labels = sprintf('%s<br>\n',eco.ECO_NAME);

