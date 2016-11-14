function data = main(data)
% MAIN  
%
% Implemented for automation on the OBOE automation server.
%
% Copyright 2012-2013, neil.caithness@oerc.ox.ac.uk

% ------------------------------------------------------------------------
% Make a geostruct from DATA.ARGS.COORDS
[data.gds,~,~] = readwkt(data.args.coords);
logmsg(0,'Coordinates read (Lat: %0.2f, %0.2f; Lon: %0.2f, %0.2f)', ...
    data.gds.BoundingBox(2,2),data.gds.BoundingBox(1,2), ...
    data.gds.BoundingBox(1,1),data.gds.BoundingBox(2,1));
% ------------------------------------------------------------------------
% Get the country shapes to add to the maps
data = countries(data);
% ------------------------------------------------------------------------
% Extract the subregions from the WorldClim data files
location = fullfile(data.dir.data,'worldclim','current_1950-2000','all_vars_30s','');
files = {
    'alt' ...
    'bio_1' 'bio_2' 'bio_3' 'bio_4' 'bio_5' 'bio_6' 'bio_7' 'bio_8' 'bio_9' ...
    'bio_10' 'bio_11' 'bio_12' 'bio_13' 'bio_14' 'bio_15' 'bio_16' 'bio_17' 'bio_18' 'bio_19' ...
    'prec_1' 'prec_2' 'prec_3' 'prec_4' 'prec_5' 'prec_6' 'prec_7' 'prec_8' 'prec_9' 'prec_10' 'prec_11' 'prec_12' ...
    'tmax_1' 'tmax_2' 'tmax_3' 'tmax_4' 'tmax_5' 'tmax_6' 'tmax_7' 'tmax_8' 'tmax_9' 'tmax_10' 'tmax_11' 'tmax_12' ...
    'tmin_1' 'tmin_2' 'tmin_3' 'tmin_4' 'tmin_5' 'tmin_6' 'tmin_7' 'tmin_8' 'tmin_9' 'tmin_10' 'tmin_11' 'tmin_12' ...
    'tmean_1' 'tmean_2' 'tmean_3' 'tmean_4' 'tmean_5' 'tmean_6' 'tmean_7' 'tmean_8' 'tmean_9' 'tmean_10' 'tmean_11' 'tmean_12' };
