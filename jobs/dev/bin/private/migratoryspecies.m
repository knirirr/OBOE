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
function data = migratoryspecies(data)

% inner zone polygon
ipoly = data.coord.inner.poly;

% read the migratory species shape file
mig = shaperead(data.file.groms, ...
    'UseGeocoord',true, ...
    'BoundingBox',ipoly.BoundingBox);

% clip each polygon with IPOLY
%   and remove if intersection is empty
isin = false(1,numel(mig));
for i = 1:numel(mig)
    [mig(i).Lon, mig(i).Lat] = polybool('intersection', ...
        ipoly.Lon, ipoly.Lat, mig(i).Lon, mig(i).Lat);
    isin(i) = ~isempty(mig(i).Lat);
end
mig = mig(isin);

% extract fields by name
latin = extractfield(mig,'LATIN');

[~,kid] = unique(latin);
latin = latin(kid);
latin_ = regexprep(latin,' ','_');
no = num2cell(1:numel(latin));

migcel = [no' latin_' latin']';
migstr = sprintf('<tr><td>%i&nbsp;&nbsp;&nbsp;&nbsp;</td><td><a href="http://en.wikipedia.org/wiki/%s"><i>%s</i></a>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>', ...
    migcel{:});
migtable = sprintf('<table>%s</table>',migstr);
data.output.table_of_migratory_species = sprintf('%s',migtable);
data.output.number_of_migratory_species = sprintf('%i',numel(mig));

% sum of shapes
data.map.migratory.a = mysumofshapes( ...
    data.map.mask.refmat, ...
    size(data.map.mask.a), ...
    mig);
data.map.migratory.bbox = data.map.mask.bbox;
data.map.migratory.refmat = data.map.mask.refmat;
data.map.migratory.info = data.map.mask.info;

% show
data.map.migratory.color.colorbar = 'on';
data.map.migratory.color.type = 'discrete';
mygeoshow(data.map.migratory, data.map.mask.a);

% save
set(gcf,'Renderer','zbuffer')
saveas(gcf,fullfile(data.file.outputimages,'Fig 8 - Migratoryspecies.png'));
close
