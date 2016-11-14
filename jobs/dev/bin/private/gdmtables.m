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
function data = gdmtables(data)

try
    for bio_ = {'bio1' 'bio4' 'bio12' 'bio15' 'nitrogen' 'fieldcap' 'wetdist' 'hydrosheds'}
        bio = char(bio_);
        [gdm_bio.(bio),gdm_bbox,gdm_refmat,~] = mygeotiffread( ...
            data.file.(bio), ...
            data.coord.outer.poly.BoundingBox, ...
            data.tile.refmat);
    end
    gdm_size = size(gdm_bio.(bio));
catch ME
    logmsg(ME,'Failed while reading WorlClim data files')
end

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
        gdm_res = spalloc(prod(gdm_size),numel(uTaxa),numel(taxonName));
        for i = 1:numel(uTaxa)
            k = strcmp(uTaxa(i),taxonName);
            try
%                 [m,n] = latlon2pix(gdm_refmat,myLat(k),myLon(k));
%                 M = ceil(m-0.5); M(M==0) = 1;
%                 N = ceil(n-0.5); N(N==0) = 1;
                [M,N] = latlon2abspix(gdm_refmat,myLat(k),myLon(k));
%                j = sub2ind(gdm_size,ceil(M),ceil(N));
                j = sub2ind(gdm_size,M,N);
                gdm_res(j,i) = 1;
            catch ME
                logmsg(ME,'Failed while converting lat/lon to pix')
            end
        end
        
        
        k = any(gdm_res,2);
        gdm_res = gdm_res(k,:);
        gdm_id = find(k);
        [m,n] = ind2sub(gdm_size,find(k));
        [gdm_lat,gdm_lon] = pix2latlon(gdm_refmat,m,n);

        [m,~] = size(gdm_res);
        limit = 2000;
        if m>limit
            r = randperm(m);
            r = r(1:limit);
            gdm_res = gdm_res(r,:);
            gdm_res = gdm_res(:,any(gdm_res)); 
            gdm_id = gdm_id(r);
            gdm_lat = gdm_lat(r);
            gdm_lon = gdm_lon(r);
            logmsg(0,sprintf('Size of SITE_RES matrix reduced for %s',taxonConcept))
        end
        
        gdm_res = full(gdm_res);

        gdm_bio1 = gdm_bio.bio1(gdm_id);
        gdm_bio4 = gdm_bio.bio4(gdm_id);
        gdm_bio12 = gdm_bio.bio12(gdm_id);
        gdm_bio15 = gdm_bio.bio15(gdm_id);
        gdm_nitrogen = gdm_bio.nitrogen(gdm_id);
        gdm_fieldcap = gdm_bio.fieldcap(gdm_id);
        gdm_wetdist = gdm_bio.wetdist(gdm_id);
        gdm_hydrosheds = gdm_bio.hydrosheds(gdm_id);
        
        gdmSpFile = fullfile(data.file.gdmdata,[taxonConcept '_sp.txt']);
        try
            fid_sp = fopen(gdmSpFile,'w');
            for i = 1:numel(uTaxa)-1
                fprintf(fid_sp,'%s,',uTaxa{i});
            end
            fprintf(fid_sp,'%s\n',uTaxa{i+1});
            for i = 1:size(gdm_res,1)
                for j = 1:size(gdm_res,2)-1
                    fprintf(fid_sp,'%i,',gdm_res(i,j));
                end
                fprintf(fid_sp,'%i\n',gdm_res(i,j+1));
            end
            fclose(fid_sp);
        catch ME
            fclose(fid_sp);
            logmsg(ME,'Crashed while writing GDM species records for %s',taxonConcept)
        end
        
        gdmXYFile = fullfile(data.file.gdmdata,[taxonConcept '_xy.txt']);
        try
            fid_xy = fopen(gdmXYFile,'w');
            fprintf(fid_xy,'ID,LAT,LON\n');
            for i = 1:numel(gdm_id)
                fprintf(fid_xy,'%i,%f,%f\n',gdm_id(i),gdm_lat(i),gdm_lon(i));
            end
            fclose(fid_xy);
        catch ME
            fclose(fid_xy);
            logmsg(ME,'Crashed while writing GDM coordinate records for %s',taxonConcept)
        end
        
        gdmEnvFile = fullfile(data.file.gdmdata,[taxonConcept '_env.txt']);
        try
            fid_env = fopen(gdmEnvFile,'w');
            switch taxonConcept
                case {'Aves' 'Mammalia' 'Reptilia' 'Amphibia'}
                    fprintf(fid_env,'BIO1,BIO4,BIO12,BIO15,WETDIST,HYDROSHEDS\n');
                    for i = 1:numel(gdm_id)
                        fprintf(fid_env,'%f,%f,%f,%f,%f,%f\n',gdm_bio1(i),gdm_bio4(i),gdm_bio12(i),gdm_bio15(i),gdm_wetdist(i),gdm_hydrosheds(i));
                    end
                case {'Plantae'}
                    fprintf(fid_env,'BIO1,BIO4,BIO12,BIO15,NITROGEN,FIELDCAP\n');
                    for i = 1:numel(gdm_id)
                        fprintf(fid_env,'%f,%f,%f,%f,%f,%f\n',gdm_bio1(i),gdm_bio4(i),gdm_bio12(i),gdm_bio15(i),gdm_nitrogen(i),gdm_fieldcap(i));
                    end
            end
            fclose(fid_env);
        catch ME
            fclose(fid_env);
            logmsg(ME,'Crashed while writing GDM coordinate records for %s',taxonConcept)
        end
    end
catch ME
    logmsg(ME,'Failed while writing GDM files')
end


