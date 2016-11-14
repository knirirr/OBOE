% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function data = getgbifdata(taxonConcept,data)
%GETGBIFDATA    Retrieve TaxonOccurrence records from the GBIF web service
%
%   DATA = GETGBIFDATA('TAXONCONCEPT',DATA)
%
%   Refer to the GBIF occurrence web service documentation at
%   http://data.gbif.org/ws/rest/occurrence

host = deblank(evalc('!hostname'));

% IP Addresses
% 172.24.13.85 karakal.private    karakal
% 172.24.13.86 gecko.private      gecko
% 172.24.13.87 nyogtha.private    nyogtha
% 172.24.13.88 syncerus.private   syncerus

url = 'http://172.24.13.85:8080/portal/ws/rest';
% url = 'http://data.gbif.org/ws/rest'; 

% switch host
%     case {'gecko' 'nyogtha' 'syncerus' 'hippotragus'} 
%         url = 'http://172.24.13.85:8080/portal/ws/rest';
%         % url = 'http://data.gbif.org/ws/rest'; 
%         
%     otherwise
%         logmsg(1,'Host name "%s" is not configured.',host);
%         return
% end

% Bounding box
boundingBox = num2cell(data.coord.isecoregion.poly.BoundingBox);
[minlongitude,maxlongitude,minlatitude,maxlatitude] = deal(boundingBox{:});

% REGEXP patterns 
pat.startIndex       = '<gbif:summary.*start="(?<startIndex>\d+)"';
pat.nextIndex        = '<gbif:summary.*next="(?<nextIndex>\d+)"';
pat.totalReturned    = '<gbif:summary.*totalReturned="(?<totalReturned>\d+)"';
pat.totalMatched     = '<gbif:summary.*totalMatched="(?<totalMatched>\d+)"';
pat.taxonOccurrence  = '<to:TaxonOccurrence.+?</to:TaxonOccurrence>';
pat.taxonName        = '<to:taxonName>(?<taxonName>.*)</to:taxonName>';
pat.decimalLatitude  = '<to:decimalLatitude>(?<decimalLatitude>[\+\-\.\d]+)</to:decimalLatitude>';
pat.decimalLongitude = '<to:decimalLongitude>(?<decimalLongitude>[\+\-\.\d]+)</to:decimalLongitude>';
pat.catalogNumber    = '<to:catalogNumber>(?<catalogNumber>.*)</to:catalogNumber>';
pat.gbifToKey        = '<to:TaxonOccurrence gbifKey="(?<gbifToKey>\d*)"';
pat.gbifTcKey        = '<tc:TaxonConcept gbifKey="(?<gbifTcKey>\d*)"';
pat.gbifAcKey        = '<tc:TaxonConcept gbifKey="(?<gbifAcKey>\d*)" status="accepted"';
pat.nameComplete     = '<tn:nameComplete>(?<nameComplete>.*)</tn:nameComplete>';
pat.specificEpithet  = '<tn:specificEpithet>(?<specificEpithet>.*)</tn:specificEpithet>';
pat.gbifStatements   = 'Please cite these data as follows:\s+(?<gbifCitations>.*)\s+-\s+</gbif:statements>';

% Taxon concept key
params = { ...
'format','brief', ...
'scientificname',taxonConcept, ... 
'maxresults','1000'};

nextIndex(1).nextIndex = '0';
recordCount = 0;
ac = {};
while ~isempty(nextIndex)
    thisIndex =  str2double(nextIndex.nextIndex);
    [content,status] = urlread([url '/taxon/list'],'get',[params 'startindex' nextIndex.nextIndex]);
    if status
        nextIndex = regexp(content,pat.nextIndex,'names');
        totalReturned = regexp(content,pat.totalReturned,'names');
        if ~isempty(totalReturned)
            recordCount = recordCount + str2double(totalReturned.totalReturned);
        end  
        to = regexp(content,pat.gbifAcKey,'names');
        for i = 1:numel(to)
            ac{end+1} = to(i).gbifAcKey;
        end
    else
    end
end








% Parameters
% format: brief, darwin, kml.
% basisofrecordcode: specimen, observation, living, germplasm, fossil, unknown.
maxresults = 1000;
params = { ...
'format','brief', ...
'basisofrecordcode','specimen', ...
'coordinateissues','false', ...
'minlatitude',num2str(minlatitude), ...
'maxlatitude',num2str(maxlatitude), ...
'minlongitude',num2str(minlongitude), ...
'maxlongitude',num2str(maxlongitude), ...
'maxresults',int2str(maxresults)};
for i = 1:numel(ac)
    params = [params {'taxonConceptKey',ac{i}}];
end


