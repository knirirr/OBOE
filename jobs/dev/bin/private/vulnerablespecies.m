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
function data = vulnerablespecies(data)

% Make the temp directories
try
    mkdir('..\temp');
    mkdir('..\temp\layers');
    mkdir('..\temp\projection');
catch ME
    logmsg(ME,'Can''t make temp directories')
    rethrow(ME)
end

% Read the layers files 
%   Bio1, Bio4, Bio12, Bio15, Slope, Aspect
%   using [a,bbox,refmat,info] = mygeotiffread(filename,bbox,refmat)
try
    for bio_ = {'bio1' 'bio4' 'bio12' 'bio15' 'slope' 'aspect'}
        bio = char(bio_);
        [layers.bio.(bio),layers.bbox,layers.refmat,~] = mygeotiffread( ...
            data.file.(bio), ...
            data.coord.inner.poly.BoundingBox, ...
            data.tile.refmat);
    end
    layers.size = size(layers.bio.(bio));
catch ME
    logmsg(ME,'Failed while reading data files: %s',bio)
    rethrow(ME)
end

% Calculate X,Y coordinate matrices 
%   [lat,lon] = pix2latlon(refmat,row,col)
row = repmat((1:layers.size(1))',1,layers.size(2));
col = repmat((1:layers.size(2)) ,layers.size(1),1);
[Y,X] = pix2latlon(layers.refmat,row,col);

% Now write the layers files 
%   Bio1, Bio4, Bio12, Bio15, Slope, Aspect
%   using arcgridwrite(fileName,X,Y,Z)
%   NB. missing data value is -32768
try
    for bio_ = {'bio1' 'bio4' 'bio12' 'bio15' 'slope' 'aspect'}
        bio = char(bio_);
        Z = layers.bio.(bio);
        Z(Z==-32768) = -9999;
        arcgridwrite(fullfile(data.file.layers,[bio '.asc']),X,Y,Z)
    end
catch ME
    logmsg(ME,'Failed while writing data files: %s',bio')
    rethrow(ME)
end

% Load preprocessed model metadata
%   e.g. vuln.vuln.(vuln.fields{i})
try
    vuln = load(data.file.vuln);
catch ME
    logmsg(ME,'Can''t load %s',data.file.vuln)
    rethrow(ME)
end

% Get the list of species in the countries of the 
% LEFT study area with maxent AUC >= 0.07 i.e.
%   data.country.iso2 +
%   vuln.vuln.(vuln.fields{i}).Range.In.ISO2 +
%   vuln.auc(i) >= AUC_threshold
AUC_threshold = 0.7;
k = false(size(vuln.fields));
for i = 1:numel(vuln.fields)
    k(i) = ~isempty(intersect( ...
            data.country.iso2, ...
            vuln.vuln.(vuln.fields{i}).Range.In.ISO2)) ...
            && ...
            vuln.auc(i) >= AUC_threshold;
end
logmsg(0,'Number of threatened species possible: %i',sum(k))

% Run the maxent projections
java = '"C:\Program Files (x86)\Java\jre7\bin\java"';
maxent = 'V:\programs\maxent\maxent.jar';
layersdir = data.file.layers;
outfile = data.file.projection;
Z = zeros(layers.size);
final_list = [];
for i = find(k)'
    lambdafile = fullfile(data.file.lambdas,vuln.fields{i},[vuln.fields{i} '.lambdas']);
    c = evalc(sprintf('!%s -cp %s density.Project %s %s %s',java,maxent,lambdafile,layersdir,outfile));
    % logmsg(0,'Model projection %i - %s',i,vuln.fields{i})
    if isempty(c)
        z = arcgridread(outfile);
        z(isnan(z)) = 0;
        z(z>=0.5) = 1;
        z(z<0.5) = 0;
        if any(z(:))
            Z = Z + z;
            final_list = [final_list i];
        end
    else
        logmsg(1,'Model projection failed for - %s',vuln.fields{i})
    end
end
logmsg(0,'Number of threatened species present: %i',numel(final_list))
    

% map
Z = flipud(Z); % figure out why later
data.map.vulnerability.a = Z;
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
    
% build the specis table for the appendix
for i = 1:numel(final_list)
    genus{i} = vuln.vuln.(vuln.fields{final_list(i)}).Genus;
    species{i} = vuln.vuln.(vuln.fields{final_list(i)}).Species;
    latin{i} = sprintf('%s %s',genus{i},species{i});
    iucn{i} = vuln.vuln.(vuln.fields{final_list(i)}).ThreatCategory;
    tclass{i} = vuln.vuln.(vuln.fields{final_list(i)}).Class;
end

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
data.output.number_of_vulnerable_species = sprintf('%i',numel(final_list));


% Remove the temp directories
try
    rmdir('..\temp','s');
catch ME
    logmsg(ME,'Can''t remove temp directories')
    rethrow(ME)
end