labels = {
    {'alt','ALT - Altitude (elevation above sea level)','metres (m)'}
    {'bio_1','BIO1 - Annual Mean Temperature','°C * 10'}
    {'bio_2','BIO2 - Mean Diurnal Range (Mean of monthly (max temp - min temp))','°C * 10'}
    {'bio_3','BIO3 - Isothermality (BIO2/BIO7) (*100)',''}
    {'bio_4','BIO4 - Temperature Seasonality (Standard Deviation *100)','°C * 1000'}
    {'bio_5','BIO5 - Max Temperature of Warmest Month','°C * 10'}
    {'bio_6','BIO6 - Min Temperature of Coldest Month','°C * 10'}
    {'bio_7','BIO7 - Temperature Annual Range (BIO5-BIO6)','°C * 10'}
    {'bio_8','BIO8 - Mean Temperature of Wettest Quarter','°C * 10'}
    {'bio_9','BIO9 - Mean Temperature of Driest Quarter','°C * 10'}
    {'bio_10','BIO10 - Mean Temperature of Warmest Quarter','°C * 10'}
    {'bio_11','BIO11 - Mean Temperature of Coldest Quarter','°C * 10'}
    {'bio_12','BIO12 - Annual Precipitation','millimetres (mm)'}
    {'bio_13','BIO13 - Precipitation of Wettest Month','millimetres (mm)'}
    {'bio_14','BIO14 - Precipitation of Driest Month','millimetres (mm)'}
    {'bio_15','BIO15 - Precipitation Seasonality (Coefficient of Variation)',''}
    {'bio_16','BIO16 - Precipitation of Wettest Quarter','millimetres (mm)'}
    {'bio_17','BIO17 - Precipitation of Driest Quarter','millimetres (mm)'}
    {'bio_18','BIO18 - Precipitation of Warmest Quarter','millimetres (mm)'}
    {'bio_19','BIO19 - Precipitation of Coldest Quarter','millimetres (mm)'}
    {'prec_1','PREC1 - January average monthly precipitation','millimetres (mm)'}
    {'prec_2','PREC2 - February average monthly precipitation','millimetres (mm)'}
    {'prec_3','PREC3 - March average monthly precipitation','millimetres (mm)'}
    {'prec_4','PREC4 - April average monthly precipitation','millimetres (mm)'}
    {'prec_5','PREC5 - May average monthly precipitation','millimetres (mm)'}
    {'prec_6','PREC6 - June average monthly precipitation','millimetres (mm)'}
    {'prec_7','PREC7 - July average monthly precipitation','millimetres (mm)'}
    {'prec_8','PREC8 - August average monthly precipitation','millimetres (mm)'}
    {'prec_9','PREC9 - September average monthly precipitation','millimetres (mm)'}
    {'prec_10','PREC10 - October average monthly precipitation','millimetres (mm)'}
    {'prec_11','PREC11 - November average monthly precipitation','millimetres (mm)'}
    {'prec_12','PREC12 - December average monthly precipitation','millimetres (mm)'}
    {'tmax_1','TMAX1 - January average monthly maximum temperature','°C * 10'}
    {'tmax_2','TMAX2 - February average monthly maximum temperature','°C * 10'}
    {'tmax_3','TMAX3 - March average monthly maximum temperature','°C * 10'}
    {'tmax_4','TMAX4 - April average monthly maximum temperature','°C * 10'}
    {'tmax_5','TMAX5 - May average monthly maximum temperature','°C * 10'}
    {'tmax_6','TMAX6 - June average monthly maximum temperature','°C * 10'}
    {'tmax_7','TMAX7 - July average monthly maximum temperature','°C * 10'}
    {'tmax_8','TMAX8 - August average monthly maximum temperature','°C * 10'}
    {'tmax_9','TMAX9 - September average monthly maximum temperature','°C * 10'}
    {'tmax_10','TMAX10 - October average monthly maximum temperature','°C * 10'}
    {'tmax_11','TMAX11 - November average monthly maximum temperature','°C * 10'}
    {'tmax_12','TMAX12 - December average monthly maximum temperature','°C * 10'}
    {'tmin_1','TMIN1 - January average monthly minimum temperature','°C * 10'}
    {'tmin_2','TMIN2 - February average monthly minimum temperature','°C * 10'}
    {'tmin_3','TMIN3 - March average monthly minimum temperature','°C * 10'}
    {'tmin_4','TMIN4 - April average monthly minimum temperature','°C * 10'}
    {'tmin_5','TMIN5 - May average monthly minimum temperature','°C * 10'}
    {'tmin_6','TMIN6 - June average monthly minimum temperature','°C * 10'}
    {'tmin_7','TMIN7 - July average monthly minimum temperature','°C * 10'}
    {'tmin_8','TMIN8 - August average monthly minimum temperature','°C * 10'}
    {'tmin_9','TMIN9 - September average monthly minimum temperature','°C * 10'}
    {'tmin_10','TMIN10 - October average monthly minimum temperature','°C * 10'}
    {'tmin_11','TMIN11 - November average monthly minimum temperature','°C * 10'}
    {'tmin_12','TMIN12- December average monthly minimum temperature','°C * 10'}
    {'tmean_1','TMEAN1 - January average monthly mean temperature','°C * 10'}
    {'tmean_2','TMEAN2 - February average monthly mean temperature','°C * 10'}
    {'tmean_3','TMEAN3 - March average monthly mean temperature','°C * 10'}
    {'tmean_4','TMEAN4 - April average monthly mean temperature','°C * 10'}
    {'tmean_5','TMEAN5 - May average monthly mean temperature','°C * 10'}
    {'tmean_6','TMEAN6 - June average monthly mean temperature','°C * 10'}
    {'tmean_7','TMEAN7 - July average monthly mean temperature','°C * 10'}
    {'tmean_8','TMEAN8 - August average monthly mean temperature','°C * 10'}
    {'tmean_9','TMEAN9 - September average monthly mean temperature','°C * 10'}
    {'tmean_10','TMEAN10 - October average monthly mean temperature','°C * 10'}
    {'tmean_11','TMEAN11 - November average monthly mean temperature','°C * 10'}
    {'tmean_12','TMEAN12 - December average monthly mean temperature','°C * 10'}};