try
    nextIndex(1).nextIndex = '0';
    recordCount = 0;
    dataCount = 0;
    % records file
    allRecordsFile = fullfile(data.file.gbifdata,[taxonConcept '.txt']);
    fid = fopen(allRecordsFile,'w'); 
    % diagnostics file
    diagnosticData = fullfile(data.file.gbifdata,'diagnostic.txt');
    % fix = fopen(diagnosticData,'a');
    % status,startTime,stopTime,thisIndex,recordCount,dataCount,id/url
    % fprintf(fix,'%i %0.12f %0.12f %i %i %i "%s"\n',9,nan,nan,nan,nan,nan,data.job.id);
    failcount = 0;
    while ~isempty(nextIndex)
        thisIndex =  str2double(nextIndex.nextIndex);
        timeStart = now;
        [content,status] = urlread([url '/occurrence/list'],'get',[params 'startindex' nextIndex.nextIndex]);
        timeStop = now;
        if status
            nextIndex = regexp(content,pat.nextIndex,'names');
            totalReturned = regexp(content,pat.totalReturned,'names');
            if ~isempty(totalReturned)
                recordCount = recordCount + str2double(totalReturned.totalReturned);
            end  
            dataCount = dataCount + length(content);
            gs = regexp(content,pat.gbifStatements,'names');
            ct = regexp(gs.gbifCitations,char(10),'split');
            data.gbif.citations = unique([data.gbif.citations ct]);
            
            to = regexp(content,pat.taxonOccurrence,'match');
            for i = 1:numel(to)
                taxonName = regexp(to{i},pat.taxonName,'names');
                decimalLatitude = regexp(to{i},pat.decimalLatitude,'names');
                decimalLongitude = regexp(to{i},pat.decimalLongitude,'names');
                if ~isempty(taxonName) && ~isempty(decimalLatitude) && ~isempty(decimalLongitude)
                    fprintf(fid,'"%s" %s %s\n', ...
                        taxonName.taxonName, ...
                        decimalLatitude.decimalLatitude, ...
                        decimalLongitude.decimalLongitude);
                end
            end
        else
            logmsg(1,'Failed while reading %s at index %s',taxonConcept,nextIndex.nextIndex)
            failcount = failcount + 1;
            if failcount<5
                nextIndex.nextIndex = num2str(str2num(nextIndex.nextIndex)+1000);
            else
                nextIndex = []; % Don't bother
            end
        end
        queryUrl = sprintf('%s/list?%sstartindex=%i',url,sprintf('%s=%s&',params{:}),thisIndex);
        % status,startTime,stopTime,thisIndex,recordCount,dataCount,id/url
        %fprintf(fix,'%i %0.12f %0.12f %i %i %i "%s"\n',status,timeStart,timeStop,thisIndex,recordCount,dataCount,queryUrl);
    end
    fclose(fid);
    %fclose(fix);
catch ME
   logmsg(ME,'Crashed while reading GBIF records for %s',taxonConcept)
end

try
    try
        fid = fopen(allRecordsFile,'r');
        c = textscan(fid,'%q %f %f');
        fclose(fid);
    catch ME
        logmsg(ME,'Crashed while reading local records file for %s',taxonConcept)
    end
    [taxonName,decimalLatitude,decimalLongitude] = deal(c{:});
    
    n = numel(taxonName);
    genus = cell(n,1);
    species = cell(n,1);
    fullName = cell(n,1);
    name = regexp(taxonName,'^\s*(?<genus>\w+)\s+(?<species>\w+)','names');
    for i = 1:n
        if ~isempty(name{i})
            genus{i} = [upper(name{i}.genus(1)) lower(name{i}.genus(2:end))];
            species{i} = lower(name{i}.species);
        else
            genus{i} = '';
            species{i} = '';
        end
        fullName{i} = sprintf('%s %s',genus{i},species{i});
    end
    
    localities = [decimalLatitude decimalLongitude];
    
    % Exclude invalid names
    k = ~strcmpi(genus,'unknown') & ...
        ~strcmpi(genus,'unidentified') & ...
        ~strcmpi(genus,'Australopithecus') & ...
        ~strcmpi(genus,'Homo') & ...
        ~strcmpi(species,'') & ...
        ~strcmpi(species,'l') & ...
        ~strcmpi(species,'x') & ...
        ~strcmpi(species,'sp') & ...
        ~strcmpi(species,'cf') & ...
        ~strcmpi(species,'spp') & ...
        ~strcmpi(species,'unknown') & ...
        ~strcmpi(species,'unidentified');
        % Probably not exhaustive, but this should find most common
        % casses of unwanted names. The regexp switch \w will already
        % have excluded odd characters like '?' and '.', etc.
    fullName = fullName(k);
    localities = localities(k,:);
    
    % Intersection with ecoregions
    k = inpolygon(localities(:,2),localities(:,1), ...
        data.coord.isecoregion.poly.Lon,data.coord.isecoregion.poly.Lat);
    fullName = fullName(k);
    localities = localities(k,:);

    % Unique localities only
    k = false(numel(fullName),1);
    [~,i,j] = unique(fullName);
    for v = i'
        w = find(j==j(v));
        [~,f,~] = unique(localities(w,:),'rows');
        k(w(f)) = true;
    end
    fullName = fullName(k);
    localities = localities(k,:);
    [fullName,i] = sort(fullName);
    localities = localities(i,:);
catch ME
    logmsg(ME,'Crashed while collating GBIF records for %s',taxonConcept)
end

collatedRecordsFile = fullfile(data.file.gbifdata,[taxonConcept '.txt']);
try
    fid = fopen(collatedRecordsFile,'w');
    for i = 1:numel(fullName)
        fprintf(fid,'"%s" %0.4f %0.4f\n',fullName{i},localities(i,:));
    end
    fclose(fid);
catch ME
    logmsg(ME,'Crashed while writing GBIF records for %s',taxonConcept)
end

logmsg(0,'Found %i records for %i species in %s', ...
    numel(fullName),numel(unique(fullName)),taxonConcept)

