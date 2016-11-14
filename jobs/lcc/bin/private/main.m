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
% Extract the subregions from the global Globcover images
glob = getglobcover(fullfile(data.dir.data,'globcover',''),data.gds);
data.lcc.imagesize = sprintf('%i x %i',glob.size);
logmsg(0,'Globcover images read (%i rows x %i cols)',size(glob.a5))
% ------------------------------------------------------------------------
% Calculate the class percentages and write as strings to DATA.LCC...
% a5
fstr = '%0.0f %%';
zstr = '~'; % '~0 %';
dnom = glob.nmask/100;
for i = 1:numel(glob.id)
    val = sum(glob.a5(:)==glob.id(i))./dnom;
    str = ''; 
    if val>0
        if val<1
            str = zstr;
        else
            str = sprintf(fstr,val); 
        end
    end
    data.lcc.a5.(sprintf('id_%i',glob.id(i))) = str;
end
% a9
for i = 1:numel(glob.id)
    val = sum(glob.a9(:)==glob.id(i))./dnom;
    str = ''; 
    if val>0
        if val<1
            str = zstr;
        else
            str = sprintf(fstr,val); 
        end
    end
    data.lcc.a9.(sprintf('id_%i',glob.id(i))) = str;
end
% nc
for i = 1:numel(glob.id)
    val = sum(glob.nc(:)==glob.id(i))./dnom;
    str = ''; 
    if val>0
        if val<1
            str = zstr;
        else
            str = sprintf(fstr,val); 
        end
    end
    data.lcc.nc.(sprintf('id_%i',glob.id(i))) = str;
end
logmsg(0,'Globcover class percentages calculated')
% ------------------------------------------------------------------------
% Calculate the difference matrix
xd(glob.id) = 1:numel(glob.id); % reverse index
u5 = setdiff(unique(glob.a5),0);
d = nan(numel(glob.id));
for i = 1:numel(u5)
    k = glob.a5(:)==u5(i);
    uk = unique(glob.a9(k));
    for j = 1:numel(uk)
        d(xd(u5(i)),xd(uk(j))) = sum(glob.a9(k)==uk(j));
    end
end
d = d ./ glob.nmask .* 100;
logmsg(0,'Globcover change matrix calculated (%0.0f%%%% no change)', ...
    nansum(diag(d)));
