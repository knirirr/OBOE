% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function [data,gdm_max] = gdm_R(data)

% Set up an R session
try
    % Start a session
    [status_session_open, msg, handle] = openR; 
    if ~status_session_open
        logmsg(1,'Failed while opening R session')
        logmsg(1,msg)
    end

    % Set the working directory
    hostname = deblank(evalc('!hostname'));
    switch hostname
        case 'gecko'
            wd = 'C:\\Users\\Neil\\Documents\\SVN\\jobs\\matlab\\gdm';
        % case {'nyogtha' 'syncerus' 'hippotragus'}
        otherwise
            wd = 'C:\\Users\\oerc0003\\Documents\\SVN\\jobs\\matlab\\gdm';
        % otherwise
        %     logmsg(1,sprintf('Host "%s" not recognised so can''t set path to GDM functions',hostname));
    end
    [~, status_wd_set, msg] = evalR(['setwd("' wd '")']);
    if ~status_wd_set
        logmsg(1,'Failed while setting R session working directory')
        logmsg(1,msg)
    end

    % Check where we are
    [~, status_wd_get, msg] = evalR('getwd()');
    if ~status_wd_get
        logmsg(1,'Failed checking R session working directory')
        logmsg(1,msg)
    end

    % Load the GDM functions
    [~, status_gdmfuncs, msg] = evalR('source("gdmfuncs.1.1.R")', 0);
    if ~status_gdmfuncs
        logmsg(1,'Failed while loading GDM functions')
        logmsg(1,msg)
    end
    % logmsg(0,'R session started')
catch ME
    logmsg(ME,'Failed while setting up R session')
end

