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
function [symbolspec,rules] = eco_symbolspec
%ECO_ID_SYMBOLSPEC Colorspec for eco-region polygons from wwf_terr_ecos.shp
%
% The following snippet generates content to the console.
% Run it, then cut and paste the result into RULES below.
% Remember to adjust colors for 'Rock and Ice' and 'Lake'.
% NB. The Default rule must be last in the list.

% e = shaperead(fullfile('C:\Users\Neil\Documents\DATA\left\ecoregions','wwf_terr_ecos.shp'),'UseGeocoord',true);
% [id{1:numel(e)}] = deal(e.ECO_ID);
% [~,kid] = unique(cell2mat(id));
% n = numel(kid);
% cmap = qcmap(n);
% for i = 1:n
%     fprintf(1,'    {''ECO_ID'',%i,''FaceColor'',[%f %f %f]}, ... %% %s\n', ...
%         e(kid(i)).ECO_ID, cmap(i,:), e(kid(i)).ECO_NAME)
% end

rules = { ...
    {'ECO_ID',-9999,'FaceColor',[0.000000 0.000000 0.000000]}, ... % Rock and Ice
    {'ECO_ID',-9998,'FaceColor',[0.000000 0.000000 1.000000]}, ... % Lake
    {'ECO_ID',10101,'FaceColor',[0.458824 0.419608 0.792157]}, ... % Admiralty Islands lowland rain forests
    {'ECO_ID',10102,'FaceColor',[0.356863 0.200000 0.270588]}, ... % Banda Sea Islands moist deciduous forests
    {'ECO_ID',10103,'FaceColor',[0.815686 0.501961 0.470588]}, ... % Biak-Numfoor rain forests
    {'ECO_ID',10104,'FaceColor',[0.796078 0.290196 0.345098]}, ... % Buru rain forests
    {'ECO_ID',10105,'FaceColor',[0.784314 0.301961 0.411765]}, ... % Central Range montane rain forests
    {'ECO_ID',10106,'FaceColor',[0.968627 0.721569 0.858824]}, ... % Halmahera rain forests
    {'ECO_ID',10107,'FaceColor',[0.349020 0.200000 0.325490]}, ... % Huon Peninsula montane rain forests
    {'ECO_ID',10108,'FaceColor',[0.741176 0.541176 0.627451]}, ... % Yapen rain forests
    {'ECO_ID',10109,'FaceColor',[1.000000 0.803922 0.854902]}, ... % Lord Howe Island subtropical forests
    {'ECO_ID',10110,'FaceColor',[0.415686 0.250980 0.262745]}, ... % Louisiade Archipelago rain forests
    {'ECO_ID',10111,'FaceColor',[0.639216 0.505882 0.462745]}, ... % New Britain-New Ireland lowland rain forests
    {'ECO_ID',10112,'FaceColor',[0.231373 0.125490 0.000000]}, ... % New Britain-New Ireland montane rain forests
    {'ECO_ID',10113,'FaceColor',[0.643137 0.701961 0.521569]}, ... % New Caledonia rain forests
    {'ECO_ID',10114,'FaceColor',[0.407843 0.776471 0.607843]}, ... % Norfolk Island subtropical forests
    {'ECO_ID',10115,'FaceColor',[0.019608 0.474510 0.403922]}, ... % Northern New Guinea lowland rain and freshwater swamp forests
    {'ECO_ID',10116,'FaceColor',[0.392157 0.717647 0.823529]}, ... % Northern New Guinea montane rain forests
    {'ECO_ID',10117,'FaceColor',[0.458824 0.717647 0.776471]}, ... % Queensland tropical rain forests
    {'ECO_ID',10118,'FaceColor',[0.552941 0.819608 0.600000]}, ... % Seram rain forests
    {'ECO_ID',10119,'FaceColor',[0.662745 0.843137 0.674510]}, ... % Solomon Islands rain forests
    {'ECO_ID',10120,'FaceColor',[0.145098 0.129412 0.360784]}, ... % Southeastern Papuan rain forests
    {'ECO_ID',10121,'FaceColor',[0.392157 0.360784 0.619608]}, ... % Southern New Guinea freshwater swamp forests
    {'ECO_ID',10122,'FaceColor',[0.172549 0.298039 0.227451]}, ... % Southern New Guinea lowland rain forests
    {'ECO_ID',10123,'FaceColor',[0.529412 0.588235 0.439216]}, ... % Sulawesi lowland rain forests
    {'ECO_ID',10124,'FaceColor',[0.835294 0.607843 0.627451]}, ... % Sulawesi montane rain forests
    {'ECO_ID',10125,'FaceColor',[0.415686 0.129412 0.078431]}, ... % Trobriand Islands rain forests
    {'ECO_ID',10126,'FaceColor',[0.784314 0.658824 0.298039]}, ... % Vanuatu rain forests
    {'ECO_ID',10127,'FaceColor',[1.000000 0.874510 0.560784]}, ... % Vogelkop montane rain forests
    {'ECO_ID',10128,'FaceColor',[0.525490 0.090196 0.192157]}, ... % Vogelkop-Aru lowland rain forests
    {'ECO_ID',10201,'FaceColor',[0.635294 0.184314 0.419608]}, ... % Lesser Sundas deciduous forests
    {'ECO_ID',10202,'FaceColor',[0.850980 0.623529 0.694118]}, ... % New Caledonia dry forests
    {'ECO_ID',10203,'FaceColor',[0.384314 0.305882 0.243137]}, ... % Sumba deciduous forests
    {'ECO_ID',10204,'FaceColor',[0.811765 0.807843 0.631373]}, ... % Timor and Wetar deciduous forests
    {'ECO_ID',10401,'FaceColor',[0.843137 0.788235 0.670588]}, ... % Chatham Island temperate forests
    {'ECO_ID',10402,'FaceColor',[0.462745 0.239216 0.349020]}, ... % Eastern Australian temperate forests
    {'ECO_ID',10403,'FaceColor',[0.388235 0.207843 0.415686]}, ... % Fiordland temperate forests
    {'ECO_ID',10404,'FaceColor',[0.431373 0.537255 0.686275]}, ... % Nelson Coast temperate forests
    {'ECO_ID',10405,'FaceColor',[0.070588 0.290196 0.321569]}, ... % North Island temperate forests
    {'ECO_ID',10406,'FaceColor',[0.164706 0.325490 0.184314]}, ... % Northland temperate kauri forests
    {'ECO_ID',10407,'FaceColor',[0.286275 0.462745 0.235294]}, ... % Rakiura Island temperate forests
    {'ECO_ID',10408,'FaceColor',[0.435294 0.690196 0.458824]}, ... % Richmond temperate forests
    {'ECO_ID',10409,'FaceColor',[0.619608 0.823529 0.556863]}, ... % Southeast Australia temperate forests
    {'ECO_ID',10410,'FaceColor',[0.584314 0.607843 0.250980]}, ... % South Island temperate forests
    {'ECO_ID',10411,'FaceColor',[0.760784 0.592157 0.286275]}, ... % Tasmanian Central Highland forests
    {'ECO_ID',10412,'FaceColor',[0.470588 0.094118 0.000000]}, ... % Tasmanian temperate forests
    {'ECO_ID',10413,'FaceColor',[0.478431 0.152941 0.188235]}, ... % Tasmanian temperate rain forests
    {'ECO_ID',10414,'FaceColor',[0.262745 0.231373 0.450980]}, ... % Westland temperate forests
    {'ECO_ID',10701,'FaceColor',[0.027451 0.180392 0.376471]}, ... % Arnhem Land tropical savanna
    {'ECO_ID',10702,'FaceColor',[0.094118 0.317647 0.278431]}, ... % Brigalow tropical savanna
    {'ECO_ID',10703,'FaceColor',[0.282353 0.505882 0.411765]}, ... % Cape York Peninsula tropical savanna
    {'ECO_ID',10704,'FaceColor',[0.513725 0.678431 0.690196]}, ... % Carpentaria tropical savanna
    {'ECO_ID',10705,'FaceColor',[0.250980 0.423529 0.360784]}, ... % Einasleigh upland savanna
    {'ECO_ID',10706,'FaceColor',[0.513725 0.756863 0.443137]}, ... % Kimberly tropical savanna
    {'ECO_ID',10707,'FaceColor',[0.764706 0.878431 0.639216]}, ... % Mitchell grass downs
    {'ECO_ID',10708,'FaceColor',[0.349020 0.137255 0.305882]}, ... % Trans Fly savanna and grasslands
    {'ECO_ID',10709,'FaceColor',[0.380392 0.180392 0.368627]}, ... % Victoria Plains tropical savanna
    {'ECO_ID',10801,'FaceColor',[0.423529 0.584314 0.392157]}, ... % Cantebury-Otago tussock grasslands
    {'ECO_ID',10802,'FaceColor',[0.631373 0.917647 0.643137]}, ... % Eastern Australia mulga shrublands
    {'ECO_ID',10803,'FaceColor',[0.431373 0.611765 0.537255]}, ... % Southeast Australia temperate savanna
    {'ECO_ID',11001,'FaceColor',[0.262745 0.337255 0.337255]}, ... % Australian Alps montane grasslands
    {'ECO_ID',11002,'FaceColor',[0.615686 0.572549 0.521569]}, ... % Central Range sub-alpine grasslands
    {'ECO_ID',11003,'FaceColor',[0.811765 0.792157 0.741176]}, ... % South Island montane grasslands
    {'ECO_ID',11101,'FaceColor',[0.541176 0.686275 0.682353]}, ... % Antipodes Subantarctic Islands tundra
    {'ECO_ID',11201,'FaceColor',[0.498039 0.647059 0.662745]}, ... % Coolgardie woodlands
    {'ECO_ID',11202,'FaceColor',[0.364706 0.368627 0.380392]}, ... % Esperance mallee
    {'ECO_ID',11203,'FaceColor',[0.301961 0.200000 0.317647]}, ... % Eyre and York mallee
    {'ECO_ID',11204,'FaceColor',[0.572549 0.411765 0.745098]}, ... % Jarrah-Karri forest and shrublands
    {'ECO_ID',11205,'FaceColor',[0.376471 0.200000 0.521569]}, ... % Swan Coastal Plain Scrub and Woodlands
    {'ECO_ID',11206,'FaceColor',[0.862745 0.729412 0.792157]}, ... % Mount Lofty woodlands
    {'ECO_ID',11207,'FaceColor',[0.619608 0.533333 0.454902]}, ... % Murray-Darling woodlands and mallee
    {'ECO_ID',11208,'FaceColor',[0.639216 0.603922 0.509804]}, ... % Naracoorte woodlands
    {'ECO_ID',11209,'FaceColor',[0.545098 0.600000 0.482353]}, ... % Southwest Australia savanna
    {'ECO_ID',11210,'FaceColor',[0.635294 0.811765 0.662745]}, ... % Southwest Australia woodlands
    {'ECO_ID',11301,'FaceColor',[0.168627 0.266667 0.176471]}, ... % Carnarvon xeric shrublands
    {'ECO_ID',11302,'FaceColor',[0.596078 0.411765 0.454902]}, ... % Central Ranges xeric scrub
    {'ECO_ID',11303,'FaceColor',[0.364706 0.031373 0.117647]}, ... % Gibson desert
    {'ECO_ID',11304,'FaceColor',[0.427451 0.070588 0.125490]}, ... % Great Sandy-Tanami desert
    {'ECO_ID',11305,'FaceColor',[0.443137 0.192157 0.223529]}, ... % Great Victoria desert
    {'ECO_ID',11306,'FaceColor',[0.874510 0.866667 0.886275]}, ... % Nullarbor Plains xeric shrublands
    {'ECO_ID',11307,'FaceColor',[0.384314 0.392157 0.474510]}, ... % Pilbara shrublands
    {'ECO_ID',11308,'FaceColor',[0.662745 0.470588 0.654902]}, ... % Simpson desert
    {'ECO_ID',11309,'FaceColor',[0.360784 0.160784 0.356863]}, ... % Tirari-Sturt stony desert
    {'ECO_ID',11310,'FaceColor',[0.600000 0.592157 0.701961]}, ... % Western Australian Mulga shrublands
    {'ECO_ID',11401,'FaceColor',[0.776471 0.862745 0.780392]}, ... % New Guinea mangroves
    {'ECO_ID',21101,'FaceColor',[0.764706 0.847059 0.462745]}, ... % Marielandia Antarctic tundra
    {'ECO_ID',21102,'FaceColor',[0.329412 0.525490 0.078431]}, ... % Maudlandia Antarctic desert
    {'ECO_ID',21103,'FaceColor',[0.250980 0.674510 0.403922]}, ... % Scotia Sea Islands tundra
    {'ECO_ID',21104,'FaceColor',[0.333333 0.729412 0.537255]}, ... % Southern Indian Ocean Islands tundra
    {'ECO_ID',30101,'FaceColor',[0.686275 0.811765 0.592157]}, ... % Albertine Rift montane forests
    {'ECO_ID',30102,'FaceColor',[0.882353 0.776471 0.635294]}, ... % Atlantic Equatorial coastal forests
    {'ECO_ID',30103,'FaceColor',[0.568627 0.266667 0.309804]}, ... % Cameroonian Highlands forests
    {'ECO_ID',30104,'FaceColor',[1.000000 0.717647 0.843137]}, ... % Central Congolian lowland forests
    {'ECO_ID',30105,'FaceColor',[0.678431 0.509804 0.611765]}, ... % Comoros forests
    {'ECO_ID',30106,'FaceColor',[0.450980 0.368627 0.470588]}, ... % Cross-Niger transition forests
    {'ECO_ID',30107,'FaceColor',[0.352941 0.290196 0.407843]}, ... % Cross-Sanaga-Bioko coastal forests
    {'ECO_ID',30108,'FaceColor',[0.396078 0.427451 0.505882]}, ... % East African montane forests
    {'ECO_ID',30109,'FaceColor',[0.545098 0.737255 0.725490]}, ... % Eastern Arc forests
    {'ECO_ID',30110,'FaceColor',[0.015686 0.325490 0.325490]}, ... % Eastern Congolian swamp forests
    {'ECO_ID',30111,'FaceColor',[0.141176 0.505882 0.643137]}, ... % Eastern Guinean forests
    {'ECO_ID',30112,'FaceColor',[0.509804 0.803922 0.843137]}, ... % Ethiopian montane forests
    {'ECO_ID',30113,'FaceColor',[0.580392 0.682353 0.376471]}, ... % Granitic Seychelles forests
    {'ECO_ID',30114,'FaceColor',[0.964706 0.850980 0.560784]}, ... % Guinean montane forests
    {'ECO_ID',30115,'FaceColor',[0.745098 0.407843 0.486275]}, ... % Knysna-Amatole montane forests
    {'ECO_ID',30116,'FaceColor',[0.811765 0.501961 0.752941]}, ... % KwaZulu-Cape coastal forest mosaic
    {'ECO_ID',30117,'FaceColor',[0.286275 0.254902 0.490196]}, ... % Madagascar lowland forests
    {'ECO_ID',30118,'FaceColor',[0.639216 0.721569 0.972549]}, ... % Madagascar subhumid forests
    {'ECO_ID',30119,'FaceColor',[0.066667 0.101961 0.392157]}, ... % Maputaland coastal forest mosaic
    {'ECO_ID',30120,'FaceColor',[0.862745 0.968627 1.000000]}, ... % Mascarene forests
    {'ECO_ID',30121,'FaceColor',[0.403922 0.698039 0.949020]}, ... % Mount Cameroon and Bioko montane forests
    {'ECO_ID',30122,'FaceColor',[0.113725 0.450980 0.521569]}, ... % Niger Delta swamp forests
    {'ECO_ID',30123,'FaceColor',[0.517647 0.756863 0.521569]}, ... % Nigerian lowland forests
    {'ECO_ID',30124,'FaceColor',[0.435294 0.615686 0.364706]}, ... % Northeastern Congolian lowland forests
    {'ECO_ID',30125,'FaceColor',[0.262745 0.423529 0.435294]}, ... % Northern Zanzibar-Inhambane coastal forest mosaic
    {'ECO_ID',30126,'FaceColor',[0.113725 0.200000 0.356863]}, ... % Northwestern Congolian lowland forests
    {'ECO_ID',30127,'FaceColor',[0.545098 0.509804 0.690196]}, ... % Sao Tome, Principe and Annobon moist lowland forests
    {'ECO_ID',30128,'FaceColor',[0.474510 0.313725 0.505882]}, ... % Southern Zanzibar-Inhambane coastal forest mosaic
    {'ECO_ID',30129,'FaceColor',[0.580392 0.301961 0.494118]}, ... % Western Congolian swamp forests
    {'ECO_ID',30130,'FaceColor',[0.478431 0.309804 0.545098]}, ... % Western Guinean lowland forests
    {'ECO_ID',30201,'FaceColor',[0.086275 0.239216 0.568627]}, ... % Cape Verde Islands dry forests
    {'ECO_ID',30202,'FaceColor',[0.258824 0.541176 0.705882]}, ... % Madagascar dry deciduous forests
    {'ECO_ID',30203,'FaceColor',[0.196078 0.403922 0.149020]}, ... % Zambezian Cryptosepalum dry forests
    {'ECO_ID',30701,'FaceColor',[0.737255 0.839216 0.431373]}, ... % Angolan Miombo woodlands
    {'ECO_ID',30702,'FaceColor',[0.337255 0.286275 0.000000]}, ... % Angolan Mopane woodlands
    {'ECO_ID',30703,'FaceColor',[0.698039 0.541176 0.262745]}, ... % Ascension scrub and grasslands
    {'ECO_ID',30704,'FaceColor',[0.917647 0.686275 0.352941]}, ... % Central Zambezian Miombo woodlands
    {'ECO_ID',30705,'FaceColor',[0.494118 0.356863 0.039216]}, ... % East Sudanian savanna
    {'ECO_ID',30706,'FaceColor',[0.635294 0.756863 0.525490]}, ... % Eastern Miombo woodlands
    {'ECO_ID',30707,'FaceColor',[0.470588 0.627451 0.560784]}, ... % Guinean forest-savanna mosaic
    {'ECO_ID',30708,'FaceColor',[0.529412 0.474510 0.678431]}, ... % Itigi-Sumbu thicket
    {'ECO_ID',30709,'FaceColor',[0.415686 0.200000 0.635294]}, ... % Kalahari Acacia-Baikiaea woodlands
    {'ECO_ID',30710,'FaceColor',[0.690196 0.345098 0.992157]}, ... % Mandara Plateau mosaic
    {'ECO_ID',30711,'FaceColor',[0.223529 0.011765 0.615686]}, ... % Northern Acacia-Commiphora bushlands and thickets
    {'ECO_ID',30712,'FaceColor',[0.376471 0.564706 0.874510]}, ... % Northern Congolian forest-savanna mosaic
    {'ECO_ID',30713,'FaceColor',[0.333333 0.592157 0.619608]}, ... % Sahelian Acacia savanna
    {'ECO_ID',30714,'FaceColor',[0.200000 0.211765 0.000000]}, ... % Serengeti volcanic grasslands
    {'ECO_ID',30715,'FaceColor',[0.901961 0.933333 0.596078]}, ... % Somali Acacia-Commiphora bushlands and thickets
    {'ECO_ID',30716,'FaceColor',[0.317647 0.643137 0.403922]}, ... % Southern Acacia-Commiphora bushlands and thickets
    {'ECO_ID',30717,'FaceColor',[0.105882 0.372549 0.301961]}, ... % Southern Africa bushveld
    {'ECO_ID',30718,'FaceColor',[0.337255 0.203922 0.368627]}, ... % Southern Congolian forest-savanna mosaic
    {'ECO_ID',30719,'FaceColor',[1.000000 0.901961 1.000000]}, ... % Southern Miombo woodlands
    {'ECO_ID',30720,'FaceColor',[0.188235 0.172549 0.298039]}, ... % St. Helena scrub and woodlands
    {'ECO_ID',30721,'FaceColor',[0.568627 0.600000 0.623529]}, ... % Victoria Basin forest-savanna mosaic
    {'ECO_ID',30722,'FaceColor',[0.894118 0.823529 0.749020]}, ... % West Sudanian savanna
    {'ECO_ID',30723,'FaceColor',[0.400000 0.360784 0.298039]}, ... % Western Congolian forest-savanna mosaic
    {'ECO_ID',30724,'FaceColor',[0.278431 0.407843 0.470588]}, ... % Western Zambezian grasslands
    {'ECO_ID',30725,'FaceColor',[0.666667 0.733333 1.000000]}, ... % Zambezian and Mopane woodlands
    {'ECO_ID',30726,'FaceColor',[0.317647 0.117647 0.658824]}, ... % Zambezian Baikiaea woodlands
    {'ECO_ID',30801,'FaceColor',[0.305882 0.000000 0.454902]}, ... % Al Hajar montane woodlands
    {'ECO_ID',30802,'FaceColor',[0.643137 0.356863 0.400000]}, ... % Amsterdam and Saint-Paul Islands temperate grasslands
    {'ECO_ID',30803,'FaceColor',[0.788235 0.556863 0.396078]}, ... % Tristan Da Cunha-Gough Islands shrub and grasslands
    {'ECO_ID',30901,'FaceColor',[0.725490 0.568627 0.403922]}, ... % East African halophytics
    {'ECO_ID',30902,'FaceColor',[0.694118 0.549020 0.450980]}, ... % Etosha Pan halophytics
    {'ECO_ID',30903,'FaceColor',[0.400000 0.192157 0.235294]}, ... % Inner Niger Delta flooded savanna
    {'ECO_ID',30904,'FaceColor',[0.525490 0.301961 0.294118]}, ... % Lake Chad flooded savanna
    {'ECO_ID',30905,'FaceColor',[0.937255 0.749020 0.486275]}, ... % Saharan flooded grasslands
    {'ECO_ID',30906,'FaceColor',[0.858824 0.819608 0.360784]}, ... % Zambezian coastal flooded savanna
    {'ECO_ID',30907,'FaceColor',[0.443137 0.666667 0.047059]}, ... % Zambezian flooded grasslands
    {'ECO_ID',30908,'FaceColor',[0.462745 0.650980 0.145098]}, ... % Zambezian halophytics
    {'ECO_ID',31001,'FaceColor',[0.360784 0.219608 0.090196]}, ... % Angolan montane forest-grassland mosaic
    {'ECO_ID',31002,'FaceColor',[0.388235 0.203922 0.239216]}, ... % Angolan scarp savanna and woodlands
    {'ECO_ID',31003,'FaceColor',[0.564706 0.635294 0.623529]}, ... % Drakensberg alti-montane grasslands and woodlands
    {'ECO_ID',31004,'FaceColor',[0.447059 0.611765 0.592157]}, ... % Drakensberg montane grasslands, woodlands and forests
    {'ECO_ID',31005,'FaceColor',[0.800000 0.921569 0.933333]}, ... % East African montane moorlands
    {'ECO_ID',31006,'FaceColor',[0.247059 0.192157 0.121569]}, ... % Eastern Zimbabwe montane forest-grassland mosaic
    {'ECO_ID',31007,'FaceColor',[0.549020 0.192157 0.000000]}, ... % Ethiopian montane grasslands and woodlands
    {'ECO_ID',31008,'FaceColor',[0.909804 0.654902 0.400000]}, ... % Ethiopian montane moorlands
    {'ECO_ID',31009,'FaceColor',[0.203922 0.470588 0.439216]}, ... % Highveld grasslands
    {'ECO_ID',31010,'FaceColor',[0.423529 0.776471 0.803922]}, ... % Jos Plateau forest-grassland mosaic
    {'ECO_ID',31011,'FaceColor',[0.298039 0.286275 0.192157]}, ... % Madagascar ericoid thickets
    {'ECO_ID',31012,'FaceColor',[0.541176 0.494118 0.411765]}, ... % Maputaland-Pondoland bushland and thickets
    {'ECO_ID',31013,'FaceColor',[0.337255 0.584314 0.639216]}, ... % Rwenzori-Virunga montane moorlands
    {'ECO_ID',31014,'FaceColor',[0.462745 0.643137 0.768627]}, ... % South Malawi montane forest-grassland mosaic
    {'ECO_ID',31015,'FaceColor',[0.521569 0.286275 0.400000]}, ... % Southern Rift montane forest-grassland mosaic
    {'ECO_ID',31201,'FaceColor',[0.639216 0.356863 0.384314]}, ... % Albany thickets
    {'ECO_ID',31202,'FaceColor',[0.423529 0.458824 0.309804]}, ... % Lowland fynbos and renosterveld
    {'ECO_ID',31203,'FaceColor',[0.749020 0.921569 0.725490]}, ... % Montane fynbos and renosterveld
    {'ECO_ID',31301,'FaceColor',[0.752941 0.882353 0.780392]}, ... % Aldabra Island xeric scrub
    {'ECO_ID',31302,'FaceColor',[0.133333 0.200000 0.058824]}, ... % Arabian Peninsula coastal fog desert
    {'ECO_ID',31303,'FaceColor',[0.623529 0.584314 0.278431]}, ... % East Saharan montane xeric woodlands
    {'ECO_ID',31304,'FaceColor',[0.560784 0.462745 0.305882]}, ... % Eritrean coastal desert
    {'ECO_ID',31305,'FaceColor',[0.827451 0.725490 1.000000]}, ... % Ethiopian xeric grasslands and shrublands
    {'ECO_ID',31306,'FaceColor',[0.301961 0.137255 0.603922]}, ... % Gulf of Oman desert and semi-desert
    {'ECO_ID',31307,'FaceColor',[0.400000 0.105882 0.435294]}, ... % Hobyo grasslands and shrublands
    {'ECO_ID',31308,'FaceColor',[0.462745 0.176471 0.317647]}, ... % Ile Europa and Bassas da India xeric scrub
    {'ECO_ID',31309,'FaceColor',[0.501961 0.372549 0.262745]}, ... % Kalahari xeric savanna
    {'ECO_ID',31310,'FaceColor',[0.223529 0.192157 0.113725]}, ... % Kaokoveld desert
    {'ECO_ID',31311,'FaceColor',[0.317647 0.325490 0.541176]}, ... % Madagascar spiny thickets
    {'ECO_ID',31312,'FaceColor',[0.474510 0.337255 0.674510]}, ... % Madagascar succulent woodlands
    {'ECO_ID',31313,'FaceColor',[0.647059 0.176471 0.482353]}, ... % Masai xeric grasslands and shrublands
    {'ECO_ID',31314,'FaceColor',[0.945098 0.505882 0.670588]}, ... % Nama Karoo
    {'ECO_ID',31315,'FaceColor',[0.541176 0.490196 0.423529]}, ... % Namib desert
    {'ECO_ID',31316,'FaceColor',[0.643137 0.843137 0.647059]}, ... % Namibian savanna woodlands
    {'ECO_ID',31318,'FaceColor',[0.498039 0.819608 0.596078]}, ... % Socotra Island xeric shrublands
    {'ECO_ID',31319,'FaceColor',[0.713725 0.972549 0.898039]}, ... % Somali montane xeric woodlands
    {'ECO_ID',31320,'FaceColor',[0.713725 0.725490 0.968627]}, ... % Southwestern Arabian foothills savanna
    {'ECO_ID',31321,'FaceColor',[0.109804 0.062745 0.317647]}, ... % Southwestern Arabian montane woodlands
    {'ECO_ID',31322,'FaceColor',[0.364706 0.470588 0.423529]}, ... % Succulent Karoo
    {'ECO_ID',31401,'FaceColor',[0.749020 0.925490 0.698039]}, ... % Central African mangroves
    {'ECO_ID',31402,'FaceColor',[0.592157 0.764706 0.466667]}, ... % East African mangroves
    {'ECO_ID',31403,'FaceColor',[0.400000 0.600000 0.294118]}, ... % Guinean mangroves
    {'ECO_ID',31404,'FaceColor',[0.215686 0.490196 0.211765]}, ... % Madagascar mangroves
    {'ECO_ID',31405,'FaceColor',[0.698039 0.811765 0.635294]}, ... % Southern Africa mangroves
    {'ECO_ID',40101,'FaceColor',[0.674510 0.380392 0.380392]}, ... % Andaman Islands rain forests
    {'ECO_ID',40102,'FaceColor',[0.933333 0.564706 0.686275]}, ... % Borneo lowland rain forests
    {'ECO_ID',40103,'FaceColor',[0.184314 0.070588 0.254902]}, ... % Borneo montane rain forests
    {'ECO_ID',40104,'FaceColor',[0.909804 0.886275 1.000000]}, ... % Borneo peat swamp forests
    {'ECO_ID',40105,'FaceColor',[0.301961 0.203922 0.290196]}, ... % Brahmaputra Valley semi-evergreen forests
    {'ECO_ID',40106,'FaceColor',[0.482353 0.329412 0.407843]}, ... % Cardamom Mountains rain forests
    {'ECO_ID',40107,'FaceColor',[0.576471 0.388235 0.549020]}, ... % Chao Phraya freshwater swamp forests
    {'ECO_ID',40108,'FaceColor',[0.501961 0.290196 0.600000]}, ... % Chao Phraya lowland moist deciduous forests
    {'ECO_ID',40109,'FaceColor',[0.305882 0.070588 0.615686]}, ... % Chin Hills-Arakan Yoma montane forests
    {'ECO_ID',40110,'FaceColor',[0.403922 0.219608 0.709804]}, ... % Christmas and Cocos Islands tropical forests
    {'ECO_ID',40111,'FaceColor',[0.313725 0.254902 0.396078]}, ... % Eastern highlands moist deciduous forests
    {'ECO_ID',40112,'FaceColor',[0.580392 0.521569 0.521569]}, ... % Eastern Java-Bali montane rain forests
    {'ECO_ID',40113,'FaceColor',[0.647059 0.478431 0.521569]}, ... % Eastern Java-Bali rain forests
    {'ECO_ID',40114,'FaceColor',[0.611765 0.400000 0.474510]}, ... % Greater Negros-Panay rain forests
    {'ECO_ID',40115,'FaceColor',[0.611765 0.431373 0.537255]}, ... % Himalayan subtropical broadleaf forests
    {'ECO_ID',40116,'FaceColor',[0.364706 0.254902 0.309804]}, ... % Irrawaddy freshwater swamp forests
    {'ECO_ID',40117,'FaceColor',[0.650980 0.666667 0.596078]}, ... % Irrawaddy moist deciduous forests
    {'ECO_ID',40118,'FaceColor',[0.168627 0.200000 0.031373]}, ... % Jian Nan subtropical evergreen forests
    {'ECO_ID',40119,'FaceColor',[0.270588 0.227451 0.000000]}, ... % Kayah-Karen montane rain forests
    {'ECO_ID',40120,'FaceColor',[0.458824 0.462745 0.235294]}, ... % Lower Gangetic Plains moist deciduous forests
    {'ECO_ID',40121,'FaceColor',[0.764706 0.933333 0.831373]}, ... % Luang Prabang montane rain forests
    {'ECO_ID',40122,'FaceColor',[0.466667 0.635294 0.631373]}, ... % Luzon montane rain forests
    {'ECO_ID',40123,'FaceColor',[0.286275 0.282353 0.341176]}, ... % Luzon rain forests
    {'ECO_ID',40124,'FaceColor',[0.929412 0.776471 0.721569]}, ... % Malabar Coast moist forests
    {'ECO_ID',40125,'FaceColor',[1.000000 0.796078 0.435294]}, ... % Maldives-Lakshadweep-Chagos Archipelago tropical moist forests
    {'ECO_ID',40126,'FaceColor',[0.647059 0.498039 0.003922]}, ... % Meghalaya subtropical forests
    {'ECO_ID',40127,'FaceColor',[0.215686 0.411765 0.000000]}, ... % Mentawai Islands rain forests
    {'ECO_ID',40128,'FaceColor',[0.549020 0.827451 0.454902]}, ... % Mindanao montane rain forests
    {'ECO_ID',40129,'FaceColor',[0.321569 0.435294 0.156863]}, ... % Mindanao-Eastern Visayas rain forests
    {'ECO_ID',40130,'FaceColor',[0.541176 0.627451 0.470588]}, ... % Mindoro rain forests
    {'ECO_ID',40131,'FaceColor',[0.447059 0.643137 0.611765]}, ... % Mizoram-Manipur-Kachin rain forests
    {'ECO_ID',40132,'FaceColor',[0.325490 0.458824 0.439216]}, ... % Myanmar coastal rain forests
    {'ECO_ID',40133,'FaceColor',[0.898039 0.788235 0.670588]}, ... % Nicobar Islands rain forests
    {'ECO_ID',40134,'FaceColor',[0.901961 0.658824 0.509804]}, ... % North Western Ghats moist deciduous forests
    {'ECO_ID',40135,'FaceColor',[0.415686 0.141176 0.007843]}, ... % North Western Ghats montane rain forests
    {'ECO_ID',40136,'FaceColor',[0.666667 0.384314 0.270588]}, ... % Northern Annamites rain forests
    {'ECO_ID',40137,'FaceColor',[0.690196 0.345098 0.325490]}, ... % Northern Indochina subtropical forests
    {'ECO_ID',40138,'FaceColor',[1.000000 0.862745 0.945098]}, ... % Northern Khorat Plateau moist deciduous forests
    {'ECO_ID',40139,'FaceColor',[0.741176 0.650980 1.000000]}, ... % Northern Thailand-Laos moist deciduous forests
    {'ECO_ID',40140,'FaceColor',[0.098039 0.176471 0.443137]}, ... % Northern Triangle subtropical forests
    {'ECO_ID',40141,'FaceColor',[0.717647 1.000000 0.721569]}, ... % Northern Vietnam lowland rain forests
    {'ECO_ID',40142,'FaceColor',[0.568627 0.780392 0.517647]}, ... % Orissa semi-evergreen forests
    {'ECO_ID',40143,'FaceColor',[0.294118 0.145098 0.454902]}, ... % Palawan rain forests
    {'ECO_ID',40144,'FaceColor',[0.513725 0.345098 0.721569]}, ... % Peninsular Malaysian montane rain forests
    {'ECO_ID',40145,'FaceColor',[0.737255 0.886275 0.819608]}, ... % Peninsular Malaysian peat swamp forests
    {'ECO_ID',40146,'FaceColor',[0.647059 0.749020 0.560784]}, ... % Peninsular Malaysian rain forests
    {'ECO_ID',40147,'FaceColor',[0.517647 0.211765 0.231373]}, ... % Red River freshwater swamp forests
    {'ECO_ID',40148,'FaceColor',[0.843137 0.517647 0.521569]}, ... % South China Sea Islands
    {'ECO_ID',40149,'FaceColor',[0.435294 0.490196 0.231373]}, ... % South China-Vietnam subtropical evergreen forests
    {'ECO_ID',40150,'FaceColor',[0.933333 0.996078 0.745098]}, ... % South Western Ghats moist deciduous forests
    {'ECO_ID',40151,'FaceColor',[0.552941 0.243137 0.250980]}, ... % South Western Ghats montane rain forests
    {'ECO_ID',40152,'FaceColor',[0.329412 0.286275 0.243137]}, ... % Southern Annamites montane rain forests
    {'ECO_ID',40153,'FaceColor',[0.541176 0.513725 0.611765]}, ... % Southwest Borneo freshwater swamp forests
    {'ECO_ID',40154,'FaceColor',[0.396078 0.400000 0.780392]}, ... % Sri Lanka lowland rain forests
    {'ECO_ID',40155,'FaceColor',[0.458824 0.419608 0.792157]}, ... % Sri Lanka montane rain forests
    {'ECO_ID',40156,'FaceColor',[0.356863 0.200000 0.270588]}, ... % Sulu Archipelago rain forests
    {'ECO_ID',40157,'FaceColor',[0.815686 0.501961 0.470588]}, ... % Sumatran freshwater swamp forests
    {'ECO_ID',40158,'FaceColor',[0.796078 0.290196 0.345098]}, ... % Sumatran lowland rain forests
    {'ECO_ID',40159,'FaceColor',[0.784314 0.301961 0.411765]}, ... % Sumatran montane rain forests
    {'ECO_ID',40160,'FaceColor',[0.968627 0.721569 0.858824]}, ... % Sumatran peat swamp forests
    {'ECO_ID',40161,'FaceColor',[0.349020 0.200000 0.325490]}, ... % Sundaland heath forests
    {'ECO_ID',40162,'FaceColor',[0.741176 0.541176 0.627451]}, ... % Sundarbans freshwater swamp forests
    {'ECO_ID',40163,'FaceColor',[1.000000 0.803922 0.854902]}, ... % Tenasserim-South Thailand semi-evergreen rain forests
    {'ECO_ID',40164,'FaceColor',[0.415686 0.250980 0.262745]}, ... % Tonle Sap freshwater swamp forests
    {'ECO_ID',40165,'FaceColor',[0.639216 0.505882 0.462745]}, ... % Tonle Sap-Mekong peat swamp forests
    {'ECO_ID',40166,'FaceColor',[0.231373 0.125490 0.000000]}, ... % Upper Gangetic Plains moist deciduous forests
    {'ECO_ID',40167,'FaceColor',[0.643137 0.701961 0.521569]}, ... % Western Java montane rain forests
    {'ECO_ID',40168,'FaceColor',[0.407843 0.776471 0.607843]}, ... % Western Java rain forests
    {'ECO_ID',40169,'FaceColor',[0.019608 0.474510 0.403922]}, ... % Hainan Island monsoon rain forests
    {'ECO_ID',40170,'FaceColor',[0.392157 0.717647 0.823529]}, ... % Nansei Islands subtropical evergreen forests
    {'ECO_ID',40171,'FaceColor',[0.458824 0.717647 0.776471]}, ... % South Taiwan monsoon rain forests
    {'ECO_ID',40172,'FaceColor',[0.552941 0.819608 0.600000]}, ... % Taiwan subtropical evergreen forests
    {'ECO_ID',40201,'FaceColor',[0.662745 0.843137 0.674510]}, ... % Central Deccan Plateau dry deciduous forests
    {'ECO_ID',40202,'FaceColor',[0.145098 0.129412 0.360784]}, ... % Central Indochina dry forests
    {'ECO_ID',40203,'FaceColor',[0.392157 0.360784 0.619608]}, ... % Chhota-Nagpur dry deciduous forests
    {'ECO_ID',40204,'FaceColor',[0.172549 0.298039 0.227451]}, ... % East Deccan dry-evergreen forests
    {'ECO_ID',40205,'FaceColor',[0.529412 0.588235 0.439216]}, ... % Irrawaddy dry forests
    {'ECO_ID',40206,'FaceColor',[0.835294 0.607843 0.627451]}, ... % Khathiar-Gir dry deciduous forests
    {'ECO_ID',40207,'FaceColor',[0.415686 0.129412 0.078431]}, ... % Narmada Valley dry deciduous forests
    {'ECO_ID',40208,'FaceColor',[0.784314 0.658824 0.298039]}, ... % Northern dry deciduous forests
    {'ECO_ID',40209,'FaceColor',[1.000000 0.874510 0.560784]}, ... % South Deccan Plateau dry deciduous forests
    {'ECO_ID',40210,'FaceColor',[0.525490 0.090196 0.192157]}, ... % Southeastern Indochina dry evergreen forests
    {'ECO_ID',40211,'FaceColor',[0.635294 0.184314 0.419608]}, ... % Southern Vietnam lowland dry forests
    {'ECO_ID',40212,'FaceColor',[0.850980 0.623529 0.694118]}, ... % Sri Lanka dry-zone dry evergreen forests
    {'ECO_ID',40301,'FaceColor',[0.384314 0.305882 0.243137]}, ... % Himalayan subtropical pine forests
    {'ECO_ID',40302,'FaceColor',[0.811765 0.807843 0.631373]}, ... % Luzon tropical pine forests
    {'ECO_ID',40303,'FaceColor',[0.843137 0.788235 0.670588]}, ... % Northeast India-Myanmar pine forests
    {'ECO_ID',40304,'FaceColor',[0.462745 0.239216 0.349020]}, ... % Sumatran tropical pine forests
    {'ECO_ID',40401,'FaceColor',[0.388235 0.207843 0.415686]}, ... % Eastern Himalayan broadleaf forests
    {'ECO_ID',40402,'FaceColor',[0.431373 0.537255 0.686275]}, ... % Northern Triangle temperate forests
    {'ECO_ID',40403,'FaceColor',[0.070588 0.290196 0.321569]}, ... % Western Himalayan broadleaf forests
    {'ECO_ID',40501,'FaceColor',[0.164706 0.325490 0.184314]}, ... % Eastern Himalayan subalpine conifer forests
    {'ECO_ID',40502,'FaceColor',[0.286275 0.462745 0.235294]}, ... % Western Himalayan subalpine conifer forests
    {'ECO_ID',40701,'FaceColor',[0.435294 0.690196 0.458824]}, ... % Terai-Duar savanna and grasslands
    {'ECO_ID',40901,'FaceColor',[0.619608 0.823529 0.556863]}, ... % Rann of Kutch seasonal salt marsh
    {'ECO_ID',41001,'FaceColor',[0.584314 0.607843 0.250980]}, ... % Kinabalu montane alpine meadows
    {'ECO_ID',41301,'FaceColor',[0.760784 0.592157 0.286275]}, ... % Deccan thorn scrub forests
    {'ECO_ID',41302,'FaceColor',[0.470588 0.094118 0.000000]}, ... % Indus Valley desert
    {'ECO_ID',41303,'FaceColor',[0.478431 0.152941 0.188235]}, ... % Northwestern thorn scrub forests
    {'ECO_ID',41304,'FaceColor',[0.262745 0.231373 0.450980]}, ... % Thar desert
    {'ECO_ID',41401,'FaceColor',[0.027451 0.180392 0.376471]}, ... % Goadavari-Krishna mangroves
    {'ECO_ID',41402,'FaceColor',[0.094118 0.317647 0.278431]}, ... % Indochina mangroves
    {'ECO_ID',41403,'FaceColor',[0.282353 0.505882 0.411765]}, ... % Indus River Delta-Arabian Sea mangroves
    {'ECO_ID',41404,'FaceColor',[0.513725 0.678431 0.690196]}, ... % Myanmar Coast mangroves
    {'ECO_ID',41405,'FaceColor',[0.250980 0.423529 0.360784]}, ... % Sunda Shelf mangroves
    {'ECO_ID',41406,'FaceColor',[0.513725 0.756863 0.443137]}, ... % Sundarbans mangroves
    {'ECO_ID',50201,'FaceColor',[0.764706 0.878431 0.639216]}, ... % Sonoran-Sinaloan transition subtropical dry forest
    {'ECO_ID',50301,'FaceColor',[0.349020 0.137255 0.305882]}, ... % Bermuda subtropical conifer forests
    {'ECO_ID',50302,'FaceColor',[0.380392 0.180392 0.368627]}, ... % Sierra Madre Occidental pine-oak forests
    {'ECO_ID',50303,'FaceColor',[0.423529 0.584314 0.392157]}, ... % Sierra Madre Oriental pine-oak forests
    {'ECO_ID',50401,'FaceColor',[0.631373 0.917647 0.643137]}, ... % Allegheny Highlands forests
    {'ECO_ID',50402,'FaceColor',[0.431373 0.611765 0.537255]}, ... % Appalachian mixed mesophytic forests
    {'ECO_ID',50403,'FaceColor',[0.262745 0.337255 0.337255]}, ... % Appalachian-Blue Ridge forests
    {'ECO_ID',50404,'FaceColor',[0.615686 0.572549 0.521569]}, ... % Central U.S. hardwood forests
    {'ECO_ID',50405,'FaceColor',[0.811765 0.792157 0.741176]}, ... % East Central Texas forests
    {'ECO_ID',50406,'FaceColor',[0.541176 0.686275 0.682353]}, ... % Eastern forest-boreal transition
    {'ECO_ID',50407,'FaceColor',[0.498039 0.647059 0.662745]}, ... % Eastern Great Lakes lowland forests
    {'ECO_ID',50408,'FaceColor',[0.364706 0.368627 0.380392]}, ... % Gulf of St. Lawrence lowland forests
    {'ECO_ID',50409,'FaceColor',[0.301961 0.200000 0.317647]}, ... % Mississippi lowland forests
    {'ECO_ID',50410,'FaceColor',[0.572549 0.411765 0.745098]}, ... % New England-Acadian forests
    {'ECO_ID',50411,'FaceColor',[0.376471 0.200000 0.521569]}, ... % Northeastern coastal forests
    {'ECO_ID',50412,'FaceColor',[0.862745 0.729412 0.792157]}, ... % Ozark Mountain forests
    {'ECO_ID',50413,'FaceColor',[0.619608 0.533333 0.454902]}, ... % Southeastern mixed forests
    {'ECO_ID',50414,'FaceColor',[0.639216 0.603922 0.509804]}, ... % Southern Great Lakes forests
    {'ECO_ID',50415,'FaceColor',[0.545098 0.600000 0.482353]}, ... % Upper Midwest forest-savanna transition
    {'ECO_ID',50416,'FaceColor',[0.635294 0.811765 0.662745]}, ... % Western Great Lakes forests
    {'ECO_ID',50417,'FaceColor',[0.168627 0.266667 0.176471]}, ... % Willamette Valley forests
    {'ECO_ID',50501,'FaceColor',[0.596078 0.411765 0.454902]}, ... % Alberta Mountain forests
    {'ECO_ID',50502,'FaceColor',[0.364706 0.031373 0.117647]}, ... % Alberta-British Columbia foothills forests
    {'ECO_ID',50503,'FaceColor',[0.427451 0.070588 0.125490]}, ... % Arizona Mountains forests
    {'ECO_ID',50504,'FaceColor',[0.443137 0.192157 0.223529]}, ... % Atlantic coastal pine barrens
    {'ECO_ID',50505,'FaceColor',[0.874510 0.866667 0.886275]}, ... % Blue Mountains forests
    {'ECO_ID',50506,'FaceColor',[0.384314 0.392157 0.474510]}, ... % British Columbia mainland coastal forests
    {'ECO_ID',50507,'FaceColor',[0.662745 0.470588 0.654902]}, ... % Cascade Mountains leeward forests
    {'ECO_ID',50508,'FaceColor',[0.360784 0.160784 0.356863]}, ... % Central and Southern Cascades forests
    {'ECO_ID',50509,'FaceColor',[0.600000 0.592157 0.701961]}, ... % Central British Columbia Mountain forests
    {'ECO_ID',50510,'FaceColor',[0.776471 0.862745 0.780392]}, ... % Central Pacific coastal forests
    {'ECO_ID',50511,'FaceColor',[0.764706 0.847059 0.462745]}, ... % Colorado Rockies forests
    {'ECO_ID',50512,'FaceColor',[0.329412 0.525490 0.078431]}, ... % Eastern Cascades forests
    {'ECO_ID',50513,'FaceColor',[0.250980 0.674510 0.403922]}, ... % Florida sand pine scrub
    {'ECO_ID',50514,'FaceColor',[0.333333 0.729412 0.537255]}, ... % Fraser Plateau and Basin complex
    {'ECO_ID',50515,'FaceColor',[0.686275 0.811765 0.592157]}, ... % Great Basin montane forests
    {'ECO_ID',50516,'FaceColor',[0.882353 0.776471 0.635294]}, ... % Klamath-Siskiyou forests
    {'ECO_ID',50517,'FaceColor',[0.568627 0.266667 0.309804]}, ... % Middle Atlantic coastal forests
    {'ECO_ID',50518,'FaceColor',[1.000000 0.717647 0.843137]}, ... % North Central Rockies forests
    {'ECO_ID',50519,'FaceColor',[0.678431 0.509804 0.611765]}, ... % Northern California coastal forests
    {'ECO_ID',50520,'FaceColor',[0.450980 0.368627 0.470588]}, ... % Northern Pacific coastal forests
    {'ECO_ID',50521,'FaceColor',[0.352941 0.290196 0.407843]}, ... % Northern transitional alpine forests
    {'ECO_ID',50522,'FaceColor',[0.396078 0.427451 0.505882]}, ... % Okanagan dry forests
    {'ECO_ID',50523,'FaceColor',[0.545098 0.737255 0.725490]}, ... % Piney Woods forests
    {'ECO_ID',50524,'FaceColor',[0.015686 0.325490 0.325490]}, ... % Puget lowland forests
    {'ECO_ID',50525,'FaceColor',[0.141176 0.505882 0.643137]}, ... % Queen Charlotte Islands
    {'ECO_ID',50526,'FaceColor',[0.509804 0.803922 0.843137]}, ... % Sierra Juarez and San Pedro Martir pine-oak forests
    {'ECO_ID',50527,'FaceColor',[0.580392 0.682353 0.376471]}, ... % Sierra Nevada forests
    {'ECO_ID',50528,'FaceColor',[0.964706 0.850980 0.560784]}, ... % South Central Rockies forests
    {'ECO_ID',50529,'FaceColor',[0.745098 0.407843 0.486275]}, ... % Southeastern conifer forests
    {'ECO_ID',50530,'FaceColor',[0.811765 0.501961 0.752941]}, ... % Wasatch and Uinta montane forests
    {'ECO_ID',50601,'FaceColor',[0.286275 0.254902 0.490196]}, ... % Alaska Peninsula montane taiga
    {'ECO_ID',50602,'FaceColor',[0.639216 0.721569 0.972549]}, ... % Central Canadian Shield forests
    {'ECO_ID',50603,'FaceColor',[0.066667 0.101961 0.392157]}, ... % Cook Inlet taiga
    {'ECO_ID',50604,'FaceColor',[0.862745 0.968627 1.000000]}, ... % Copper Plateau taiga
    {'ECO_ID',50605,'FaceColor',[0.403922 0.698039 0.949020]}, ... % Eastern Canadian forests
    {'ECO_ID',50606,'FaceColor',[0.113725 0.450980 0.521569]}, ... % Eastern Canadian Shield taiga
    {'ECO_ID',50607,'FaceColor',[0.517647 0.756863 0.521569]}, ... % Interior Alaska-Yukon lowland taiga
    {'ECO_ID',50608,'FaceColor',[0.435294 0.615686 0.364706]}, ... % Mid-Continental Canadian forests
    {'ECO_ID',50609,'FaceColor',[0.262745 0.423529 0.435294]}, ... % Midwestern Canadian Shield forests
    {'ECO_ID',50610,'FaceColor',[0.113725 0.200000 0.356863]}, ... % Muskwa-Slave Lake forests
    {'ECO_ID',50611,'FaceColor',[0.545098 0.509804 0.690196]}, ... % Newfoundland Highland forests
    {'ECO_ID',50612,'FaceColor',[0.474510 0.313725 0.505882]}, ... % Northern Canadian Shield taiga
    {'ECO_ID',50613,'FaceColor',[0.580392 0.301961 0.494118]}, ... % Northern Cordillera forests
    {'ECO_ID',50614,'FaceColor',[0.478431 0.309804 0.545098]}, ... % Northwest Territories taiga
    {'ECO_ID',50615,'FaceColor',[0.086275 0.239216 0.568627]}, ... % South Avalon-Burin oceanic barrens
    {'ECO_ID',50616,'FaceColor',[0.258824 0.541176 0.705882]}, ... % Southern Hudson Bay taiga
    {'ECO_ID',50617,'FaceColor',[0.196078 0.403922 0.149020]}, ... % Yukon Interior dry forests
    {'ECO_ID',50701,'FaceColor',[0.737255 0.839216 0.431373]}, ... % Western Gulf coastal grasslands
    {'ECO_ID',50801,'FaceColor',[0.337255 0.286275 0.000000]}, ... % California Central Valley grasslands
    {'ECO_ID',50802,'FaceColor',[0.698039 0.541176 0.262745]}, ... % Canadian Aspen forests and parklands
    {'ECO_ID',50803,'FaceColor',[0.917647 0.686275 0.352941]}, ... % Central and Southern mixed grasslands
    {'ECO_ID',50804,'FaceColor',[0.494118 0.356863 0.039216]}, ... % Central forest-grasslands transition
    {'ECO_ID',50805,'FaceColor',[0.635294 0.756863 0.525490]}, ... % Central tall grasslands
    {'ECO_ID',50806,'FaceColor',[0.470588 0.627451 0.560784]}, ... % Edwards Plateau savanna
    {'ECO_ID',50807,'FaceColor',[0.529412 0.474510 0.678431]}, ... % Flint Hills tall grasslands
    {'ECO_ID',50808,'FaceColor',[0.415686 0.200000 0.635294]}, ... % Montana Valley and Foothill grasslands
    {'ECO_ID',50809,'FaceColor',[0.690196 0.345098 0.992157]}, ... % Nebraska Sand Hills mixed grasslands
    {'ECO_ID',50810,'FaceColor',[0.223529 0.011765 0.615686]}, ... % Northern mixed grasslands
    {'ECO_ID',50811,'FaceColor',[0.376471 0.564706 0.874510]}, ... % Northern short grasslands
    {'ECO_ID',50812,'FaceColor',[0.333333 0.592157 0.619608]}, ... % Northern tall grasslands
    {'ECO_ID',50813,'FaceColor',[0.200000 0.211765 0.000000]}, ... % Palouse grasslands
    {'ECO_ID',50814,'FaceColor',[0.901961 0.933333 0.596078]}, ... % Texas blackland prairies
    {'ECO_ID',50815,'FaceColor',[0.317647 0.643137 0.403922]}, ... % Western short grasslands
    {'ECO_ID',51101,'FaceColor',[0.105882 0.372549 0.301961]}, ... % Alaska-St. Elias Range tundra
    {'ECO_ID',51102,'FaceColor',[0.337255 0.203922 0.368627]}, ... % Aleutian Islands tundra
    {'ECO_ID',51103,'FaceColor',[1.000000 0.901961 1.000000]}, ... % Arctic coastal tundra
    {'ECO_ID',51104,'FaceColor',[0.188235 0.172549 0.298039]}, ... % Arctic foothills tundra
    {'ECO_ID',51105,'FaceColor',[0.568627 0.600000 0.623529]}, ... % Baffin coastal tundra
    {'ECO_ID',51106,'FaceColor',[0.894118 0.823529 0.749020]}, ... % Beringia lowland tundra
    {'ECO_ID',51107,'FaceColor',[0.400000 0.360784 0.298039]}, ... % Beringia upland tundra
    {'ECO_ID',51108,'FaceColor',[0.278431 0.407843 0.470588]}, ... % Brooks-British Range tundra
    {'ECO_ID',51109,'FaceColor',[0.666667 0.733333 1.000000]}, ... % Davis Highlands tundra
    {'ECO_ID',51110,'FaceColor',[0.317647 0.117647 0.658824]}, ... % High Arctic tundra
    {'ECO_ID',51111,'FaceColor',[0.305882 0.000000 0.454902]}, ... % Interior Yukon-Alaska alpine tundra
    {'ECO_ID',51112,'FaceColor',[0.643137 0.356863 0.400000]}, ... % Kalaallit Nunaat high arctic tundra
    {'ECO_ID',51113,'FaceColor',[0.788235 0.556863 0.396078]}, ... % Kalaallit Nunaat low arctic tundra
    {'ECO_ID',51114,'FaceColor',[0.725490 0.568627 0.403922]}, ... % Low Arctic tundra
    {'ECO_ID',51115,'FaceColor',[0.694118 0.549020 0.450980]}, ... % Middle Arctic tundra
    {'ECO_ID',51116,'FaceColor',[0.400000 0.192157 0.235294]}, ... % Ogilvie-MacKenzie alpine tundra
    {'ECO_ID',51117,'FaceColor',[0.525490 0.301961 0.294118]}, ... % Pacific Coastal Mountain icefields and tundra
    {'ECO_ID',51118,'FaceColor',[0.937255 0.749020 0.486275]}, ... % Torngat Mountain tundra
    {'ECO_ID',51201,'FaceColor',[0.858824 0.819608 0.360784]}, ... % California coastal sage and chaparral
    {'ECO_ID',51202,'FaceColor',[0.443137 0.666667 0.047059]}, ... % California interior chaparral and woodlands
    {'ECO_ID',51203,'FaceColor',[0.462745 0.650980 0.145098]}, ... % California montane chaparral and woodlands
    {'ECO_ID',51301,'FaceColor',[0.360784 0.219608 0.090196]}, ... % Baja California desert
    {'ECO_ID',51302,'FaceColor',[0.388235 0.203922 0.239216]}, ... % Central Mexican matorral
    {'ECO_ID',51303,'FaceColor',[0.564706 0.635294 0.623529]}, ... % Chihuahuan desert
    {'ECO_ID',51304,'FaceColor',[0.447059 0.611765 0.592157]}, ... % Colorado Plateau shrublands
    {'ECO_ID',51305,'FaceColor',[0.800000 0.921569 0.933333]}, ... % Great Basin shrub steppe
    {'ECO_ID',51306,'FaceColor',[0.247059 0.192157 0.121569]}, ... % Gulf of California xeric scrub
    {'ECO_ID',51307,'FaceColor',[0.549020 0.192157 0.000000]}, ... % Meseta Central matorral
    {'ECO_ID',51308,'FaceColor',[0.909804 0.654902 0.400000]}, ... % Mojave desert
    {'ECO_ID',51309,'FaceColor',[0.203922 0.470588 0.439216]}, ... % Snake-Columbia shrub steppe
    {'ECO_ID',51310,'FaceColor',[0.423529 0.776471 0.803922]}, ... % Sonoran desert
    {'ECO_ID',51311,'FaceColor',[0.298039 0.286275 0.192157]}, ... % Tamaulipan matorral
    {'ECO_ID',51312,'FaceColor',[0.541176 0.494118 0.411765]}, ... % Tamaulipan mezquital
    {'ECO_ID',51313,'FaceColor',[0.337255 0.584314 0.639216]}, ... % Wyoming Basin shrub steppe
    {'ECO_ID',60101,'FaceColor',[0.462745 0.643137 0.768627]}, ... % Araucaria moist forests
    {'ECO_ID',60102,'FaceColor',[0.521569 0.286275 0.400000]}, ... % Atlantic Coast restingas
    {'ECO_ID',60103,'FaceColor',[0.639216 0.356863 0.384314]}, ... % Bahia coastal forests
    {'ECO_ID',60104,'FaceColor',[0.423529 0.458824 0.309804]}, ... % Bahia interior forests
    {'ECO_ID',60105,'FaceColor',[0.749020 0.921569 0.725490]}, ... % Bolivian Yungas
    {'ECO_ID',60106,'FaceColor',[0.752941 0.882353 0.780392]}, ... % Caatinga Enclaves moist forests
    {'ECO_ID',60107,'FaceColor',[0.133333 0.200000 0.058824]}, ... % Caqueta moist forests
    {'ECO_ID',60108,'FaceColor',[0.623529 0.584314 0.278431]}, ... % Catatumbo moist forests
    {'ECO_ID',60109,'FaceColor',[0.560784 0.462745 0.305882]}, ... % Cauca Valley montane forests
    {'ECO_ID',60110,'FaceColor',[0.827451 0.725490 1.000000]}, ... % Cayos Miskitos-San Andrés and Providencia moist forests
    {'ECO_ID',60111,'FaceColor',[0.301961 0.137255 0.603922]}, ... % Central American Atlantic moist forests
    {'ECO_ID',60112,'FaceColor',[0.400000 0.105882 0.435294]}, ... % Central American montane forests
    {'ECO_ID',60113,'FaceColor',[0.462745 0.176471 0.317647]}, ... % Chiapas montane forests
    {'ECO_ID',60114,'FaceColor',[0.501961 0.372549 0.262745]}, ... % Chimalapas montane forests
    {'ECO_ID',60115,'FaceColor',[0.223529 0.192157 0.113725]}, ... % Chocó-Darién moist forests
    {'ECO_ID',60116,'FaceColor',[0.317647 0.325490 0.541176]}, ... % Cocos Island moist forests
    {'ECO_ID',60117,'FaceColor',[0.474510 0.337255 0.674510]}, ... % Cordillera La Costa montane forests
    {'ECO_ID',60118,'FaceColor',[0.647059 0.176471 0.482353]}, ... % Cordillera Oriental montane forests
    {'ECO_ID',60119,'FaceColor',[0.945098 0.505882 0.670588]}, ... % Costa Rican seasonal moist forests
    {'ECO_ID',60120,'FaceColor',[0.541176 0.490196 0.423529]}, ... % Cuban moist forests
    {'ECO_ID',60121,'FaceColor',[0.643137 0.843137 0.647059]}, ... % Eastern Cordillera real montane forests
    {'ECO_ID',60122,'FaceColor',[0.498039 0.819608 0.596078]}, ... % Eastern Panamanian montane forests
    {'ECO_ID',60123,'FaceColor',[0.713725 0.972549 0.898039]}, ... % Fernando de Noronha-Atol das Rocas moist forests
    {'ECO_ID',60124,'FaceColor',[0.713725 0.725490 0.968627]}, ... % Guianan Highlands moist forests
    {'ECO_ID',60125,'FaceColor',[0.109804 0.062745 0.317647]}, ... % Guianan moist forests
    {'ECO_ID',60126,'FaceColor',[0.364706 0.470588 0.423529]}, ... % Gurupa varzeá
    {'ECO_ID',60127,'FaceColor',[0.749020 0.925490 0.698039]}, ... % Hispaniolan moist forests
    {'ECO_ID',60128,'FaceColor',[0.592157 0.764706 0.466667]}, ... % Iquitos varzeá
    {'ECO_ID',60129,'FaceColor',[0.400000 0.600000 0.294118]}, ... % Isthmian-Atlantic moist forests
    {'ECO_ID',60130,'FaceColor',[0.215686 0.490196 0.211765]}, ... % Isthmian-Pacific moist forests
    {'ECO_ID',60131,'FaceColor',[0.698039 0.811765 0.635294]}, ... % Jamaican moist forests
    {'ECO_ID',60132,'FaceColor',[0.674510 0.380392 0.380392]}, ... % Japurá-Solimoes-Negro moist forests
    {'ECO_ID',60133,'FaceColor',[0.933333 0.564706 0.686275]}, ... % Juruá-Purus moist forests
    {'ECO_ID',60134,'FaceColor',[0.184314 0.070588 0.254902]}, ... % Leeward Islands moist forests
    {'ECO_ID',60135,'FaceColor',[0.909804 0.886275 1.000000]}, ... % Madeira-Tapajós moist forests
    {'ECO_ID',60136,'FaceColor',[0.301961 0.203922 0.290196]}, ... % Magdalena Valley montane forests
    {'ECO_ID',60137,'FaceColor',[0.482353 0.329412 0.407843]}, ... % Magdalena-Urabá moist forests
    {'ECO_ID',60138,'FaceColor',[0.576471 0.388235 0.549020]}, ... % Marajó varzeá
    {'ECO_ID',60139,'FaceColor',[0.501961 0.290196 0.600000]}, ... % Maranhão Babaçu forests
    {'ECO_ID',60140,'FaceColor',[0.305882 0.070588 0.615686]}, ... % Mato Grosso seasonal forests
    {'ECO_ID',60141,'FaceColor',[0.403922 0.219608 0.709804]}, ... % Monte Alegre varzeá
    {'ECO_ID',60142,'FaceColor',[0.313725 0.254902 0.396078]}, ... % Napo moist forests
    {'ECO_ID',60143,'FaceColor',[0.580392 0.521569 0.521569]}, ... % Negro-Branco moist forests
    {'ECO_ID',60144,'FaceColor',[0.647059 0.478431 0.521569]}, ... % Northeastern Brazil restingas
    {'ECO_ID',60145,'FaceColor',[0.611765 0.400000 0.474510]}, ... % Northwestern Andean montane forests
    {'ECO_ID',60146,'FaceColor',[0.611765 0.431373 0.537255]}, ... % Oaxacan montane forests
    {'ECO_ID',60147,'FaceColor',[0.364706 0.254902 0.309804]}, ... % Orinoco Delta swamp forests
    {'ECO_ID',60148,'FaceColor',[0.650980 0.666667 0.596078]}, ... % Pantanos de Centla
    {'ECO_ID',60149,'FaceColor',[0.168627 0.200000 0.031373]}, ... % Guianan freshwater swamp forests
    {'ECO_ID',60150,'FaceColor',[0.270588 0.227451 0.000000]}, ... % Alto Paraná Atlantic forests
    {'ECO_ID',60151,'FaceColor',[0.458824 0.462745 0.235294]}, ... % Pernambuco coastal forests
    {'ECO_ID',60152,'FaceColor',[0.764706 0.933333 0.831373]}, ... % Pernambuco interior forests
    {'ECO_ID',60153,'FaceColor',[0.466667 0.635294 0.631373]}, ... % Peruvian Yungas
    {'ECO_ID',60154,'FaceColor',[0.286275 0.282353 0.341176]}, ... % Petén-Veracruz moist forests
    {'ECO_ID',60155,'FaceColor',[0.929412 0.776471 0.721569]}, ... % Puerto Rican moist forests
    {'ECO_ID',60156,'FaceColor',[1.000000 0.796078 0.435294]}, ... % Purus varzeá
    {'ECO_ID',60157,'FaceColor',[0.647059 0.498039 0.003922]}, ... % Purus-Madeira moist forests
    {'ECO_ID',60158,'FaceColor',[0.215686 0.411765 0.000000]}, ... % Rio Negro campinarana
    {'ECO_ID',60159,'FaceColor',[0.549020 0.827451 0.454902]}, ... % Santa Marta montane forests
    {'ECO_ID',60160,'FaceColor',[0.321569 0.435294 0.156863]}, ... % Serra do Mar coastal forests
    {'ECO_ID',60161,'FaceColor',[0.541176 0.627451 0.470588]}, ... % Sierra de los Tuxtlas
    {'ECO_ID',60162,'FaceColor',[0.447059 0.643137 0.611765]}, ... % Sierra Madre de Chiapas moist forests
    {'ECO_ID',60163,'FaceColor',[0.325490 0.458824 0.439216]}, ... % Solimões-Japurá moist forests
    {'ECO_ID',60164,'FaceColor',[0.898039 0.788235 0.670588]}, ... % South Florida rocklands
    {'ECO_ID',60165,'FaceColor',[0.901961 0.658824 0.509804]}, ... % Southern Andean Yungas
    {'ECO_ID',60166,'FaceColor',[0.415686 0.141176 0.007843]}, ... % Southwest Amazon moist forests
    {'ECO_ID',60167,'FaceColor',[0.666667 0.384314 0.270588]}, ... % Talamancan montane forests
    {'ECO_ID',60168,'FaceColor',[0.690196 0.345098 0.325490]}, ... % Tapajós-Xingu moist forests
    {'ECO_ID',60169,'FaceColor',[1.000000 0.862745 0.945098]}, ... % Pantepui
    {'ECO_ID',60170,'FaceColor',[0.741176 0.650980 1.000000]}, ... % Tocantins/Pindare moist forests
    {'ECO_ID',60171,'FaceColor',[0.098039 0.176471 0.443137]}, ... % Trinidad and Tobago moist forests
    {'ECO_ID',60172,'FaceColor',[0.717647 1.000000 0.721569]}, ... % Trindade-Martin Vaz Islands tropical forests
    {'ECO_ID',60173,'FaceColor',[0.568627 0.780392 0.517647]}, ... % Uatuma-Trombetas moist forests
    {'ECO_ID',60174,'FaceColor',[0.294118 0.145098 0.454902]}, ... % Ucayali moist forests
    {'ECO_ID',60175,'FaceColor',[0.513725 0.345098 0.721569]}, ... % Venezuelan Andes montane forests
    {'ECO_ID',60176,'FaceColor',[0.737255 0.886275 0.819608]}, ... % Veracruz moist forests
    {'ECO_ID',60177,'FaceColor',[0.647059 0.749020 0.560784]}, ... % Veracruz montane forests
    {'ECO_ID',60178,'FaceColor',[0.517647 0.211765 0.231373]}, ... % Western Ecuador moist forests
    {'ECO_ID',60179,'FaceColor',[0.843137 0.517647 0.521569]}, ... % Windward Islands moist forests
    {'ECO_ID',60180,'FaceColor',[0.435294 0.490196 0.231373]}, ... % Xingu-Tocantins-Araguaia moist forests
    {'ECO_ID',60181,'FaceColor',[0.933333 0.996078 0.745098]}, ... % Yucatán moist forests
    {'ECO_ID',60182,'FaceColor',[0.552941 0.243137 0.250980]}, ... % Guianan piedmont and lowland moist forests
    {'ECO_ID',60201,'FaceColor',[0.329412 0.286275 0.243137]}, ... % Apure-Villavicencio dry forests
    {'ECO_ID',60202,'FaceColor',[0.541176 0.513725 0.611765]}, ... % Atlantic dry forests
    {'ECO_ID',60204,'FaceColor',[0.396078 0.400000 0.780392]}, ... % Bajío dry forests
    {'ECO_ID',60205,'FaceColor',[0.458824 0.419608 0.792157]}, ... % Balsas dry forests
    {'ECO_ID',60206,'FaceColor',[0.356863 0.200000 0.270588]}, ... % Bolivian montane dry forests
    {'ECO_ID',60207,'FaceColor',[0.815686 0.501961 0.470588]}, ... % Cauca Valley dry forests
    {'ECO_ID',60209,'FaceColor',[0.796078 0.290196 0.345098]}, ... % Central American dry forests
    {'ECO_ID',60210,'FaceColor',[0.784314 0.301961 0.411765]}, ... % Dry Chaco
    {'ECO_ID',60211,'FaceColor',[0.968627 0.721569 0.858824]}, ... % Chiapas Depression dry forests
    {'ECO_ID',60212,'FaceColor',[0.349020 0.200000 0.325490]}, ... % Chiquitano dry forests
    {'ECO_ID',60213,'FaceColor',[0.741176 0.541176 0.627451]}, ... % Cuban dry forests
    {'ECO_ID',60214,'FaceColor',[1.000000 0.803922 0.854902]}, ... % Ecuadorian dry forests
    {'ECO_ID',60215,'FaceColor',[0.415686 0.250980 0.262745]}, ... % Hispaniolan dry forests
    {'ECO_ID',60216,'FaceColor',[0.639216 0.505882 0.462745]}, ... % Islas Revillagigedo dry forests
    {'ECO_ID',60217,'FaceColor',[0.231373 0.125490 0.000000]}, ... % Jalisco dry forests
    {'ECO_ID',60218,'FaceColor',[0.643137 0.701961 0.521569]}, ... % Jamaican dry forests
    {'ECO_ID',60219,'FaceColor',[0.407843 0.776471 0.607843]}, ... % Lara-Falcón dry forests
    {'ECO_ID',60220,'FaceColor',[0.019608 0.474510 0.403922]}, ... % Lesser Antillean dry forests
    {'ECO_ID',60221,'FaceColor',[0.392157 0.717647 0.823529]}, ... % Magdalena Valley dry forests
    {'ECO_ID',60222,'FaceColor',[0.458824 0.717647 0.776471]}, ... % Maracaibo dry forests
    {'ECO_ID',60223,'FaceColor',[0.552941 0.819608 0.600000]}, ... % Marañón dry forests
    {'ECO_ID',60224,'FaceColor',[0.662745 0.843137 0.674510]}, ... % Panamanian dry forests
    {'ECO_ID',60225,'FaceColor',[0.145098 0.129412 0.360784]}, ... % Patía Valley dry forests
    {'ECO_ID',60226,'FaceColor',[0.392157 0.360784 0.619608]}, ... % Puerto Rican dry forests
    {'ECO_ID',60227,'FaceColor',[0.172549 0.298039 0.227451]}, ... % Sierra de la Laguna dry forests
    {'ECO_ID',60228,'FaceColor',[0.529412 0.588235 0.439216]}, ... % Sinaloan dry forests
    {'ECO_ID',60229,'FaceColor',[0.835294 0.607843 0.627451]}, ... % Sinú Valley dry forests
    {'ECO_ID',60230,'FaceColor',[0.415686 0.129412 0.078431]}, ... % Southern Pacific dry forests
    {'ECO_ID',60232,'FaceColor',[0.784314 0.658824 0.298039]}, ... % Tumbes-Piura dry forests
    {'ECO_ID',60233,'FaceColor',[1.000000 0.874510 0.560784]}, ... % Veracruz dry forests
    {'ECO_ID',60235,'FaceColor',[0.525490 0.090196 0.192157]}, ... % Yucatán dry forests
    {'ECO_ID',60301,'FaceColor',[0.635294 0.184314 0.419608]}, ... % Bahamian pine mosaic
    {'ECO_ID',60302,'FaceColor',[0.850980 0.623529 0.694118]}, ... % Belizian pine forests
    {'ECO_ID',60303,'FaceColor',[0.384314 0.305882 0.243137]}, ... % Central American pine-oak forests
    {'ECO_ID',60304,'FaceColor',[0.811765 0.807843 0.631373]}, ... % Cuban pine forests
    {'ECO_ID',60305,'FaceColor',[0.843137 0.788235 0.670588]}, ... % Hispaniolan pine forests
    {'ECO_ID',60306,'FaceColor',[0.462745 0.239216 0.349020]}, ... % Miskito pine forests
    {'ECO_ID',60307,'FaceColor',[0.388235 0.207843 0.415686]}, ... % Sierra de la Laguna pine-oak forests
    {'ECO_ID',60308,'FaceColor',[0.431373 0.537255 0.686275]}, ... % Sierra Madre de Oaxaca pine-oak forests
    {'ECO_ID',60309,'FaceColor',[0.070588 0.290196 0.321569]}, ... % Sierra Madre del Sur pine-oak forests
    {'ECO_ID',60310,'FaceColor',[0.164706 0.325490 0.184314]}, ... % Trans-Mexican Volcanic Belt pine-oak forests
    {'ECO_ID',60401,'FaceColor',[0.286275 0.462745 0.235294]}, ... % Juan Fernández Islands temperate forests
    {'ECO_ID',60402,'FaceColor',[0.435294 0.690196 0.458824]}, ... % Magellanic subpolar forests
    {'ECO_ID',60403,'FaceColor',[0.619608 0.823529 0.556863]}, ... % San Félix-San Ambrosio Islands temperate forests
    {'ECO_ID',60404,'FaceColor',[0.584314 0.607843 0.250980]}, ... % Valdivian temperate forests
    {'ECO_ID',60702,'FaceColor',[0.760784 0.592157 0.286275]}, ... % Beni savanna
    {'ECO_ID',60703,'FaceColor',[0.470588 0.094118 0.000000]}, ... % Campos Rupestres montane savanna
    {'ECO_ID',60704,'FaceColor',[0.478431 0.152941 0.188235]}, ... % Cerrado
    {'ECO_ID',60705,'FaceColor',[0.262745 0.231373 0.450980]}, ... % Clipperton Island shrub and grasslands
    {'ECO_ID',60707,'FaceColor',[0.027451 0.180392 0.376471]}, ... % Guianan savanna
    {'ECO_ID',60708,'FaceColor',[0.094118 0.317647 0.278431]}, ... % Humid Chaco
    {'ECO_ID',60709,'FaceColor',[0.282353 0.505882 0.411765]}, ... % Llanos
    {'ECO_ID',60710,'FaceColor',[0.513725 0.678431 0.690196]}, ... % Uruguayan savanna
    {'ECO_ID',60801,'FaceColor',[0.250980 0.423529 0.360784]}, ... % Espinal
    {'ECO_ID',60802,'FaceColor',[0.513725 0.756863 0.443137]}, ... % Low Monte
    {'ECO_ID',60803,'FaceColor',[0.764706 0.878431 0.639216]}, ... % Humid Pampas
    {'ECO_ID',60805,'FaceColor',[0.349020 0.137255 0.305882]}, ... % Patagonian steppe
    {'ECO_ID',60902,'FaceColor',[0.380392 0.180392 0.368627]}, ... % Cuban wetlands
    {'ECO_ID',60903,'FaceColor',[0.423529 0.584314 0.392157]}, ... % Enriquillo wetlands
    {'ECO_ID',60904,'FaceColor',[0.631373 0.917647 0.643137]}, ... % Everglades
    {'ECO_ID',60905,'FaceColor',[0.431373 0.611765 0.537255]}, ... % Guayaquil flooded grasslands
    {'ECO_ID',60906,'FaceColor',[0.262745 0.337255 0.337255]}, ... % Orinoco wetlands
    {'ECO_ID',60907,'FaceColor',[0.615686 0.572549 0.521569]}, ... % Pantanal
    {'ECO_ID',60908,'FaceColor',[0.811765 0.792157 0.741176]}, ... % Paraná flooded savanna
    {'ECO_ID',60909,'FaceColor',[0.541176 0.686275 0.682353]}, ... % Southern Cone Mesopotamian savanna
    {'ECO_ID',61001,'FaceColor',[0.498039 0.647059 0.662745]}, ... % Central Andean dry puna
    {'ECO_ID',61002,'FaceColor',[0.364706 0.368627 0.380392]}, ... % Central Andean puna
    {'ECO_ID',61003,'FaceColor',[0.301961 0.200000 0.317647]}, ... % Central Andean wet puna
    {'ECO_ID',61004,'FaceColor',[0.572549 0.411765 0.745098]}, ... % Cordillera Central páramo
    {'ECO_ID',61005,'FaceColor',[0.376471 0.200000 0.521569]}, ... % Cordillera de Merida páramo
    {'ECO_ID',61006,'FaceColor',[0.862745 0.729412 0.792157]}, ... % Northern Andean páramo
    {'ECO_ID',61007,'FaceColor',[0.619608 0.533333 0.454902]}, ... % Santa Marta páramo
    {'ECO_ID',61008,'FaceColor',[0.639216 0.603922 0.509804]}, ... % Southern Andean steppe
    {'ECO_ID',61010,'FaceColor',[0.545098 0.600000 0.482353]}, ... % High Monte
    {'ECO_ID',61201,'FaceColor',[0.635294 0.811765 0.662745]}, ... % Chilean matorral
    {'ECO_ID',61301,'FaceColor',[0.168627 0.266667 0.176471]}, ... % Araya and Paria xeric scrub
    {'ECO_ID',61303,'FaceColor',[0.596078 0.411765 0.454902]}, ... % Atacama desert
    {'ECO_ID',61304,'FaceColor',[0.364706 0.031373 0.117647]}, ... % Caatinga
    {'ECO_ID',61305,'FaceColor',[0.427451 0.070588 0.125490]}, ... % Caribbean shrublands
    {'ECO_ID',61306,'FaceColor',[0.443137 0.192157 0.223529]}, ... % Cuban cactus scrub
    {'ECO_ID',61307,'FaceColor',[0.874510 0.866667 0.886275]}, ... % Galápagos Islands scrubland mosaic
    {'ECO_ID',61308,'FaceColor',[0.384314 0.392157 0.474510]}, ... % Guajira-Barranquilla xeric scrub
    {'ECO_ID',61309,'FaceColor',[0.662745 0.470588 0.654902]}, ... % La Costa xeric shrublands
    {'ECO_ID',61311,'FaceColor',[0.360784 0.160784 0.356863]}, ... % Malpelo Island xeric scrub
    {'ECO_ID',61312,'FaceColor',[0.600000 0.592157 0.701961]}, ... % Motagua Valley thornscrub
    {'ECO_ID',61313,'FaceColor',[0.776471 0.862745 0.780392]}, ... % Paraguana xeric scrub
    {'ECO_ID',61314,'FaceColor',[0.764706 0.847059 0.462745]}, ... % San Lucan xeric scrub
    {'ECO_ID',61315,'FaceColor',[0.329412 0.525490 0.078431]}, ... % Sechura desert
    {'ECO_ID',61316,'FaceColor',[0.250980 0.674510 0.403922]}, ... % Tehuacán Valley matorral
    {'ECO_ID',61318,'FaceColor',[0.333333 0.729412 0.537255]}, ... % St. Peter and St. Paul rocks
    {'ECO_ID',61401,'FaceColor',[0.686275 0.811765 0.592157]}, ... % Amazon-Orinoco-Southern Caribbean mangroves
    {'ECO_ID',61402,'FaceColor',[0.882353 0.776471 0.635294]}, ... % Bahamian-Antillean mangroves
    {'ECO_ID',61403,'FaceColor',[0.568627 0.266667 0.309804]}, ... % Mesoamerican Gulf-Caribbean mangroves
    {'ECO_ID',61404,'FaceColor',[1.000000 0.717647 0.843137]}, ... % Northern Mesoamerican Pacific mangroves
    {'ECO_ID',61405,'FaceColor',[0.678431 0.509804 0.611765]}, ... % South American Pacific mangroves
    {'ECO_ID',61406,'FaceColor',[0.450980 0.368627 0.470588]}, ... % Southern Atlantic mangroves
    {'ECO_ID',61407,'FaceColor',[0.352941 0.290196 0.407843]}, ... % Southern Mesoamerican Pacific mangroves
    {'ECO_ID',70101,'FaceColor',[0.396078 0.427451 0.505882]}, ... % Carolines tropical moist forests
    {'ECO_ID',70102,'FaceColor',[0.545098 0.737255 0.725490]}, ... % Central Polynesian tropical moist forests
    {'ECO_ID',70103,'FaceColor',[0.015686 0.325490 0.325490]}, ... % Cook Islands tropical moist forests
    {'ECO_ID',70104,'FaceColor',[0.141176 0.505882 0.643137]}, ... % Eastern Micronesia tropical moist forests
    {'ECO_ID',70105,'FaceColor',[0.509804 0.803922 0.843137]}, ... % Fiji tropical moist forests
    {'ECO_ID',70106,'FaceColor',[0.580392 0.682353 0.376471]}, ... % Hawaii tropical moist forests
    {'ECO_ID',70107,'FaceColor',[0.964706 0.850980 0.560784]}, ... % Kermadec Islands subtropical moist forests
    {'ECO_ID',70108,'FaceColor',[0.745098 0.407843 0.486275]}, ... % Marquesas tropical moist forests
    {'ECO_ID',70109,'FaceColor',[0.811765 0.501961 0.752941]}, ... % Ogasawara subtropical moist forests
    {'ECO_ID',70110,'FaceColor',[0.286275 0.254902 0.490196]}, ... % Palau tropical moist forests
    {'ECO_ID',70111,'FaceColor',[0.639216 0.721569 0.972549]}, ... % Rapa Nui subtropical broadleaf forests
    {'ECO_ID',70112,'FaceColor',[0.066667 0.101961 0.392157]}, ... % Samoan tropical moist forests
    {'ECO_ID',70113,'FaceColor',[0.862745 0.968627 1.000000]}, ... % Society Islands tropical moist forests
    {'ECO_ID',70114,'FaceColor',[0.403922 0.698039 0.949020]}, ... % Tongan tropical moist forests
    {'ECO_ID',70115,'FaceColor',[0.113725 0.450980 0.521569]}, ... % Tuamotu tropical moist forests
    {'ECO_ID',70116,'FaceColor',[0.517647 0.756863 0.521569]}, ... % Tubuai tropical moist forests
    {'ECO_ID',70117,'FaceColor',[0.435294 0.615686 0.364706]}, ... % Western Polynesian tropical moist forests
    {'ECO_ID',70201,'FaceColor',[0.262745 0.423529 0.435294]}, ... % Fiji tropical dry forests
    {'ECO_ID',70202,'FaceColor',[0.113725 0.200000 0.356863]}, ... % Hawaii tropical dry forests
    {'ECO_ID',70203,'FaceColor',[0.545098 0.509804 0.690196]}, ... % Marianas tropical dry forests
    {'ECO_ID',70204,'FaceColor',[0.474510 0.313725 0.505882]}, ... % Yap tropical dry forests
    {'ECO_ID',70701,'FaceColor',[0.580392 0.301961 0.494118]}, ... % Hawaii tropical high shrublands
    {'ECO_ID',70702,'FaceColor',[0.478431 0.309804 0.545098]}, ... % Hawaii tropical low shrublands
    {'ECO_ID',70703,'FaceColor',[0.086275 0.239216 0.568627]}, ... % Northwestern Hawaii scrub
    {'ECO_ID',80101,'FaceColor',[0.258824 0.541176 0.705882]}, ... % Guizhou Plateau broadleaf and mixed forests
    {'ECO_ID',80102,'FaceColor',[0.196078 0.403922 0.149020]}, ... % Yunnan Plateau subtropical evergreen forests
    {'ECO_ID',80401,'FaceColor',[0.737255 0.839216 0.431373]}, ... % Appenine deciduous montane forests
    {'ECO_ID',80402,'FaceColor',[0.337255 0.286275 0.000000]}, ... % Atlantic mixed forests
    {'ECO_ID',80403,'FaceColor',[0.698039 0.541176 0.262745]}, ... % Azores temperate mixed forests
    {'ECO_ID',80404,'FaceColor',[0.917647 0.686275 0.352941]}, ... % Balkan mixed forests
    {'ECO_ID',80405,'FaceColor',[0.494118 0.356863 0.039216]}, ... % Baltic mixed forests
    {'ECO_ID',80406,'FaceColor',[0.635294 0.756863 0.525490]}, ... % Cantabrian mixed forests
    {'ECO_ID',80407,'FaceColor',[0.470588 0.627451 0.560784]}, ... % Caspian Hyrcanian mixed forests
    {'ECO_ID',80408,'FaceColor',[0.529412 0.474510 0.678431]}, ... % Caucasus mixed forests
    {'ECO_ID',80409,'FaceColor',[0.415686 0.200000 0.635294]}, ... % Celtic broadleaf forests
    {'ECO_ID',80410,'FaceColor',[0.690196 0.345098 0.992157]}, ... % Central Anatolian steppe and woodlands
    {'ECO_ID',80411,'FaceColor',[0.223529 0.011765 0.615686]}, ... % Central China loess plateau mixed forests
    {'ECO_ID',80412,'FaceColor',[0.376471 0.564706 0.874510]}, ... % Central European mixed forests
    {'ECO_ID',80413,'FaceColor',[0.333333 0.592157 0.619608]}, ... % Central Korean deciduous forests
    {'ECO_ID',80414,'FaceColor',[0.200000 0.211765 0.000000]}, ... % Changbai Mountains mixed forests
    {'ECO_ID',80415,'FaceColor',[0.901961 0.933333 0.596078]}, ... % Changjiang Plain evergreen forests
    {'ECO_ID',80416,'FaceColor',[0.317647 0.643137 0.403922]}, ... % Crimean Submediterranean forest complex
    {'ECO_ID',80417,'FaceColor',[0.105882 0.372549 0.301961]}, ... % Daba Mountains evergreen forests
    {'ECO_ID',80418,'FaceColor',[0.337255 0.203922 0.368627]}, ... % Dinaric Mountains mixed forests
    {'ECO_ID',80419,'FaceColor',[1.000000 0.901961 1.000000]}, ... % East European forest steppe
    {'ECO_ID',80420,'FaceColor',[0.188235 0.172549 0.298039]}, ... % Eastern Anatolian deciduous forests
    {'ECO_ID',80421,'FaceColor',[0.568627 0.600000 0.623529]}, ... % English Lowlands beech forests
    {'ECO_ID',80422,'FaceColor',[0.894118 0.823529 0.749020]}, ... % Euxine-Colchic broadleaf forests
    {'ECO_ID',80423,'FaceColor',[0.400000 0.360784 0.298039]}, ... % Hokkaido deciduous forests
    {'ECO_ID',80424,'FaceColor',[0.278431 0.407843 0.470588]}, ... % Huang He Plain mixed forests
    {'ECO_ID',80425,'FaceColor',[0.666667 0.733333 1.000000]}, ... % Madeira evergreen forests
    {'ECO_ID',80426,'FaceColor',[0.317647 0.117647 0.658824]}, ... % Manchurian mixed forests
    {'ECO_ID',80427,'FaceColor',[0.305882 0.000000 0.454902]}, ... % Nihonkai evergreen forests
    {'ECO_ID',80428,'FaceColor',[0.643137 0.356863 0.400000]}, ... % Nihonkai montane deciduous forests
    {'ECO_ID',80429,'FaceColor',[0.788235 0.556863 0.396078]}, ... % North Atlantic moist mixed forests
    {'ECO_ID',80430,'FaceColor',[0.725490 0.568627 0.403922]}, ... % Northeast China Plain deciduous forests
    {'ECO_ID',80431,'FaceColor',[0.694118 0.549020 0.450980]}, ... % Pannonian mixed forests
    {'ECO_ID',80432,'FaceColor',[0.400000 0.192157 0.235294]}, ... % Po Basin mixed forests
    {'ECO_ID',80433,'FaceColor',[0.525490 0.301961 0.294118]}, ... % Pyrenees conifer and mixed forests
    {'ECO_ID',80434,'FaceColor',[0.937255 0.749020 0.486275]}, ... % Qin Ling Mountains deciduous forests
    {'ECO_ID',80435,'FaceColor',[0.858824 0.819608 0.360784]}, ... % Rodope montane mixed forests
    {'ECO_ID',80436,'FaceColor',[0.443137 0.666667 0.047059]}, ... % Sarmatic mixed forests
    {'ECO_ID',80437,'FaceColor',[0.462745 0.650980 0.145098]}, ... % Sichuan Basin evergreen broadleaf forests
    {'ECO_ID',80438,'FaceColor',[0.360784 0.219608 0.090196]}, ... % South Sakhalin-Kurile mixed forests
    {'ECO_ID',80439,'FaceColor',[0.388235 0.203922 0.239216]}, ... % Southern Korea evergreen forests
    {'ECO_ID',80440,'FaceColor',[0.564706 0.635294 0.623529]}, ... % Taiheiyo evergreen forests
    {'ECO_ID',80441,'FaceColor',[0.447059 0.611765 0.592157]}, ... % Taiheiyo montane deciduous forests
    {'ECO_ID',80442,'FaceColor',[0.800000 0.921569 0.933333]}, ... % Tarim Basin deciduous forests and steppe
    {'ECO_ID',80443,'FaceColor',[0.247059 0.192157 0.121569]}, ... % Ussuri broadleaf and mixed forests
    {'ECO_ID',80444,'FaceColor',[0.549020 0.192157 0.000000]}, ... % Western Siberian hemiboreal forests
    {'ECO_ID',80445,'FaceColor',[0.909804 0.654902 0.400000]}, ... % Western European broadleaf forests
    {'ECO_ID',80446,'FaceColor',[0.203922 0.470588 0.439216]}, ... % Zagros Mountains forest steppe
    {'ECO_ID',80501,'FaceColor',[0.423529 0.776471 0.803922]}, ... % Alps conifer and mixed forests
    {'ECO_ID',80502,'FaceColor',[0.298039 0.286275 0.192157]}, ... % Altai montane forest and forest steppe
    {'ECO_ID',80503,'FaceColor',[0.541176 0.494118 0.411765]}, ... % Caledon conifer forests
    {'ECO_ID',80504,'FaceColor',[0.337255 0.584314 0.639216]}, ... % Carpathian montane forests
    {'ECO_ID',80505,'FaceColor',[0.462745 0.643137 0.768627]}, ... % Da Hinggan-Dzhagdy Mountains conifer forests
    {'ECO_ID',80506,'FaceColor',[0.521569 0.286275 0.400000]}, ... % East Afghan montane conifer forests
    {'ECO_ID',80507,'FaceColor',[0.639216 0.356863 0.384314]}, ... % Elburz Range forest steppe
    {'ECO_ID',80508,'FaceColor',[0.423529 0.458824 0.309804]}, ... % Helanshan montane conifer forests
    {'ECO_ID',80509,'FaceColor',[0.749020 0.921569 0.725490]}, ... % Hengduan Mountains subalpine conifer forests
    {'ECO_ID',80510,'FaceColor',[0.752941 0.882353 0.780392]}, ... % Hokkaido montane conifer forests
    {'ECO_ID',80511,'FaceColor',[0.133333 0.200000 0.058824]}, ... % Honshu alpine conifer forests
    {'ECO_ID',80512,'FaceColor',[0.623529 0.584314 0.278431]}, ... % Khangai Mountains conifer forests
    {'ECO_ID',80513,'FaceColor',[0.560784 0.462745 0.305882]}, ... % Mediterranean conifer and mixed forests
    {'ECO_ID',80514,'FaceColor',[0.827451 0.725490 1.000000]}, ... % Northeastern Himalayan subalpine conifer forests
    {'ECO_ID',80515,'FaceColor',[0.301961 0.137255 0.603922]}, ... % Northern Anatolian conifer and deciduous forests
    {'ECO_ID',80516,'FaceColor',[0.400000 0.105882 0.435294]}, ... % Nujiang Langcang Gorge alpine conifer and mixed forests
    {'ECO_ID',80517,'FaceColor',[0.462745 0.176471 0.317647]}, ... % Qilian Mountains conifer forests
    {'ECO_ID',80518,'FaceColor',[0.501961 0.372549 0.262745]}, ... % Qionglai-Minshan conifer forests
    {'ECO_ID',80519,'FaceColor',[0.223529 0.192157 0.113725]}, ... % Sayan montane conifer forests
    {'ECO_ID',80520,'FaceColor',[0.317647 0.325490 0.541176]}, ... % Scandinavian coastal conifer forests
    {'ECO_ID',80521,'FaceColor',[0.474510 0.337255 0.674510]}, ... % Tian Shan montane conifer forests
    {'ECO_ID',80601,'FaceColor',[0.647059 0.176471 0.482353]}, ... % East Siberian taiga
    {'ECO_ID',80602,'FaceColor',[0.945098 0.505882 0.670588]}, ... % Iceland boreal birch forests and alpine tundra
    {'ECO_ID',80603,'FaceColor',[0.541176 0.490196 0.423529]}, ... % Kamchatka-Kurile meadows and sparse forests
    {'ECO_ID',80604,'FaceColor',[0.643137 0.843137 0.647059]}, ... % Kamchatka-Kurile taiga
    {'ECO_ID',80605,'FaceColor',[0.498039 0.819608 0.596078]}, ... % Northeast Siberian taiga
    {'ECO_ID',80606,'FaceColor',[0.713725 0.972549 0.898039]}, ... % Okhotsk-Manchurian taiga
    {'ECO_ID',80607,'FaceColor',[0.713725 0.725490 0.968627]}, ... % Sakhalin Island taiga
    {'ECO_ID',80608,'FaceColor',[0.109804 0.062745 0.317647]}, ... % Scandinavian and Russian taiga
    {'ECO_ID',80609,'FaceColor',[0.364706 0.470588 0.423529]}, ... % Trans-Baikal conifer forests
    {'ECO_ID',80610,'FaceColor',[0.749020 0.925490 0.698039]}, ... % Ural montane forests and tundra
    {'ECO_ID',80611,'FaceColor',[0.592157 0.764706 0.466667]}, ... % West Siberian taiga
    {'ECO_ID',80801,'FaceColor',[0.400000 0.600000 0.294118]}, ... % Alai-Western Tian Shan steppe
    {'ECO_ID',80802,'FaceColor',[0.215686 0.490196 0.211765]}, ... % Altai steppe and semi-desert
    {'ECO_ID',80803,'FaceColor',[0.698039 0.811765 0.635294]}, ... % Central Anatolian steppe
    {'ECO_ID',80804,'FaceColor',[0.674510 0.380392 0.380392]}, ... % Daurian forest steppe
    {'ECO_ID',80805,'FaceColor',[0.933333 0.564706 0.686275]}, ... % Eastern Anatolian montane steppe
    {'ECO_ID',80806,'FaceColor',[0.184314 0.070588 0.254902]}, ... % Emin Valley steppe
    {'ECO_ID',80807,'FaceColor',[0.909804 0.886275 1.000000]}, ... % Faroe Islands boreal grasslands
    {'ECO_ID',80808,'FaceColor',[0.301961 0.203922 0.290196]}, ... % Gissaro-Alai open woodlands
    {'ECO_ID',80809,'FaceColor',[0.482353 0.329412 0.407843]}, ... % Kazakh forest steppe
    {'ECO_ID',80810,'FaceColor',[0.576471 0.388235 0.549020]}, ... % Kazakh steppe
    {'ECO_ID',80811,'FaceColor',[0.501961 0.290196 0.600000]}, ... % Kazakh upland
    {'ECO_ID',80812,'FaceColor',[0.305882 0.070588 0.615686]}, ... % Middle East steppe
    {'ECO_ID',80813,'FaceColor',[0.403922 0.219608 0.709804]}, ... % Mongolian-Manchurian grassland
    {'ECO_ID',80814,'FaceColor',[0.313725 0.254902 0.396078]}, ... % Pontic steppe
    {'ECO_ID',80815,'FaceColor',[0.580392 0.521569 0.521569]}, ... % Sayan Intermontane steppe
    {'ECO_ID',80816,'FaceColor',[0.647059 0.478431 0.521569]}, ... % Selenge-Orkhon forest steppe
    {'ECO_ID',80817,'FaceColor',[0.611765 0.400000 0.474510]}, ... % South Siberian forest steppe
    {'ECO_ID',80818,'FaceColor',[0.611765 0.431373 0.537255]}, ... % Tian Shan foothill arid steppe
    {'ECO_ID',80901,'FaceColor',[0.364706 0.254902 0.309804]}, ... % Amur meadow steppe
    {'ECO_ID',80902,'FaceColor',[0.650980 0.666667 0.596078]}, ... % Bohai Sea saline meadow
    {'ECO_ID',80903,'FaceColor',[0.168627 0.200000 0.031373]}, ... % Nenjiang River grassland
    {'ECO_ID',80904,'FaceColor',[0.270588 0.227451 0.000000]}, ... % Nile Delta flooded savanna
    {'ECO_ID',80905,'FaceColor',[0.458824 0.462745 0.235294]}, ... % Saharan halophytics
    {'ECO_ID',80906,'FaceColor',[0.764706 0.933333 0.831373]}, ... % Tigris-Euphrates alluvial salt marsh
    {'ECO_ID',80907,'FaceColor',[0.466667 0.635294 0.631373]}, ... % Suiphun-Khanka meadows and forest meadows
    {'ECO_ID',80908,'FaceColor',[0.286275 0.282353 0.341176]}, ... % Yellow Sea saline meadow
    {'ECO_ID',81001,'FaceColor',[0.929412 0.776471 0.721569]}, ... % Altai alpine meadow and tundra
    {'ECO_ID',81002,'FaceColor',[1.000000 0.796078 0.435294]}, ... % Central Tibetan Plateau alpine steppe
    {'ECO_ID',81003,'FaceColor',[0.647059 0.498039 0.003922]}, ... % Eastern Himalayan alpine shrub and meadows
    {'ECO_ID',81004,'FaceColor',[0.215686 0.411765 0.000000]}, ... % Ghorat-Hazarajat alpine meadow
    {'ECO_ID',81005,'FaceColor',[0.549020 0.827451 0.454902]}, ... % Hindu Kush alpine meadow
    {'ECO_ID',81006,'FaceColor',[0.321569 0.435294 0.156863]}, ... % Karakoram-West Tibetan Plateau alpine steppe
    {'ECO_ID',81007,'FaceColor',[0.541176 0.627451 0.470588]}, ... % Khangai Mountains alpine meadow
    {'ECO_ID',81008,'FaceColor',[0.447059 0.643137 0.611765]}, ... % Kopet Dag woodlands and forest steppe
    {'ECO_ID',81009,'FaceColor',[0.325490 0.458824 0.439216]}, ... % Kuh Rud and Eastern Iran montane woodlands
    {'ECO_ID',81010,'FaceColor',[0.898039 0.788235 0.670588]}, ... % Mediterranean High Atlas juniper steppe
    {'ECO_ID',81011,'FaceColor',[0.901961 0.658824 0.509804]}, ... % North Tibetan Plateau-Kunlun Mountains alpine desert
    {'ECO_ID',81012,'FaceColor',[0.415686 0.141176 0.007843]}, ... % Northwestern Himalayan alpine shrub and meadows
    {'ECO_ID',81013,'FaceColor',[0.666667 0.384314 0.270588]}, ... % Ordos Plateau steppe
    {'ECO_ID',81014,'FaceColor',[0.690196 0.345098 0.325490]}, ... % Pamir alpine desert and tundra
    {'ECO_ID',81015,'FaceColor',[1.000000 0.862745 0.945098]}, ... % Qilian Mountains subalpine meadows
    {'ECO_ID',81016,'FaceColor',[0.741176 0.650980 1.000000]}, ... % Sayan Alpine meadows and tundra
    {'ECO_ID',81017,'FaceColor',[0.098039 0.176471 0.443137]}, ... % Southeast Tibet shrublands and meadows
    {'ECO_ID',81018,'FaceColor',[0.717647 1.000000 0.721569]}, ... % Sulaiman Range alpine meadows
    {'ECO_ID',81019,'FaceColor',[0.568627 0.780392 0.517647]}, ... % Tian Shan montane steppe and meadows
    {'ECO_ID',81020,'FaceColor',[0.294118 0.145098 0.454902]}, ... % Tibetan Plateau alpine shrublands and meadows
    {'ECO_ID',81021,'FaceColor',[0.513725 0.345098 0.721569]}, ... % Western Himalayan alpine shrub and Meadows
    {'ECO_ID',81022,'FaceColor',[0.737255 0.886275 0.819608]}, ... % Yarlung Tsangpo arid steppe
    {'ECO_ID',81101,'FaceColor',[0.647059 0.749020 0.560784]}, ... % Arctic desert
    {'ECO_ID',81102,'FaceColor',[0.517647 0.211765 0.231373]}, ... % Bering tundra
    {'ECO_ID',81103,'FaceColor',[0.843137 0.517647 0.521569]}, ... % Cherskii-Kolyma mountain tundra
    {'ECO_ID',81104,'FaceColor',[0.435294 0.490196 0.231373]}, ... % Chukchi Peninsula tundra
    {'ECO_ID',81105,'FaceColor',[0.933333 0.996078 0.745098]}, ... % Kamchatka Mountain tundra and forest tundra
    {'ECO_ID',81106,'FaceColor',[0.552941 0.243137 0.250980]}, ... % Kola Peninsula tundra
    {'ECO_ID',81107,'FaceColor',[0.329412 0.286275 0.243137]}, ... % Northeast Siberian coastal tundra
    {'ECO_ID',81108,'FaceColor',[0.541176 0.513725 0.611765]}, ... % Northwest Russian-Novaya Zemlya tundra
    {'ECO_ID',81109,'FaceColor',[0.396078 0.400000 0.780392]}, ... % Novosibirsk Islands arctic desert
    {'ECO_ID',81110,'FaceColor',[0.458824 0.419608 0.792157]}, ... % Scandinavian Montane Birch forest and grasslands
    {'ECO_ID',81111,'FaceColor',[0.356863 0.200000 0.270588]}, ... % Taimyr-Central Siberian tundra
    {'ECO_ID',81112,'FaceColor',[0.815686 0.501961 0.470588]}, ... % Trans-Baikal Bald Mountain tundra
    {'ECO_ID',81113,'FaceColor',[0.796078 0.290196 0.345098]}, ... % Wrangel Island arctic desert
    {'ECO_ID',81114,'FaceColor',[0.784314 0.301961 0.411765]}, ... % Yamal-Gydan tundra
    {'ECO_ID',81201,'FaceColor',[0.968627 0.721569 0.858824]}, ... % Aegean and Western Turkey sclerophyllous and mixed forests
    {'ECO_ID',81202,'FaceColor',[0.349020 0.200000 0.325490]}, ... % Anatolian conifer and deciduous mixed forests
    {'ECO_ID',81203,'FaceColor',[0.741176 0.541176 0.627451]}, ... % Canary Islands dry woodlands and forests
    {'ECO_ID',81204,'FaceColor',[1.000000 0.803922 0.854902]}, ... % Corsican montane broadleaf and mixed forests
    {'ECO_ID',81205,'FaceColor',[0.415686 0.250980 0.262745]}, ... % Crete Mediterranean forests
    {'ECO_ID',81206,'FaceColor',[0.639216 0.505882 0.462745]}, ... % Cyprus Mediterranean forests
    {'ECO_ID',81207,'FaceColor',[0.231373 0.125490 0.000000]}, ... % Eastern Mediterranean conifer-sclerophyllous-broadleaf forests
    {'ECO_ID',81208,'FaceColor',[0.643137 0.701961 0.521569]}, ... % Iberian conifer forests
    {'ECO_ID',81209,'FaceColor',[0.407843 0.776471 0.607843]}, ... % Iberian sclerophyllous and semi-deciduous forests
    {'ECO_ID',81210,'FaceColor',[0.019608 0.474510 0.403922]}, ... % Illyrian deciduous forests
    {'ECO_ID',81211,'FaceColor',[0.392157 0.717647 0.823529]}, ... % Italian sclerophyllous and semi-deciduous forests
    {'ECO_ID',81212,'FaceColor',[0.458824 0.717647 0.776471]}, ... % Mediterranean acacia-argania dry woodlands and succulent thickets
    {'ECO_ID',81213,'FaceColor',[0.552941 0.819608 0.600000]}, ... % Mediterranean dry woodlands and steppe
    {'ECO_ID',81214,'FaceColor',[0.662745 0.843137 0.674510]}, ... % Mediterranean woodlands and forests
    {'ECO_ID',81215,'FaceColor',[0.145098 0.129412 0.360784]}, ... % Northeastern Spain and Southern France Mediterranean forests
    {'ECO_ID',81216,'FaceColor',[0.392157 0.360784 0.619608]}, ... % Northwest Iberian montane forests
    {'ECO_ID',81217,'FaceColor',[0.172549 0.298039 0.227451]}, ... % Pindus Mountains mixed forests
    {'ECO_ID',81218,'FaceColor',[0.529412 0.588235 0.439216]}, ... % South Appenine mixed montane forests
    {'ECO_ID',81219,'FaceColor',[0.835294 0.607843 0.627451]}, ... % Southeastern Iberian shrubs and woodlands
    {'ECO_ID',81220,'FaceColor',[0.415686 0.129412 0.078431]}, ... % Southern Anatolian montane conifer and deciduous forests
    {'ECO_ID',81221,'FaceColor',[0.784314 0.658824 0.298039]}, ... % Southwest Iberian Mediterranean sclerophyllous and mixed forests
    {'ECO_ID',81222,'FaceColor',[1.000000 0.874510 0.560784]}, ... % Tyrrhenian-Adriatic Sclerophyllous and mixed forests
    {'ECO_ID',81301,'FaceColor',[0.525490 0.090196 0.192157]}, ... % Afghan Mountains semi-desert
    {'ECO_ID',81302,'FaceColor',[0.635294 0.184314 0.419608]}, ... % Alashan Plateau semi-desert
    {'ECO_ID',81303,'FaceColor',[0.850980 0.623529 0.694118]}, ... % Arabian Desert and East Sahero-Arabian xeric shrublands
    {'ECO_ID',81304,'FaceColor',[0.384314 0.305882 0.243137]}, ... % Atlantic coastal desert
    {'ECO_ID',81305,'FaceColor',[0.811765 0.807843 0.631373]}, ... % Azerbaijan shrub desert and steppe
    {'ECO_ID',81306,'FaceColor',[0.843137 0.788235 0.670588]}, ... % Badghyz and Karabil semi-desert
    {'ECO_ID',81307,'FaceColor',[0.462745 0.239216 0.349020]}, ... % Baluchistan xeric woodlands
    {'ECO_ID',81308,'FaceColor',[0.388235 0.207843 0.415686]}, ... % Caspian lowland desert
    {'ECO_ID',81309,'FaceColor',[0.431373 0.537255 0.686275]}, ... % Central Afghan Mountains xeric woodlands
    {'ECO_ID',81310,'FaceColor',[0.070588 0.290196 0.321569]}, ... % Central Asian northern desert
    {'ECO_ID',81311,'FaceColor',[0.164706 0.325490 0.184314]}, ... % Central Asian riparian woodlands
    {'ECO_ID',81312,'FaceColor',[0.286275 0.462745 0.235294]}, ... % Central Asian southern desert
    {'ECO_ID',81313,'FaceColor',[0.435294 0.690196 0.458824]}, ... % Central Persian desert basins
    {'ECO_ID',81314,'FaceColor',[0.619608 0.823529 0.556863]}, ... % Eastern Gobi desert steppe
    {'ECO_ID',81315,'FaceColor',[0.584314 0.607843 0.250980]}, ... % Gobi Lakes Valley desert steppe
    {'ECO_ID',81316,'FaceColor',[0.760784 0.592157 0.286275]}, ... % Great Lakes Basin desert steppe
    {'ECO_ID',81317,'FaceColor',[0.470588 0.094118 0.000000]}, ... % Junggar Basin semi-desert
    {'ECO_ID',81318,'FaceColor',[0.478431 0.152941 0.188235]}, ... % Kazakh semi-desert
    {'ECO_ID',81319,'FaceColor',[0.262745 0.231373 0.450980]}, ... % Kopet Dag semi-desert
    {'ECO_ID',81320,'FaceColor',[0.027451 0.180392 0.376471]}, ... % Mesopotamian shrub desert
    {'ECO_ID',81321,'FaceColor',[0.094118 0.317647 0.278431]}, ... % North Saharan steppe and woodlands
    {'ECO_ID',81322,'FaceColor',[0.282353 0.505882 0.411765]}, ... % Paropamisus xeric woodlands
    {'ECO_ID',81323,'FaceColor',[0.513725 0.678431 0.690196]}, ... % Persian Gulf desert and semi-desert
    {'ECO_ID',81324,'FaceColor',[0.250980 0.423529 0.360784]}, ... % Qaidam Basin semi-desert
    {'ECO_ID',81325,'FaceColor',[0.513725 0.756863 0.443137]}, ... % Red Sea Nubo-Sindian tropical desert and semi-desert
    {'ECO_ID',81326,'FaceColor',[0.764706 0.878431 0.639216]}, ... % Registan-North Pakistan sandy desert
    {'ECO_ID',81327,'FaceColor',[0.349020 0.137255 0.305882]}, ... % Sahara desert
    {'ECO_ID',81328,'FaceColor',[0.380392 0.180392 0.368627]}, ... % South Iran Nubo-Sindian desert and semi-desert
    {'ECO_ID',81329,'FaceColor',[0.423529 0.584314 0.392157]}, ... % South Saharan steppe and woodlands
    {'ECO_ID',81330,'FaceColor',[0.631373 0.917647 0.643137]}, ... % Taklimakan desert
    {'ECO_ID',81331,'FaceColor',[0.431373 0.611765 0.537255]}, ... % Tibesti-Jebel Uweinat montane xeric woodlands
    {'ECO_ID',81332,'FaceColor',[0.262745 0.337255 0.337255]}, ... % West Saharan montane xeric woodlands
    {'ECO_ID',81333,'FaceColor',[0.615686 0.572549 0.521569]}, ... % Red Sea coastal desert
    {'Default','FaceColor','k'}};

symbolspec = makesymbolspec('Polygon', rules{:});

