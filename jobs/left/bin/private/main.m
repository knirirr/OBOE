% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function data = main(data)
% MAIN  Local Ecological Footprint Tool.
%
% Implemented for automation on the VIBRANT/OBOE automation server.
%
% Example:
%   Go to https://oboe.oerc.ox.ac.uk to run a LEFT job.

% ------------------------------------------------------------------------
border_km = 300; % border width
% ------------------------------------------------------------------------
% try to parse inputs as coordinates
data.coord.inner.min.lat = coordinates(data.args.minlatitude,'ns');
data.coord.inner.max.lat = coordinates(data.args.maxlatitude,'ns');
data.coord.inner.min.lon = coordinates(data.args.minlongitude,'ew');
data.coord.inner.max.lon = coordinates(data.args.maxlongitude,'ew');
if any(isnan([ ...
        data.coord.inner.min.lat.deg.num
        data.coord.inner.max.lat.deg.num
        data.coord.inner.min.lon.deg.num
        data.coord.inner.max.lon.deg.num
        ]))
    data.job.status = 'Failed';
    data.job.exception = 'Can''t read coordinates.<br>Check format?';
    logmsg(1,'Coordinates don''t scan.')
    return
end
% check that min and max are the right way round
%   swap if they aren't
if data.coord.inner.min.lat.deg.num > data.coord.inner.max.lat.deg.num
    t = data.coord.inner.min.lat;
    data.coord.inner.min.lat = data.coord.inner.max.lat;
    data.coord.inner.max.lat = t;
    logmsg(0,'Latitude min/max values swapped');
end
if data.coord.inner.min.lon.deg.num > data.coord.inner.max.lon.deg.num
    t = data.coord.inner.min.lon;
    data.coord.inner.min.lon = data.coord.inner.max.lon;
    data.coord.inner.max.lon = t;
    logmsg(0,'Longitude min/max values swapped');
end
% check that lats are ns and lons are ew
%   can't correct if they aren't
if ~isempty(regexp(data.coord.inner.min.lat.dms.str,'[EW]', 'once')) ...
        || ~isempty(regexp(data.coord.inner.max.lat.dms.str,'[EW]', 'once')) ...
        || ~isempty(regexp(data.coord.inner.min.lon.dms.str,'[NS]', 'once')) ...
        || ~isempty(regexp(data.coord.inner.max.lon.dms.str,'[NS]', 'once'))
    data.job.status = 'Failed';
    data.job.exception = 'Lat/Lon entries are mixed up.<br>Check input?';
    logmsg(1,'Coordinates don''t scan.')
    return
end 
% ------------------------------------------------------------------------
% define inner zone
ilat1 = data.coord.inner.min.lat.deg.num;
ilat2 = data.coord.inner.max.lat.deg.num;
ilon1 = data.coord.inner.min.lon.deg.num;
ilon2 = data.coord.inner.max.lon.deg.num;
%   midpoint
midlon = ilon1 + (ilon2 - ilon1) ./ 2;
%   inner polygon
lat = [ilat1; ilat2; ilat2; ilat1; ilat1];
lon = [ilon1; ilon1; ilon2; ilon2; ilon1];
ipoly = makepoly(lat,lon,'NAME','Inner zone');
data.coord.inner.poly = ipoly;
% ------------------------------------------------------------------------
% define outer zone
border_deg = km2deg(border_km); 
N = 0; E = 90; S = 180; W = 270;
[olat1,~] = reckon(ilat1,ilon1,border_deg,S);
[olat2,~] = reckon(ilat2,ilon1,border_deg,N);
[~,olon1] = reckon(min(abs([ilat1,ilat2])),ilon1,border_deg,W);
[~,olon2] = reckon(min(abs([ilat1,ilat2])),ilon2,border_deg,E);
data.coord.outer.min.lat = coordinates(olat1,'ns');
data.coord.outer.max.lat = coordinates(olat2,'ns');
data.coord.outer.min.lon = coordinates(olon1,'ew');
data.coord.outer.max.lon = coordinates(olon2,'ew');
%   outer polygon
lat = [olat1; olat2; olat2; olat1; olat1];
lon = [olon1; olon1; olon2; olon2; olon1];
opoly = makepoly(lat,lon,'NAME','Outer zone');
data.coord.outer.poly = opoly;
% ------------------------------------------------------------------------
% get the tile number and update the path to data files
[tilen,refmat] = tiletable(olon1,olat1);
if ~isempty(tilen)
    logmsg(0,'Study site is in tile %i',tilen)