% Loop over taxon groups
try
    taxonConcepts = {'Reptilia' 'Amphibia' 'Mammalia' 'Aves' 'Plantae' };
    gdm_out = struct([]);
    for tc = 1:numel(taxonConcepts)
        try
            taxonConcept = taxonConcepts{tc};
            if data.gbif.(taxonConcept).nTaxonNames >= 10
                % Read the data files
                gdm_env_file = fullfile(data.file.gdmdata,[taxonConcept '_env.txt']);
                gdm_sp_file = fullfile(data.file.gdmdata,[taxonConcept '_sp.txt']);
                gdm_xy_file = fullfile(data.file.gdmdata,[taxonConcept '_xy.txt']);
                site_env = csvread(gdm_env_file,1,0);
                site_res = csvread(gdm_sp_file,1,0);
                site_geo = csvread(gdm_xy_file,1,0);

                % Pass data to R
                [status_site_env, msg] = putRdata('site_env',site_env);
                if ~status_site_env
                    logmsg(1,'Failed while putting ENV data...')
                    logmsg(1,msg)
                end
                [status_site_res, msg] = putRdata('site_res',site_res);
                if ~status_site_res
                    logmsg(1,'Failed while putting RES data...')
                    logmsg(1,msg)
                end

                % Fit a Generalized Dissimilarity Model
                geo = 'FALSE'; wtype = 'standard'; w = 'NULL';
                sample = 10000; m = size(site_res,1); sample = min(m*(m-1)/2, sample);
                rcmd = sprintf('mymod <- gdm.fit(site_env, site_res, geo = %s, wtype = "%s", w = %s, sample = %i)', ...
                    geo, wtype, w, sample);
                [result, status_gdm_fit, msg] = evalR(rcmd, 0);
                if ~status_gdm_fit
                    logmsg(1,'Failed while doing GDM.FIT')
                    logmsg(1,msg)
                    disp(result)
                end

                % Calculate site pairs
                [m,n] = size(site_env);
                M = ((m*m)-m)/2;

                site_matrixA = zeros(M,n);
                site_matrixB = zeros(M,n);
                site_pairs = zeros(M,6);

                row = 0;
                for i = 1:m-1
                    for j = i+1:m
                        row = row + 1;
                        site_matrixA(row,:) = site_env(i,:);
                        site_matrixB(row,:) = site_env(j,:);
                        site_pairs(row,:) = [site_geo(i,:) site_geo(j,:)];
                    end
                end

                % Delete rows with invalid data
                k = ~any(site_matrixB == -32768, 2);
                n_invalid = numel(k) - sum(k);
                if n_invalid
                    site_matrixA = site_matrixA(k,:);
                    site_matrixB = site_matrixB(k,:);
                    site_pairs = site_pairs(k,:);
                    % logmsg(0,sprintf('%i invalid records deleted',n_invalid));
                end

                % Pass site pairs data to R
                [status_site_matrixA, msg] = putRdata('site_matrixA',site_matrixA);
                if ~status_site_matrixA
                    logmsg(1,'Failed while putting MatrixA')
                    logmsg(1,msg)
                end
                [status_site_matrixB, msg] = putRdata('site_matrixB',site_matrixB);
                if ~status_site_matrixB
                    logmsg(1,'Failed while putting MatrixB')
                    logmsg(1,msg)
                end

                % Run GDM prediction on site pairs
                [result, status_gdm_predict_site, msg] = evalR('myres_by_site <- gdm.predict(mymod, site_matrixA, site_matrixB)', 0);
                if ~status_gdm_predict_site
                    logmsg(1,'Failed while running GDM prediction on site pairs')
                    logmsg(1,msg)
                    disp(result)
                end

                % Get prediction values back from R
                [myres_by_site, status_myres_by_site, msg] = getRdata('myres_by_site');
                if ~status_myres_by_site
                    logmsg(1,'Failed while getting site matix')
                    logmsg(1,msg)
                end

                % Calculate the distance weighted average for each site
                x = site_pairs(:,2) - site_pairs(:,5);
                y = site_pairs(:,3) - site_pairs(:,6);
                d = sqrt((x.^2) + (y.^2));
                isd = 1./(d.^2);

                k = unique(site_geo(:,1));
                site_p = zeros(size(k));
                for i = 1:numel(k)
                    j = site_pairs(:,1)==k(i) | site_pairs(:,4)==k(i);
                    site_p(i) = sum(myres_by_site(j)'.*isd(j))./sum(isd(j));
                end

                % Read environmental grids - for inner poly
                
%                 For plant species, the covariates include: 
% 
%                 annual mean temperature (bio1)
%                 annual mean precipitation (bio12)
%                 temperature seasonality (bio4)
%                 precipitation seasonality (bio15)
%                 % nitrogen in soil (nitrogen)
%                 % soil water holding capacity (fieldcap)
% 
%                 For amphibians, birds, mammals and reptiles, the covariates are: 
% 
%                 distance to water bodies (wetdist)
%                 HYDROSHEDS (hydrosheds)
%                 the same climatic indicators as used for plant species (bio1, bio4, bio12, bio15)    

                try
                    switch taxonConcept
                        case {'Plantae'}
                            list = {'bio1' 'bio4' 'bio12' 'bio15' 'nitrogen' 'fieldcap'};
                        case {'Reptilia' 'Amphibia' 'Mammalia' 'Aves'}
                            list = {'bio1' 'bio4' 'bio12' 'bio15' 'wetdist' 'hydrosheds'};
                    end
                    for bio_ = list
                        bio = char(bio_);
                        % [a,r,bb] = geotiffsubset(readfile,writefile,bbox,refmat,name,b)
%                         [gdm_bio.(bio),gdm_refmat,gdm_bbox] = geotiffsubset( ...
%                                 data.file.(bio), ...
%                                 fullfile(data.file.outputdata,['gdm_' bio '.tif']), ...
%                                 data.coord.inner.poly.BoundingBox, ...
%                                 data.tile.refmat, ...
%                                 ['gdm_' bio], ...
%                                 []);
                            
                        [gdm_bio.(bio),gdm_bbox,gdm_refmat,~] = mygeotiffread( ...
                            data.file.(bio), ...
                            data.coord.inner.poly.BoundingBox, ...
                            data.tile.refmat);
                            
                            
                    end
                    gdm_size = size(gdm_bio.(bio));
                catch ME
                    logmsg(ME,'Failed while reading WorlClim data files')
                end

                switch taxonConcept
                    case {'Plantae'}
                        grid_env = [gdm_bio.bio1(:) gdm_bio.bio4(:) gdm_bio.bio12(:) gdm_bio.bio15(:) gdm_bio.nitrogen(:) gdm_bio.fieldcap(:)];
                    case {'Reptilia' 'Amphibia' 'Mammalia' 'Aves'}
                        grid_env = [gdm_bio.bio1(:) gdm_bio.bio4(:) gdm_bio.bio12(:) gdm_bio.bio15(:) gdm_bio.wetdist(:) gdm_bio.hydrosheds(:)];
                end
                
                % grid_env = [gdm_bio.bio1(:) gdm_bio.bio4(:) gdm_bio.bio12(:) gdm_bio.bio15(:)];

                [nrows,ncols] = size(gdm_bio.bio1);
                xllcorner = gdm_bbox(1,1);
                yllcorner = gdm_bbox(1,2);
                cellsize = gdm_refmat(2,1);

                % Axes as vectors
                x_axis = xllcorner:cellsize:(xllcorner+(cellsize*(ncols-1)));
                y_axis = (yllcorner:cellsize:(yllcorner+(cellsize*(nrows-1))))';

                % Axes as matrices
                X_axis = ones(nrows,1)*x_axis;
                Y_axis = y_axis*ones(1,ncols);

                grid_geo = [X_axis(:) Y_axis(:) (1:numel(X_axis))'];

                [grid_p,k] = randpoints(grid_env,grid_geo);

                
                % Interpolate across the grid
                F = TriScatteredInterp(grid_geo(k,1),grid_geo(k,2),grid_p,'nearest');
                grid_q = F(grid_geo(:,1),grid_geo(:,2));
                gdm_out(1).(taxonConcept) = reshape(grid_q,nrows,ncols);
                % logmsg(0,sprintf('GDM complete for %s', taxonConcept))
            end
        catch ME
            logmsg(ME,sprintf('Failed during GDM for %s', taxonConcept))
        end
    end
catch ME
    logmsg(ME,'GDM failed while looping over taxa')
end

% Close the R session
try
    [status_session_close, msg] = closeR(handle);
    if status_session_close
        % logmsg(0,'R session ended')
    else
        logmsg(1,'Failed while clossing R session')
        logmsg(1,msg)
    end
catch ME
    logmsg(ME,'Failed while closing R session')
end

% Get the max of the five GDM outputs
% try
%     fields = fieldnames(gdm_out);
%     if ~isempty(fields)
%         gdm_max = gdm_out.(char(fields(1)));
%         for i = 2:numel(fields)
%             field = char(fields(i));
%             gdm_max = max(gdm_max,gdm_out.(field));
%         end
%         % logmsg(0,'GDM max completed')
%     else
%         gdm_max = [];
%         logmsg(1,'GDM max not completed - not enough species data records')
%     end
% catch ME
%     logmsg(ME,'Failed while calculating max of all GDMs')
% end

try
    fields = fieldnames(gdm_out);
    [m,n] = size(gdm_out.(fields{1}));
    g = nan(m,n,numel(fields));
    if ~isempty(fields)
        for i = 1:numel(fields)
            field = char(fields(i));
            g(:,:,i) = gdm_out.(field);
        end
        gdm_max = max(g,[],3);
        gisnan = any(isnan(g),3);
        gdm_max(gisnan) = nan;
    else
        gdm_max = [];
        logmsg(1,'GDM max not completed - not enough species data records')
    end
catch ME
    logmsg(ME,'Failed while calculating max of all GDMs')
end


function [grid_p,k] = randpoints(grid_env,grid_geo,npairs)

% Iterate over a random sample of grid pairs
[m,n] = size(grid_env);
I = min(m,300);
J = 300;
A = randperm(m);
A = A(1:I)';
grid_pairs = zeros(I*J,6);
myres_by_grid = zeros(I*J,1);
for i = 1:numel(A)
    B = randperm(m);
    B = B(1:J)';
    % Make the grid pairs matrices
    grid_matrixA = ones(J,1)*double((grid_env(A(i),:)));
    grid_matrixB = grid_env(B,:);
    grid_pairs(((i-1)*J+1):(i*J),:) = [ones(J,1)*grid_geo(A(i),:) grid_geo(B,:)];
    % Pass grid pairs data to R
    [status_grid_matrixA, msg] = putRdata('grid_matrixA',grid_matrixA);
    if ~status_grid_matrixA
        logmsg(1,'Failed while putting MatrixA')
        logmsg(1,msg)
    end
    [status_grid_matrixB, msg] = putRdata('grid_matrixB',grid_matrixB);
    if ~status_grid_matrixB
        logmsg(1,'Failed while putting MatrixB')
        logmsg(1,msg)
    end
    % Run GDM predict on grid pairs
    [result, status_gdm_predict_grid, msg] = evalR('myres_by_grid <- gdm.predict(mymod, grid_matrixA, grid_matrixB)', 0);
    if ~status_gdm_predict_grid
        logmsg(1,'Failed while running GDM predict on grid pairs')
        logmsg(1,msg)
        disp(result)
    end
    % Get prediction values back from R
    [myres_by_grid_, status_myres_by_grid, msg] = getRdata('myres_by_grid');
    if ~status_myres_by_grid
        logmsg(1,'Failed while getting prediction values back from R')
        logmsg(1,msg)
    end
    % Append results
    try
        myres_by_grid(((i-1)*J+1):(i*J)) = myres_by_grid_; 
    catch ME
        logmsg(1,'Failed while updating myres_by_grid')
    end
end

% Calculate the distance weighted average for each grid cell
x = grid_pairs(:,1) - grid_pairs(:,4);
y = grid_pairs(:,2) - grid_pairs(:,5);
d = sqrt((x.^2) + (y.^2));
isd = 1./(d.^2);

k = unique([grid_pairs(:,3)]);
grid_p = zeros(size(k));
for i = 1:numel(k)
    j = grid_pairs(:,3)==k(i);
    grid_p(i) = sum(myres_by_grid(j).*isd(j))./sum(isd(j));    
end



function [grid_p,k] = mypoints(grid_env,grid_geo,myind)

% Iterate over a random sample of grid pairs
I = numel(myind);
J = numel(myind) - 1;
A = myind;
grid_pairs = zeros(I*J,6);
myres_by_grid = zeros(I*J,1);
for i = 1:I
    w = ones(I,1);
    w(i) = 0;
    B = myind(logical(w));
    % Make the grid pairs matrices
    grid_matrixA = ones(J,1)*double((grid_env(A(i),:)));
    grid_matrixB = grid_env(B,:);
    grid_pairs(((i-1)*J+1):(i*J),:) = [ones(J,1)*grid_geo(A(i),:) grid_geo(B,:)];
    % Pass grid pairs data to R
    [status_grid_matrixA, msg] = putRdata('grid_matrixA',grid_matrixA);
    if ~status_grid_matrixA
        logmsg(1,'Failed while putting MatrixA')
        logmsg(1,msg)
    end
    [status_grid_matrixB, msg] = putRdata('grid_matrixB',grid_matrixB);
    if ~status_grid_matrixB
        logmsg(1,'Failed while putting MatrixB')
        logmsg(1,msg)
    end
    % Run GDM predict on grid pairs
    [result, status_gdm_predict_grid, msg] = evalR('myres_by_grid <- gdm.predict(mymod, grid_matrixA, grid_matrixB)', 0);
    if ~status_gdm_predict_grid
        logmsg(1,'Failed while running GDM predict on grid pairs')
        logmsg(1,msg)
        disp(result)
    end
    % Get prediction values back from R
    [myres_by_grid_, status_myres_by_grid, msg] = getRdata('myres_by_grid');
    if ~status_myres_by_grid
        logmsg(1,'Failed while getting prediction values back from R')
        logmsg(1,msg)
    end
    % Append results
    myres_by_grid(((i-1)*J+1):(i*J)) = myres_by_grid_;    
end

% Calculate the distance weighted average for each grid cell
x = grid_pairs(:,1) - grid_pairs(:,4);
y = grid_pairs(:,2) - grid_pairs(:,5);
d = sqrt((x.^2) + (y.^2));
isd = 1./(d.^2);

k = unique([grid_pairs(:,3)]);
grid_p = zeros(size(k));
for i = 1:numel(k)
    j = grid_pairs(:,3)==k(i);
    grid_p(i) = nansum(myres_by_grid(j).*isd(j))./nansum(isd(j));    
end