% ------------------------------------------------------------------------
% Loosers and Gainers
s5 = nansum(d,2);
s9 = nansum(d);
diff = s9(:)-s5(:);
nloosers = -sum(diff<0);
ngainers = sum(diff>0);
% ------------------------------------------------------------------------
% Write the change matrix spreadsheet
changeMatrix_xlsx = data.dir.work.output.data.change_matrix_xlsx;
xlswrite(changeMatrix_xlsx,d,'D4:Z26')
sum5 = nansum(d,2); 
sum9 = nansum(d,1); 
diff = sum9(:)-sum5(:);
sum5(sum5==0) = nan;
sum9(sum9==0) = nan;
sumd = nansum(diag(d));
xlswrite(changeMatrix_xlsx,sum5,'AB4:AB26')
xlswrite(changeMatrix_xlsx,sum9','AC4:AC26')
xlswrite(changeMatrix_xlsx,diff,'AD4:AD26')
xlswrite(changeMatrix_xlsx,sum9,'D28:Z28')
xlswrite(changeMatrix_xlsx,sumd,'AA27:AA27')
xlswrite(changeMatrix_xlsx,nan,'B2:B2') % this just repositions the cell selection
logmsg(0,'Change matrix spreadsheet written');
% ------------------------------------------------------------------------
% Save the change matrix as a figure
location = fullfile(data.dir.work.output__,'images','figures');
% BMP
% changeMatrix_bmp = fullfile(location,'change_matrix.bmp');
% xls2image(changeMatrix_xlsx,changeMatrix_bmp,1,'B2:AE31')
% PNG
changeMatrix_png = fullfile(location,'change_matrix.png');
xls2image(changeMatrix_xlsx,changeMatrix_png,1,'B2:AE31')
logmsg(0,'Change matrix figure written');
% ------------------------------------------------------------------------
% Set some output strings
data.lcc.nloosers = sprintf('%i',nloosers);
data.lcc.ngainers = sprintf('%i',ngainers);
data.lcc.pchange = sprintf('%0.0f%%',sumd);
% ------------------------------------------------------------------------
% Plot the basic landcover maps
location = fullfile(data.dir.work.output__,'images','figures');
% Land Cover in 2005
mymap(glob.a5,glob.cmap,glob.refmat,fullfile(location,'land_cover_2005.png'))
logmsg(0,'Land Cover in 2005 map completed');
% Land Cover in 2009
mymap(glob.a9,glob.cmap,glob.refmat,fullfile(location,'land_cover_2009.png'))
logmsg(0,'Land Cover in 2009 map completed');
% Land Cover - Change/No Change
mymap(glob.nc,glob.cmap,glob.refmat,fullfile(location,'land_cover_nochange.png'))
logmsg(0,'Land Cover - Change/No Change map completed');
% ------------------------------------------------------------------------
% Calculate the patch statistics
location = fullfile(data.dir.work.output__,'images','figures');
other = [190 230]; % [14 20 30 190 200 210 220 230];

a5 = glob.a5; k = ismember(a5(:),other); a5(k) = 0;
a9 = glob.a9; k = ismember(a9(:),other); a9(k) = 0;

p5 = patchstats(a5,{'Area'},8); 
p5.Max = log(max(p5.Area(:))*9)*10;
p5.Area = log(p5.Area);
k = isinf(p5.Area(:));
p5.Area(k) = 0;

p9 = patchstats(a9,{'Area'},8); 
p9.Max = log(max(p9.Area(:))*9)*10;
p9.Area = log(p9.Area);
k = isinf(p9.Area(:));
p9.Area(k) = 0;

p5.Indexed = indexedimage(p5.Area,[0 max(p5.Area(:))],glob.k);
file = fullfile(location,'patch_area_2005.png');
mymap(p5.Indexed,jet(256),glob.refmat,file, ...
    'colorbar',{'YTickLabel',round(0:p5.Max/10:p5.Max)})
logmsg(0,'Patch Stats in 2005 map completed');

p9.Indexed = indexedimage(p9.Area,[0 max(p9.Area(:))],glob.k);
file = fullfile(location,'patch_area_2009.png');
mymap(p9.Indexed,jet(256),glob.refmat,file, ...
    'colorbar',{'YTickLabel',round(0:p9.Max/10:p9.Max)})
logmsg(0,'Patch Stats in 2009 map completed');

pd.Area = p9.Area - p5.Area;
pd.Max = max(pd.Area(:));
pd.Min = min(pd.Area(:));
pd.Indexed = indexedimage(pd.Area,[min(pd.Area(:)) max(pd.Area(:))],glob.k);
file = fullfile(location,'patch_area_diff.png');
mymap(pd.Indexed,flipud(jet(256)),glob.refmat,file, ...
    'colorbar',{'YTickLabel',round(pd.Min:(pd.Max-pd.Min)/10:pd.Max)})
logmsg(0,'Patch Stats difference map completed');
% ------------------------------------------------------------------------
% Set the job status flags
if isempty(data.job.status), data.job.status = 'Success'; end
if isempty(data.job.exception), data.job.exception = 'None'; end
% ------------------------------------------------------------------------



% ------------------------------------------------------------------------
% Patch stats
function p = patchstats(a,properties,connections)

classes = setdiff(unique(a),[0 210 230 250]);

s = struct([]);
for i = 1:numel(classes)
    bw = a==classes(i);
    s(i).CLASSID = classes(i);
    s(i).CC = bwconncomp(bw,connections);
    s(i).STATS = regionprops(labelmatrix(s(i).CC),properties);
end

for property = properties
    propstr = char(property);
    p.(propstr) = zeros(size(a));
    for i = 1:numel(s)
        for j = 1:s(i).CC.NumObjects
            p.(propstr)(s(i).CC.PixelIdxList{j}) = s(i).STATS(j).(propstr);
        end
    end
end


% ------------------------------------------------------------------------
% Convert to indexed image
function x = indexedimage(a,limits,mask)

x = a - limits(1);
x = x ./ diff(limits);
x = x .* 254 + 1;
x(mask) = 0;
x = uint8(x);

% ------------------------------------------------------------------------
% Map
function mymap(A,cmap,R,file,varargin)
cmap(1,:) = [0 32 96]./255; % mask
% figure settings
figure('renderer', 'zbuffer')
worldmap(A,R);
geoshow(A,cmap,R);
% edge, tick and font settings
setm(gca,'FEdgeColor','none')
setm(gca,'MLabelParallel','north');
setm(gca,'PLabelMeridian','west');
setm(gca,'LabelRotation','on');
setm(gca,'FontColor','blue');
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
    'Color','blue', ...
    'HorizontalAlignment','right', ...
    'FontSize',9, ...
    'FontAngle','italic');
% scaleruler 
g = get(gca);
yloc = g.YLim(1) + (g.YLim(2) - g.YLim(1)) .* 0.025;
if size(A,2)<=360*2
    scaleruler( ...
        'Color','blue', ...
        'YLoc',yloc, ...
        'ZLoc',1);
end
% colorbar
if ~isempty(varargin)
    k = find(strcmp(varargin,'colorbar'));
    colormap(cmap(2:end,:))
    colorbar('EastOutside', varargin{k+1}{:})
end

% save
saveas(gcf,file)
close



