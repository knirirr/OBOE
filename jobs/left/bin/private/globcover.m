% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function data = globcover(data)

% data
% [data.map.globcover.a, ...
%  data.map.globcover.bbox, ...
%  data.map.globcover.refmat, ...
%  data.map.globcover.info] = mygeotiffread( ...
%     data.file.globcover, ...
%     data.coord.inner.poly.BoundingBox, ...
%     data.tile.refmat);

globcover = 'tile';
switch globcover
    case 'tile'
        refmat = data.tile.refmat;
    case '2005'
        data.file.globcover = fullfile('C:\Users\Neil\Documents\DATA\left','globcover2005','GLOBCOVER_200412_200606_V2.2_Global_CLA.tif');
        refmat = [0 -(1/360); (1/360) 0; -180-(1/360) 90+(1/360)/2];

    case '2009'
        data.file.globcover = fullfile('C:\Users\Neil\Documents\DATA\left','globcover2009','GLOBCOVER_L4_200901_200912_V2.3.tif');
        refmat = [0 -(1/360); (1/360) 0; -180-(1/360) 90+(1/360)/2];
end
        
[data.map.globcover.a, ...
 data.map.globcover.bbox, ...
 data.map.globcover.refmat, ...
 data.map.globcover.info] = mygeotiffread( ...
    data.file.globcover, ...
    data.coord.inner.poly.BoundingBox, ...
    refmat);

% colors and captions
c = repmat([0 0 0],255,1);  t = repmat({''},255,1);
c(11,:)  = [170 240 240];   t{11}  = 'Irrigated croplands';
c(14,:)  = [255 255 100];   t{14}  = 'Rainfed croplands';
c(20,:)  = [220 240 100];   t{20}  = 'Mosaic croplands/vegetation';
c(30,:)  = [205 205 102];   t{30}  = 'Mosaic vegetation/croplands';
c(40,:)  = [0   100 0  ];   t{40}  = 'Closed to open broadleaved evergreen or semi-deciduous forest';
c(50,:)  = [0   160 0  ];   t{50}  = 'Closed broadleaved deciduous forest';
c(60,:)  = [170 200 0  ];   t{60}  = 'Open broadleaved deciduous forest';
c(70,:)  = [0   60  0  ];   t{70}  = 'Close needleleaved evergreen forest';
c(90,:)  = [40  100 0  ];   t{90}  = 'Open needleleaved decidious or evergreen forest';
c(100,:) = [120 130 0  ];   t{100} = 'Closed to open mixed broadleaved and needleleaved forest';
c(110,:) = [140 160 0  ];   t{110} = 'Mosaic Forest-Shrubland/Grassland';
c(120,:) = [190 150 0  ];   t{120} = 'Mosaic Grassland/Forest-Shrubland';
c(130,:) = [150 100 0  ];   t{130} = 'Closed to open shrubland';
c(140,:) = [255 180 50 ];   t{140} = 'Closed to open grassland';
c(150,:) = [255 235 175];   t{150} = 'Sparse vegetation';
c(160,:) = [0   120 90 ];   t{160} = 'Closed to open broadleaved forest regularly flooded';
c(170,:) = [0   150 120];   t{170} = 'Closed broadleaved forest permanently flooded';
c(180,:) = [0   220 130];   t{180} = 'Closed to open vegetation regularly flooded';
c(190,:) = [195 20  0  ];   t{190} = 'Artificial areas';
c(200,:) = [255 245 215];   t{200} = 'Bare areas';
c(210,:) = [0   70  200];   t{210} = 'Water bodies';
c(220,:) = [255 255 255];   t{220} = 'Permanent snow and ice';
c(230,:) = [0   0   0  ];   t{230} = 'No data';
data.map.globcover.color.cmap = c ./ 255;
data.map.globcover.color.text = t;
data.map.globcover.color.type = 'discrete';
data.map.globcover.color.colorbar = 'off';

% show
mygeoshow(data.map.globcover);

% save figure
set(gcf,'Renderer','zbuffer')
saveas(gcf,fullfile(data.file.outputimages,'Fig 2 - Globcover.png'));
close

% build the html table legend
k = unique(data.map.globcover.a);
hex_str = rgb2hex(c(k,:));
glob_name = t(k);
globcel = [hex_str glob_name]';
globstr = sprintf('<tr><td bgcolor=%s width="10%%"></td><td width="90%%">%s</td></tr>',globcel{:});
globtable = sprintf('<table style="font-family:calibri; font-size:11px" align="left" width="100%%" border="0">%s</table>',globstr);
data.output.table_of_land_cover_classes = sprintf('%s',globtable);
data.output.globcover_labels = sprintf('%s<br>\n',glob_name{:});