else
    data.job.status = 'Failed';
    data.job.exception = 'Can''t determine tile number';
    logmsg(1,'Can''t determine tile number')
    return
end
data.tile.number = tilen;
data.tile.refmat = refmat;
data = pathto_data(data,tilen);
% ------------------------------------------------------------------------
% read the mask and check the study site is terrestrial
try
    [data.map.mask.a, ...
     data.map.mask.bbox, ...
     data.map.mask.refmat, ...
     data.map.mask.info] = mygeotiffread( ...
        data.file.mask, ...
        data.coord.inner.poly.BoundingBox, ...
        data.tile.refmat);

    if any(data.map.mask.a(:))
        logmsg(0,'Terrestrial coordinates check OK')
    else
        data.job.status = 'Failed';
        data.job.exception = 'Terrestrial coordinates check failed';
        logmsg(1,'Terrestrial coordinates check failed')
        return
    end
catch ME
    data.job.status = 'Failed';
    data.job.exception = 'Failed while reading the mask';
    logmsg(ME,'Failed while reading the mask')
    return
end    
% ------------------------------------------------------------------------
% get the list countries that intersect with the inner zone
try
    data.country.shape = isintersect(data.coord.inner.poly,data.file.countries);
    if isempty(data.country.shape)
        error('Country list is empty')
    end
%     for i = 1:numel(data.country.shape)
%         data.country.list{i} = data.country.shape(i).NAME;
%     end
    data.country.list = {data.country.shape(:).NAME};
    data.country.iso2 = {data.country.shape(:).ISO2};
    logmsg(0,'List of countries: %s',sprintf('%s; ',data.country.list{:}))
catch ME
    data.job.status = 'Failed';
    data.job.exception = 'Failed while getting the list of countries';
    logmsg(ME,'Failed while getting the list of countries')
    return
end    





% ------------------------------------------------------------------------
% figures
% ------------------------------------------------------------------------
% figure 1a - schematic of the study area
try 
    if ~data.dev.location
        error('---- Development skip flag set ----')
    end
    data = schematic(data);
    data = location(data);
    logmsg(0,'Figure 1a - Site Schematic completed')
    logmsg(0,'Figure 1b - Location Map completed')
catch ME
    logmsg(ME,'Figures 1a or 1b - Location Maps failed')
end
% ------------------------------------------------------------------------
% figure 1c - street map
try 
    if ~data.dev.streetmap
        error('---- Development skip flag set ----')
    end
    data = streetmap(data);
    if data.streetmap.status
        logmsg(0,'Figure 1c - Street Map completed')
    else
        logmsg(1,'Figure 1c - Street Map not completed')
    end
catch ME
    logmsg(ME,'Figure 1c - Street Map failed')
end
% ------------------------------------------------------------------------
% figure 2 - globcover base map
try 
    if ~data.dev.globcover
        error('---- Development skip flag set ----')
    end
    data = globcover(data);
    savemapdata(data,'globcover')
    logmsg(0,'Figure 2 - Globcover Map completed')
catch ME
    logmsg(ME,'Figure 2 - Globcover Map failed')
end
% ------------------------------------------------------------------------
% figure 3 - eco-regions intersecting with the outer zone
try 
    if ~data.dev.ecoregions
        error('---- Development skip flag set ----')
    end
    data = ecoregions(data);
    logmsg(0,'Figure 3 - Ecoregions Map completed')
catch ME
    logmsg(ME,'Figure 3 - Ecoregions Map failed')
