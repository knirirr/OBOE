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
function data = resilience(data)

% MASK
mask = double(data.map.mask.a);
mask(mask==0) = nan;

% GLOBCOVER
glob = mygeotiffread( ...
    data.file.globcover, ...
    data.coord.inner.poly.BoundingBox, ...
    data.tile.refmat);

% NPP
NPP = mygeotiffread( ...
    data.file.npp, ...
    data.coord.inner.poly.BoundingBox, ...
    data.tile.refmat);
NPP = double(NPP);
NPP = medfilt2(NPP);

% BIO12
BIO = mygeotiffread( ...
    data.file.bio12, ...
    data.coord.inner.poly.BoundingBox, ...
    data.tile.refmat);
BIO = double(BIO);
BIO = medfilt2(BIO);

% RES
RES = zeros(size(mask));

% CLASSES
classes = [40 50 60 70 90 100 110 120 130 140 150 160 170 180];
for class = classes
    k = find(glob==class);
    if ~isempty(k)
        npp = NPP(k);
        q = quantile(npp,[0.25 0.50 0.75]);
        npp(         npp       < q(2) ) = 0;
        npp( q(2) <= npp & npp < q(3) ) = 1;
        npp( q(3) <= npp              ) = 2;

        bio = BIO(k);
        q = quantile(bio,[0.25 0.50 0.75]);
        bio(         bio       < q(1) ) = 1;
        bio( q(1) <= bio              ) = 0;

        RES(k) = npp .* bio;
    end
end

% SHOW
data.map.resilience.a = RES + 1;
data.map.resilience.bbox = data.map.mask.bbox;
data.map.resilience.refmat = data.map.mask.refmat;
data.map.resilience.info = data.map.mask.info;
data.map.resilience.color.colorbar = 'off';
data.map.resilience.color.type = 'discrete';
data.map.resilience.color.cmap = ...
    [0 0 1 ; 1 1 0 ; 1 0 0];
    % was [0.7 0.7 0.7 ; 0 0 1 ; 1 0 0];
mygeoshow(data.map.resilience, data.map.mask.a);

% SAVE
set(gcf,'Renderer','zbuffer')
saveas(gcf,fullfile(data.file.outputimages,'Fig 10 - Resilience.png'));
close


%%%%%%%%%%%%%%%%%%
%
% You need to take the globcover and first perform the following
% reclassification to make a new map called something like
% globcover_reclass.  This sets agricultural land and unvegetated surfaces
% to 0 and gives 14 different natural vegetation classes
% 
% 11 -> 0
% 14 -> 0
% 20 -> 0
% 30 -> 0
% 40 -> 40
% 50 -> 50
% 60 -> 60
% 70 -> 70
% 90 -> 90
% 100 - > 100
% 110 -> 110
% 120 -> 120
% 130 -> 130
% 140 -> 140
% 150 -> 150
% 160 -> 160
% 170 -> 170
% 180 -> 180
% 190 -> 0
% 200 -> 0
% 210 -> 0
% 220 -> 0
% 230 -> 0
% 255 -> 255 or NAN (nodata)
% 
% Next, you will need to make 14 further reclass operations to make maps
% called things like only_40, only_50:
% 40 -> 1
% else -> 0
% 
% 50 -> 1
% else -> 0
% 
% 60 -> 1
% else ->0
% 
% etc
% 
% You could combine these two steps into just 14 reclass operations instead
% of 15 if you wanted to.
% 
% Now you take the only_40 map which only has values of 1 and 0 and
% multiply by the npp map to make a new masked map called npp_only40 and do
% the same with bio12 to make a new map called bio12_only40.  Repeat this
% process for all 14 classes.
% 
% Next, calculate medians, and 3rd quartiles from all these 28 maps and
% store the values.
% 
% Next, for each class individually, identify which pixels are in the 3rd
% and 4th quartile of npp in the npp masked map.  4th quartile pixels
% should take a value of 2, 3rd quartile pixels should take a value of 1,
% others are 0.  Call this something like npp_only40_quartiles.  similar
% for bio12.  Identify the pixels which are in the 4th quartile.  Set their
% value to 1, all other pixels take a value of 0.  Call this something like
% and bio12_only40_quartiles.
% 
% From these two sets of 14 quartiles maps, make 14 maps of resilience in
% each individual masked class by dividing npp_only40_quartiles by
% bio12_only40quartiles repeated for all classes.  The result and the
% result could only40_resilience.
% 
% Finally add together only40_resilience, only50_resilience,
% only60_resilience etc to make the final map of resilience.
% 
% Regards,
% 
% Peter
% 
