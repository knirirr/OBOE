% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function data = speciesrecords(data)

% get species locality data from GBIF
try 
    if numel(dir(fullfile(data.file.gbifdatain,'*.txt')))
        copyfile(data.file.inputdata,data.file.outputdata);
        logmsg(0,'GBIF data files found so no new data retrieved')
        data.output.gbifsources = 'Occurrence records were supplied by the user so no GBIF sources are know.';
    else
        data = gbifdata(data);
    end
    % logmsg(0,'GBIF data retrieval completed')
catch ME
    logmsg(ME,'GBIF data retrieval failed')
end

try 
    opoly = data.coord.outer.poly;
    ipoly = data.coord.inner.poly;
    
    worldmap(opoly.BoundingBox(:,2),opoly.BoundingBox(:,1));
    setm(gca,'ffacecolor',[0 0 0]); % black background
    taxonConcepts = {'Amphibia' 'Plantae' 'Aves' 'Mammalia' 'Reptilia'};
    taxonColors = {'m' 'g' 'b' 'r' 'y'};
    data.gbif.all.nTaxonNames = 0;
    data.gbif.all.nLocalities = 0;
    data.gbif.all.nMaxColocated = 0;
    for tc = 1:numel(taxonConcepts)
        taxonConcept = taxonConcepts{tc};
        taxonColor = taxonColors{tc};
        try
            collatedRecordsFile = fullfile(data.file.gbifdata,[taxonConcept '.txt']);
            fid = fopen(collatedRecordsFile,'r');
            c = textscan(fid,'%q %f %f');
            fclose(fid);
        catch ME
            logmsg(ME,'Crashed while reading local records file for %s',taxonConcept)
        end
        [taxonName,decimalLatitude,decimalLongitude] = deal(c{:});
        [u,i,j] = unique([decimalLatitude decimalLongitude],'rows');
        s = histc(j,1:numel(i));
        scatterm(u(:,1),u(:,2),s.*5,taxonColor);
        data.gbif.(taxonConcept).nTaxonNames = numel(unique(taxonName));
        data.gbif.(taxonConcept).nLocalities = numel(decimalLatitude);
        data.gbif.(taxonConcept).nMaxColocated = max(s);
        data.gbif.all.nTaxonNames = data.gbif.all.nTaxonNames + numel(unique(taxonName));
        data.gbif.all.nLocalities = data.gbif.all.nLocalities + numel(decimalLatitude);
        data.gbif.all.nMaxColocated = max(data.gbif.all.nMaxColocated,max(s));
    end
    geoshow(data.coord.notisecoregion.poly,'FaceColor',[0.7 0.7 0.7]);
    geoshow(data.coord.isecoregion.poly,'FaceColor',[.99 .99 .99],'EdgeColor','black','LineWidth',2);
        % NB. using full white as a FaceColor apears transparent, so using off-white instead
    geoshow(data.coord.inner.poly,'FaceColor','none','EdgeColor','red','LineWidth',2);

    % annotations
    mymapsettings

    % save
    set(gcf,'Renderer','zbuffer')
    saveas(gcf,fullfile(data.file.outputimages, 'Fig 4 - Species Records.png'))
    close
    
    % logmsg(0,'GBIF data retrieval completed')
catch ME
    logmsg(ME,'GBIF data retrieval failed')
end
