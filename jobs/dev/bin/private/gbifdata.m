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
function data = gbifdata(data)

% Overwrite any existing diagnostics file
% diagnosticData = fullfile(data.file.gbifdata,'diagnostic.txt');
% fid = fopen(diagnosticData,'w');
% fclose(fid);


data.gbif.citations = {};

for taxonConcept = {'Amphibia' 'Reptilia' 'Mammalia' 'Aves' 'Plantae'}
    data = getgbifdata(char(taxonConcept),data);
end

data.output.gbifsources = regexprep( ...
    data.gbif.citations, ...
    ' \(accessed through GBIF data portal, http://data\.gbif\.org/datasets/resource/\d+, [\d-]+\)', ...
    ';');
data.output.gbifsources = sprintf('%s\n',data.output.gbifsources{:});

% e.g.
% Arctos, MVZ Herp Catalog (accessed through GBIF data portal, http://data.gbif.org/datasets/resource/8123, 2012-02-10)
% Academy of Natural Sciences, MAL (accessed through GBIF data portal, http://data.gbif.org/datasets/resource/2006, 2012-02-10)