% Header file for .bil files in the WoldClim distribution looks like this:
%
%         BYTEORDER     I;      presumably means INTEL, which is little-endian
%         LAYOUT        BIL
%         NROWS         18000
%         NCOLS         43200
%         NBANDS        1
%         NBITS         16
%         BANDROWBYTES  86400
%         TOTALROWBYTES 86400
%         BANDGAPBYTES  0
%         NODATA        -9999
%         ULXMAP        -179.995833333333333
%         ULYMAP        89.995833333333333
%         XDIM          0.008333333333333333
%         YDIM          0.008333333333333333
% 
%         DatabaseName  WorldClim
%         Version       1.4
%         Release         3
%         Created       ----
%         Projection    GEOGRAPHIC
%         Datum         WGS84
%         MinX          ----
%         MaxX          ----
%         MinY          ----
%         MaxY          ----
%         MinValue      ----
%         MaxValue      ----
%         Variable      ----
%         month         ----

% Parameters for makerefmat
lon11 = -179.995833333333333;
lat11 = 89.995833333333333;
dlon = 0.008333333333333333;
dlat = -0.008333333333333333;
refmat = makerefmat(lon11,lat11,dlon,dlat);
[rows,cols] = latlon2abspix(refmat,data.gds.BoundingBox([2,1],2),data.gds.BoundingBox(:,1));

% Parameters for multibandread
Size = [18000,43200,1];
Precision = 'int16';
Offset = 0;
Interleave = 'bil';
Byteorder = 'ieee-le';
Rows = {'Row','Range',rows};
Cols = {'Column','Range',cols};

missing = -9999;

