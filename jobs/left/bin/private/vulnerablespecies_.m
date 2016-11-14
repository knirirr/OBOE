% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function data = vulnerablespecies(data)

% inner zone polygon
ipoly = data.coord.inner.poly;

% read the vulnerable species shape file
vul = shaperead(data.file.vulnerablespecies, ...
    'UseGeocoord',true, ...
    'BoundingBox',ipoly.BoundingBox);

% clip each polygon with IPOLY
%   and remove if intersection is empty
isin = false(1,numel(vul));
for i = 1:numel(vul)
    [vul(i).Lon, vul(i).Lat] = polybool('intersection', ...
        ipoly.Lon, ipoly.Lat, vul(i).Lon, vul(i).Lat);
    isin(i) = ~isempty(vul(i).Lat);
end
vul = vul(isin);

% extract fields by name
latin = extractfield(vul,'Latin');
iucn = extractfield(vul,'iucn');
tclass = extractfield(vul,'class');

[~,kid] = unique(latin);
latin = latin(kid);
latin_ = regexprep(latin,' ','_');
iucn = iucn(kid);
tclass = tclass(kid);
no = num2cell(1:numel(latin));

vulcel = [no' latin_' latin' tclass' iucn']';
vulstr = sprintf('<tr><td>%i&nbsp;&nbsp;&nbsp;&nbsp;</td><td><a href="http://en.wikipedia.org/wiki/%s"><i>%s</i></a>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>%s&nbsp;&nbsp;&nbsp;&nbsp;</td><td>%s&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>', ...
    vulcel{:});
vultable = sprintf('<table>%s</table>',vulstr);
data.output.table_of_vulnerable_species = sprintf('%s',vultable);
data.output.number_of_vulnerable_species = sprintf('%i',numel(vul));

% logmsg(0,'%i vulnerable species shapes intersect with the inner zone',numel(vul))

% sum of shapes
data.map.vulnerability.a = mysumofshapes( ...
    data.map.mask.refmat, ...
    size(data.map.mask.a), ...
    vul);
data.map.vulnerability.bbox = data.map.mask.bbox;
data.map.vulnerability.refmat = data.map.mask.refmat;
data.map.vulnerability.info = data.map.mask.info;

% show
data.map.vulnerability.color.colorbar = 'on';
data.map.vulnerability.color.type = 'discrete';
mygeoshow(data.map.vulnerability, data.map.mask.a);

% save
set(gcf,'Renderer','zbuffer')
saveas(gcf,fullfile(data.file.outputimages,'Fig 6 - Vulnerability.png'));
close
