% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function data = dissimilarity2(data)

try
    taxonConcepts = {'Plantae' 'Aves' 'Mammalia' 'Reptilia' 'Amphibia'};
    for tc = 1:numel(taxonConcepts)
        taxonConcept = taxonConcepts{tc};
        try
            collatedRecordsFile = fullfile(data.file.gbifdata,[taxonConcept '.txt']);
            fid = fopen(collatedRecordsFile,'r');
            c = textscan(fid,'%q %f %f');
            fclose(fid);
        catch ME
            logmsg(ME,'Crashed while reading local records file for %s',taxonConcept)
        end
        [taxonName,myLat,myLon] = deal(c{:});
        uTaxa = unique(taxonName);
        
        for i = 1:numel(uTaxa)
            this_taxon_ = regexprep(uTaxa{i},' ','_');
            name_parts = regexp(this_taxon_,'_','split');
            k = strcmp(uTaxa(i),taxonName);
            RECORDS.(taxonConcept).data.(this_taxon_).Class = taxonConcept;
            RECORDS.(taxonConcept).data.(this_taxon_).Genus = name_parts{1};
            RECORDS.(taxonConcept).data.(this_taxon_).Species = name_parts{2};
            RECORDS.(taxonConcept).data.(this_taxon_).RecordCount = sum(k);
            RECORDS.(taxonConcept).data.(this_taxon_).Latitude = myLat(k);
            RECORDS.(taxonConcept).data.(this_taxon_).Longitude = myLon(k);
        end
        RECORDS.(taxonConcept).names = fieldnames(RECORDS.(taxonConcept).data);
    end
catch ME
    logmsg(ME,'Failed while collating species records')
end



try 
    taxonConcepts = {'Plantae' 'Aves' 'Mammalia' 'Reptilia' 'Amphibia'};
    for tc = 1:numel(taxonConcepts)
        taxonConcept = taxonConcepts{tc};
        % get the covarriates for the species records
        [data, RECORDS.(taxonConcept)] = covars(data, RECORDS.(taxonConcept), RECORDS.(taxonConcept).names);
        [data, RECORDS.(taxonConcept)] = enm_pca(data, RECORDS.(taxonConcept), RECORDS.(taxonConcept).names);
        [data, betadiv.(taxonConcept)] = projection(data, RECORDS.(taxonConcept), RECORDS.(taxonConcept).names,'alpha');
    end
    betadiv.Max = zeros(size(betadiv.(taxonConcept)));
    for tc = 1:numel(taxonConcepts)
        taxonConcept = taxonConcepts{tc};
        betadiv.Max = max(betadiv.Max, betadiv.(taxonConcept));
    end

    
    % map
    data.map.dissimilarity.a = betadiv.Max;
    data.map.dissimilarity.bbox = data.map.mask.bbox;
    data.map.dissimilarity.refmat = data.map.mask.refmat;
    data.map.dissimilarity.info = data.map.mask.info;
    
    % show
    data.map.dissimilarity.color.type = 'continuous';
    % data.map.dissimilarity.color.caxis = [x(1) x(end)];
    data.map.dissimilarity.color.colorbar = 'on';
    mygeoshow(data.map.dissimilarity, data.map.mask.a);

    % save
    set(gcf,'Renderer','zbuffer')
    saveas(gcf,fullfile(data.file.outputimages, 'Fig 5 - Dissimilarity.png'))
    close

catch ME
    logmsg(ME,'Dissimilarity map failed')
end
