function [a,bbox,refmat,info] = subgeotiffread(filename,bbox,refmat)

info = geotiffinfo(filename);

if nargin<3 % No REFMAT supplied
    if isfield(info,'RefMatrix') && ~isempty(info.RefMatrix)
        refmat = info.RefMatrix;
    else
        warning('OBOE:NoRefMAtrixMetaData', ...
            'No RefMatrix field found. Trying to use GeoTIFFTags.')
        if isfield(info,'GeoTIFFTags') && ...
                isfield(info.GeoTIFFTags,'ModelPixelScaleTag') && ...
                ~isempty(info.GeoTIFFTags.ModelPixelScaleTag)
            dlon = info.GeoTIFFTags.ModelPixelScaleTag(1);
            dlat = -info.GeoTIFFTags.ModelPixelScaleTag(2); % NB. minus
            lon11 = info.GeoTIFFTags.ModelTiepointTag(4) + (dlon ./ 2);
            lat11 = info.GeoTIFFTags.ModelTiepointTag(5) - (dlat ./ 2);
            refmat = makerefmat(lon11,lat11,dlon,dlat);
        else
            error('OBOE:NoRefMAtrixMetaData', ...
                'No fields available to construct a RefMatrix.')
        end
    end
end

lat = bbox([2 1],2); lon = bbox([1 2],1);
dlon = refmat(2,1); dlat = refmat(1,2);

[row,col,lat,lon] = latlon2abspix(refmat,lat,lon);
a = imread(filename,'PixelRegion',{row,col});

bbox = [lon(1)-(dlon/2) lat(2)+(dlat/2) ; lon(2)+(dlon/2) lat(1)-(dlat/2)];
refmat = makerefmat(lon(1),lat(1),dlon,dlat);


% ------------------------------------------------------------------------
% LATLON2ABSPIX modified for bounding boxes
function [row,col,lat,lon] = latlon2abspix(r,lat,lon)


assert(lat(1)>lat(2)) % North to South
assert(lat(1)<=90)    % 90 to -90
assert(lat(2)>=-90)

assert(lon(1)<lon(2)) % West to East
assert(lon(1)>=-180)  % -180 to 180
assert(lon(2)<=180)    

dlat = abs(r(1,2)); hlat = dlat ./ 2;
lat(1) = (ceil(lat(1)./dlat) .* dlat) - hlat;
lat(2) = (floor(lat(2)./dlat) .* dlat) + hlat;

dlon = abs(r(1,2)); hlon = dlon ./ 2;
lon(1) = (floor(lon(1)./dlon) .* dlon) + hlon;
lon(2) = (ceil(lon(2)./dlon) .* dlon) - hlon;
                     
[row,col] = latlon2pix(r,lat,lon);

row = round(row);
col = round(col);

% Check the reverse
% [mylat,mylon] = pix2latlon(r,row,col);
% ------------------------------------------------------------------------

