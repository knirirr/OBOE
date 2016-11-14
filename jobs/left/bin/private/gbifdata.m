% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
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