% New refmat
R = makerefmat( ...
    'RasterSize',[diff(rows)+1,diff(cols)+1], ...
    'Latlim',data.gds.BoundingBox(:,2)', ...
    'Lonlim',data.gds.BoundingBox(:,1)');
    
% Colormap
C = jet(256);

% Iterate over all the WorldClim files
logmsg(0,'Reading WorldClim global files')
for i = 1:numel(files)
    try
        % read from the global file
        file = fullfile(location,[files{i} '.bil']);
        A = flipud(multibandread(file,Size,Precision,Offset,Interleave,Byteorder,Rows,Cols));
        % write the geotiff file
        file = fullfile(data.dir.work.output__,'data',[files{i} '.tif']);
        geotiffwrite(file,A,R)
        % convert missing values to nans
        A(A==missing) = nan;
        % calculate min and max values
        pd.Min = min(A(:)); 
        pd.Max = max(A(:));
        % write to the log file
        logmsg(0,'%i - %s (%i, %i)',i,files{i},pd.Min,pd.Max)
        % plot and save the map
        file = fullfile(data.dir.work.output__,'images','figures',[files{i} '.png']);
        mymap(file,indexedimage(A),C,R, ...
            'Colorbar', ...
            {'Location','EastOutside', ...
             'Limits',[pd.Min pd.Max], ...
             'Units',labels{i}{3}}, ...
            'Plot',data.countries.shape);
        file = fullfile(data.dir.work.output__,'images','figures',[files{i} '_h.png']);
        myhist(file,A,labels{i}{3},[min(A(:)) max(A(:))])
    catch ME
        logmsg(ME,'Failed to process %s',files{i})
    end
 end


% ------------------------------------------------------------------------
logmsg(0,'Computation complete');
% ------------------------------------------------------------------------
% Set the job status flags
if isempty(data.job.status), data.job.status = 'Success'; end
if isempty(data.job.exception), data.job.exception = 'None'; end
% ------------------------------------------------------------------------


% ------------------------------------------------------------------------
% Indexed image
function x = indexedimage(a,limits,mask)
if nargin<2
    limits = [min(a(:)) max(a(:))];
end
x = a - limits(1);
x = x ./ diff(limits);
x = x .* 254 + 1;
if nargin>=3
    x(mask) = 0;
end
x = uint8(x);

% ------------------------------------------------------------------------
% Map
function mymap(file,A,C,R,varargin)
C(1,:) = [0 32 96]./255; % mask
% figure settings
figure('renderer', 'zbuffer')
worldmap(A,R);
geoshow(A,C,R);
% edge, tick and font settings
setm(gca,'FEdgeColor','none')
setm(gca,'MLabelParallel','north');
setm(gca,'PLabelMeridian','west');
setm(gca,'LabelRotation','on');
setm(gca,'FontColor','black');
% projection  
idstr = getm(gca,'MapProjection');
idlist = cellstr(maps('idlist'));
namelist = cellstr(maps('namelist'));
namestr = char(namelist(strcmp(idlist,idstr)));
caption = sprintf('%s ',namestr);
g = get(gca);
yloc = g.YLim(1) - (g.YLim(2) - g.YLim(1)) .* 0.025;
xloc = g.XLim(2);
text(xloc,yloc,caption, ...
    'Color','black', ...
    'HorizontalAlignment','right', ...
    'FontSize',9, ...
    'FontAngle','normal');
% scaleruler 
g = get(gca);
yloc = g.YLim(1) + (g.YLim(2) - g.YLim(1)) .* 0.025;
if size(A,2)<=360*2
    scaleruler( ...
        'Color','black', ...
        'YLoc',yloc, ...
        'ZLoc',1);
end
% colorbar
if ~isempty(varargin)
    k = find(strcmp(varargin,'Colorbar'));
    if ~isempty(k)
        colormap(C(2:end,:))
        cbvar = varargin{k+1};
        cbh = colorbar;
        for j = 1:2:numel(cbvar)
            switch cbvar{j}
                case 'Limits'
                    if diff(cbvar{j+1})==0
                        logmsg(0,'Data are invariant')
                    else
                        % set YLim to data range in order to read the tick marks
                        set(cbh,'YLim',cbvar{j+1})
                        ticks = get(cbh,'YTickLabel');
                        % then set YLim back to indexed range [0 1]
                        set(cbh,'YLim',[0 1])
                        % and apply the tick marks read earlier
                        set(cbh,'YTick',(str2num(ticks)-cbvar{j+1}(1))/diff(cbvar{j+1}))
                        set(cbh,'YTickLabel',ticks)
                    end
                case 'Units'
                    set(get(cbh,'YLabel'),'String',cbvar(j+1))
                otherwise % e.g. Location
                    try
                        set(cbh,cbvar(j),cbvar(j+1))
                    catch ME
                        logmsg(ME,'Option for colorbar not recognised - %s',cbvar{j})
                    end
            end
        end
    end
end
% plot
if ~isempty(varargin)
    k = find(strcmp(varargin,'Plot'));
    if ~isempty(k)
        shapes = varargin{k+1};
        for i = 1:numel(shapes)
            plotm(shapes(i).Y,shapes(i).X,'k')
        end
    end
end
% title
if ~isempty(varargin)
    k = find(strcmp(varargin,'Title'));
    if ~isempty(k)
        title(varargin(k+1));
    end
end
% save
saveas(gcf,file)
close


% ------------------------------------------------------------------------
% Histogram
function myhist(file,A,label,limits)
hist(A(:),40)
xlabel(label)
if diff(limits)==0
    logmsg(0,'Data are invariant')
else
    xlim(limits)
end
h = findobj(gca,'Type','patch');
set(h,'FaceColor',[.5 .5 .5],'EdgeColor','k')
% save
saveas(gcf,file)
close