end
% ------------------------------------------------------------------------
% figure 4 - sample records
try 
    if ~data.dev.speciesrecords
        error('---- Development skip flag set ----')
    end
    data = speciesrecords(data);
    logmsg(0,'Figure 4 - Species Records Map completed')
catch ME
    logmsg(ME,'Figure 4 - Species Records Map failed')
end
% ------------------------------------------------------------------------
% figure 5 - dissimilarity
try 
    if ~data.dev.betadiversity
        error('---- Development skip flag set ----')
    end
    data = dissimilarity(data);
    savemapdata(data,'dissimilarity')
    logmsg(0,'Figure 5 - Dissimilarity Map completed')
catch ME
    logmsg(ME,'Figure 5 - Dissimilarity Map failed')
end
% ------------------------------------------------------------------------
% figure 6 - vulnerability  
try 
    if ~data.dev.vulnerability
        error('---- Development skip flag set ----')
    end
    data = vulnerablespecies(data);
    savemapdata(data,'vulnerability')
    logmsg(0,'Figure 6 - Vulnerability Map completed')
catch ME
    logmsg(ME,'Figure 6 - Vulnerability Map failed')
end
% ------------------------------------------------------------------------
% figure 7 - fragmentation 
try 
    if ~data.dev.fragmentation
        error('---- Development skip flag set ----')
    end
    data = fragmentation(data);
    savemapdata(data,'fragmentation')
    logmsg(0,'Figure 7 - Fragmentation Map completed')
catch ME
    logmsg(ME,'Figure 7 - Fragmentation Map failed')
end
% ------------------------------------------------------------------------
% figure 8 - connectivity - migratory species 
try 
    if ~data.dev.migratoryspecies
        error('---- Development skip flag set ----')
    end
    data = migratoryspecies(data);
    savemapdata(data,'migratory')
    logmsg(0,'Figure 8 - Migratory Species Map completed')
catch ME
    logmsg(ME,'Figure 8 - Migratory Species Map failed')
end
% ------------------------------------------------------------------------
% figure 9 - connectivity - hydrosheds 
try 
    if ~data.dev.hydrosheds
        error('---- Development skip flag set ----')
    end
    data = hydrosheds(data);
    savemapdata(data,'hydrosheds')
    logmsg(0,'Figure 9 - Hydrosheds Map completed')
catch ME
    logmsg(ME,'Figure 9 - Hydrosheds Map failed')
end
% ------------------------------------------------------------------------
% figure 10 - resilience 
try 
    if ~data.dev.resilience
        error('---- Development skip flag set ----')
    end
    data = resilience(data);
    savemapdata(data,'resilience')
    logmsg(0,'Figure 10 - Resilience Map completed')
catch ME
    logmsg(ME,'Figure 10 - Resilience Map failed')
end
% ------------------------------------------------------------------------
% figure 11 - summary 
try 
    if ~data.dev.summary
        error('---- Development skip flag set ----')
    end
    data = summary(data);
    savemapdata(data,'summary')
    logmsg(0,'Figure 11 - Summary Map completed')
catch ME
    logmsg(ME,'Figure 11 - Summary Map failed')
end
% ------------------------------------------------------------------------
% strings for output
%   inner zone
try
    data.output.inner_min_lat_deg = data.coord.inner.min.lat.deg.str;
    data.output.inner_max_lat_deg = data.coord.inner.max.lat.deg.str;
    data.output.inner_min_lon_deg = data.coord.inner.min.lon.deg.str;
    data.output.inner_max_lon_deg = data.coord.inner.max.lon.deg.str;
    data.output.inner_min_lat_dms = data.coord.inner.min.lat.dms.str;
    data.output.inner_max_lat_dms = data.coord.inner.max.lat.dms.str;
    data.output.inner_min_lon_dms = data.coord.inner.min.lon.dms.str;
    data.output.inner_max_lon_dms = data.coord.inner.max.lon.dms.str;
    data.output.inner_distance_ns = sprintf('%0.2f',ipoly.dist_ns_km);
    data.output.inner_distance_ew = sprintf('%0.2f',ipoly.dist_ew_km);
    data.output.inner_surface_area = sprintf('%0.2f',ipoly.area_km2);
