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
function data = summary(data)

[Dissimilarity, Vulnerability, Migratoryspecies, Hydrosheds, Resilience] = ...
    deal(zeros(size(data.map.mask.a)));

try Dissimilarity = normalise(data.map.dissimilarity.a); catch ME, end
try Vulnerability = normalise(data.map.vulnerability.a); catch ME, end
try Fragmentation = normalise(data.map.fragmentation.a); catch ME, end
try Migratoryspecies = normalise(data.map.migratoryspecies.a); catch ME, end
try Hydrosheds = normalise(data.map.hydrosheds.a); catch ME, end
try Resilience = normalise(data.map.resilience.a); catch ME, end

data.map.summary.a = ...
    Dissimilarity + ...
    Vulnerability + ...
    Fragmentation + ...
    (Migratoryspecies ./ 2) + ...
    (Hydrosheds ./ 2) + ...
    Resilience;

data.map.summary.bbox = data.map.mask.bbox;
data.map.summary.refmat = data.map.mask.refmat;
data.map.summary.info = data.map.mask.info;

% show
data.map.summary.color.type = 'continuous';
data.map.summary.color.clim = [0 5];
data.map.summary.color.colorbar = 'on';
mygeoshow(data.map.summary, data.map.mask.a);

% save
set(gcf,'Renderer','zbuffer')
saveas(gcf,fullfile(data.file.outputimages,'Fig 11 - Summary.png'));
close    
