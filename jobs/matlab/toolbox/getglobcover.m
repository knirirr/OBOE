function out = getglobcover(location,gds)
% GETGLOBCOVER  Returns a geographic subset of the Globcove global images
% 
%   OUT = GETGLOBCOVER(LOCATION,BBOX)
% 
%       LOCATION is a path string to the Globcover file locations.
%          See further details in the infile comments.
%       GDS is a Geographic Data Structure that must contain a field called
%          BoundingBox that is a 2x2 numeric matrix.
%
%       OUT is a struct with the following fields:
%                 a5: [m x n uint8 matrix from Globcover 2005]
%                 a9: [m x n uint8 matrix from Globcover 2009]
%                 nc: [m x n uint8 matrix of no change values]
%             refmat: [3x2 double]
%               bbox: [2x2 double]
%                 id: [24x1 double]
%             colour: [24x3 double]
%              label: {24x1 cell}
%               cmap: [256x3 double]
%                  k: [(n*m) x 1 logical]
%             ntotal: integer
%              nmask: integer
%
% Copyright 2012, neil.caithness@oerc.ox.ac.uk


% dir(location)
%     .                               
%     ..   
%     Globcover2009_V2.3_Global_.zip  
%     Globcover_V2.2_Global.zip       
%     README.txt                      
%     globcove2005                    
%     globcove2009        
%
%
% type(fullfile(location,'README.txt'))
% 
%     Both Globcover .zip files in this directorty were downloaded from
%     http://due.esrin.esa.int/globcover/ on 13 August 2012.
% 
%     Text from the web-site copied below:
% 
%     GlobCover
% 
%     Welcome to the European Space Agency GlobCover Portal
% 
%     The GlobCover Portal provides access to the results of the GlobCover
%     project. 
%     GlobCover is an ESA initiative which began in 2005 in partnership
%     with JRC, EEA, FAO, UNEP, GOFC-GOLD and IGBP. The aim of the project
%     was to develop a service capable of delivering global composites and
%     land cover maps using as input observations from the 300m MERIS
%     sensor on board the ENVISAT satellite mission. ESA makes available
%     the land cover maps, which cover 2 periods: December 2004 - June 2006
%     and January - December 2009. Please see below the links to download
%     the products.
% 
%     GlobCover Land Cover Maps 
%     Use the links below to download the map.
% 
%     GlobCover 2009 (Global Land Cover Map) RELEASED ON 21st December 2010
%     Here you can find:
%     1) The zip file Globcover2009_V2.3_Global_.zip (information can be
%        found in the Globcover2009_ReadMe.pdf which is included),
%     2) Updated Product Description and Validation Report
%        (GLOBCOVER2009_Validation_Report_2.2.pdf)
%     3) A coloured version of the map in GeoTIFF format (CLICK HERE)
% 
%     Global Land Cover Product (2005-06):
%     Here you can find:
%     1) The zip file Globcover_V2.2_Global.zip (information can be found
%        in the Globcover_ReadMe.pdf which is included),
%     2) Product Description and Validation Report
%        (GLOBCOVER_Product_Description_Validation_Report_I2.1.pdf)

% Files
files = dirstruct(location);
try
    tif2005 = files.globcove2005.GLOBCOVER_200412_200606_V2_2_Global_CLA_tif;
    tif2009 = files.globcove2009.GLOBCOVER_L4_200901_200912_V2_3_tif;
    legend5 = files.globcove2005.Globcover_Legend_xls;
    legend9 = files.globcove2009.Globcover2009_Legend_xls;
catch ME
    error('OBOE:Globcover:FilesNotFound', ...
        'One or more of the required Globcover files was not found.')
end
% Checks
%   If DIRSTRUCT returned the above files then these checks aren't
%   necessary but we'll keep them here anyway
assert(exist(tif2005,'file')==2)
assert(exist(tif2009,'file')==2)
assert(exist(legend5,'file')==2)
assert(exist(legend9,'file')==2)

% Bounding box
bbox = gds.BoundingBox;

% Make a new REFMAT
%   Don't use the GeoTiff metadata, it is not reliable
refmat = makerefmat( ...
    'RasterSize',[180*360 360*360], ...
    'Latlim',[-90 90], ...
    'Lonlim',[-180 180], ...
    'ColumnsStartFrom','North');

% Globcover 2005
% [a,mybbox,myrefmat,info,refmat] = subgeotiffread(filename,bbox,refmat)
[out.a5,~,~,~] = subgeotiffread(tif2005,bbox,refmat);
out.size = size(out.a5);

% Globcover 2009
[out.a9,~,out.refmat,~] = subgeotiffread(tif2009,bbox,refmat);

% Check that the image sizes are equal
assert(isequal(size(out.a5),size(out.a9)), ...
    'The two Globcover subreagions should be the same size')

% Add BoundingBox to OUT
%   Doing it here to keep the fields in a nice order
out.bbox = bbox;

% Read the Legend spreadsheet
[num,txt,~] = xlsread(legend5);
out.id = num(:,1);
out.colour = num(:,3:5);
out.label = txt(2:end,2);

% ~Equal
ncval = 250; % new class value
out.nc = out.a5;
out.nc(out.a5 ~= out.a9) = ncval;

% Add a class value ~Equal
out.id(end+1) = ncval;
out.colour(end+1,:) = [255 0 255];
out.label{end+1} = ...
    'Class value change between 2005 and 2009';

% Set the mask to unchanged water bodies
maskval = 0;
water = 210;
out.k = out.a5==water & out.a9==water;
out.a5(out.k) = maskval; 
out.a9(out.k) = maskval;
out.nc(out.k) = maskval;

% Calculate the indexed colour map
out.cmap = zeros(256,3);
out.cmap(out.id+1,:) = out.colour./255;

% Set the mask colour in CMAP
%   corresponds to class value (0), first row in CMAP
% out.cmap(1,:) = [0 32 96]./255;

% Make some summary counts
out.ntotal = numel(out.a5);
out.nmask = sum(out.a5(:)~=maskval);