catch ME
end

%   outer zone
try
    data.output.outer_min_lat_deg = data.coord.outer.min.lat.deg.str;
    data.output.outer_max_lat_deg = data.coord.outer.max.lat.deg.str;
    data.output.outer_min_lon_deg = data.coord.outer.min.lon.deg.str;
    data.output.outer_max_lon_deg = data.coord.outer.max.lon.deg.str;
    data.output.outer_min_lat_dms = data.coord.outer.min.lat.dms.str;
    data.output.outer_max_lat_dms = data.coord.outer.max.lat.dms.str;
    data.output.outer_min_lon_dms = data.coord.outer.min.lon.dms.str;
    data.output.outer_max_lon_dms = data.coord.outer.max.lon.dms.str;
    data.output.outer_distance_ns = sprintf('%0.2f',opoly.dist_ns_km);
    data.output.outer_distance_ew = sprintf('%0.2f',opoly.dist_ew_km);
    data.output.outer_surface_area = sprintf('%0.2f',opoly.area_km2);
catch ME
end

%   GBIF data
try
    data.output.nTaxonNames_Amphibia = sprintf('%i',data.gbif.Amphibia.nTaxonNames);
    data.output.nLocalities_Amphibia = sprintf('%i',data.gbif.Amphibia.nLocalities);
    data.output.nMaxColocated_Amphibia = sprintf('%i',data.gbif.Amphibia.nMaxColocated);
    data.output.nTaxonNames_Reptilia = sprintf('%i',data.gbif.Reptilia.nTaxonNames);
    data.output.nLocalities_Reptilia = sprintf('%i',data.gbif.Reptilia.nLocalities);
    data.output.nMaxColocated_Reptilia = sprintf('%i',data.gbif.Reptilia.nMaxColocated);
    data.output.nTaxonNames_Mammalia = sprintf('%i',data.gbif.Mammalia.nTaxonNames);
    data.output.nLocalities_Mammalia = sprintf('%i',data.gbif.Mammalia.nLocalities);
    data.output.nMaxColocated_Mammalia = sprintf('%i',data.gbif.Mammalia.nMaxColocated);
    data.output.nTaxonNames_Aves= sprintf('%i',data.gbif.Aves.nTaxonNames);
    data.output.nLocalities_Aves = sprintf('%i',data.gbif.Aves.nLocalities);
    data.output.nMaxColocated_Aves = sprintf('%i',data.gbif.Aves.nMaxColocated);
    data.output.nTaxonNames_Plantae = sprintf('%i',data.gbif.Plantae.nTaxonNames);
    data.output.nLocalities_Plantae = sprintf('%i',data.gbif.Plantae.nLocalities);
    data.output.nMaxColocated_Plantae = sprintf('%i',data.gbif.Plantae.nMaxColocated);
    data.output.nTaxonNames_all = sprintf('%i',data.gbif.all.nTaxonNames);
    data.output.nLocalities_all = sprintf('%i',data.gbif.all.nLocalities);
    data.output.nMaxColocated_all = sprintf('%i',data.gbif.all.nMaxColocated);
catch ME
end

%   countries
try
    data.output.countries = [sprintf('%s; ',data.country.list{1:end-1}) data.country.list{end}];
    if numel(data.country.list)>1
        data.output.country_ies = 'Countries';
    else
        data.output.country_ies = 'Country';
    end
catch ME
end

%   top-message
data.output.top_message = '';
try
    if ipoly.area_km2 < 20*20
        data.output.top_message = 'Please note that the area specified is considerably smaller than expected. At a spatial resolution of 300m the pixel density is sparse and relevant structure in the map data may be missed. Consider specifying a study area in the order of 100x100 km, or roughly 1x1 degrees.';
    end
    if ipoly.area_km2 > 500*500
        data.output.top_message = 'Please note that the area specified is considerably larger than expected. At a spatial resolution of 300m the pixel density is far greater than can be displayed. Consider specifying a study area in the order of 100x100 km, or roughly 1x1 degrees.';
    end
catch ME
end



