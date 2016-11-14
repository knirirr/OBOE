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
function data = vulnerablespecies2(data)

% inner zone polygon
ipoly = data.coord.inner.poly;

% read the vulnerable species shape file
vul = shaperead(data.file.vulnerablespecies, ...
    'UseGeocoord',true, ...
    'BoundingBox',ipoly.BoundingBox);

% clip each polygon with IPOLY
%   and remove if intersection is empty
% isin = false(1,numel(vul));
% for i = 1:numel(vul)
%     [vul(i).Lon, vul(i).Lat] = polybool('intersection', ...
%         ipoly.Lon, ipoly.Lat, vul(i).Lon, vul(i).Lat);
%     isin(i) = ~isempty(vul(i).Lat);
% end
% vul = vul(isin);

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

% get the covariate records

% load GBIF data for IUCN species
load(data.file.iucn) % loads struct SPECIES

% get the covarriates for the species records
[data,SPECIES] = covars(data,SPECIES,latin_);
[data,SPECIES] = enm_pca(data,SPECIES,latin_);

[data,data.map.vulnerability.a] = projection(data,SPECIES,latin_);
data.map.vulnerability.bbox = data.map.mask.bbox;
data.map.vulnerability.refmat = data.map.mask.refmat;
data.map.vulnerability.info = data.map.mask.info;

% show
data.map.vulnerability.color.colorbar = 'on';
data.map.vulnerability.color.type = 'continuous';
mygeoshow(data.map.vulnerability, data.map.mask.a);

% save
set(gcf,'Renderer','zbuffer')
saveas(gcf,fullfile(data.file.outputimages,'Fig 6 - Vulnerability.png'));
close
