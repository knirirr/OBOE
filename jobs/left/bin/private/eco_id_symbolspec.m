% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function symbolspec = eco_id_symbolspec

% The following snippet generates content to the console.
% Run it, then cut and paste the result in here.

% e = shaperead('wwf_terr_ecos.shp','UseGeocoord',true);
% [id{1:numel(e)}] = deal(e.ECO_ID);
% [~,kid] = unique(cell2mat(id));
% n = numel(kid);
% cmap = polcmap(n);
% for i = 1:n
%     fprintf(1,'    {''ECO_ID'',%i,''FaceColor'',[%f %f %f]}, ... %% %s\n', ...
%         e(kid(i)).ECO_ID,cmap(i,:),e(kid(i)).ECO_NAME)
% end

symbolspec = makesymbolspec('Polygon', ...
    {'ECO_ID',-9999,'FaceColor',[1.000000 1.000000 1.000000]}, ... % Rock and Ice
    {'ECO_ID',-9998,'FaceColor',[1.000000 0.999000 1.000000]}, ... % Lake
    {'ECO_ID',10101,'FaceColor',[1.000000 0.613075 0.763173]}, ... % Admiralty Islands lowland rain forests
    {'ECO_ID',10102,'FaceColor',[0.672387 1.000000 0.841488]}, ... % Banda Sea Islands moist deciduous forests
    {'ECO_ID',10103,'FaceColor',[0.526171 0.572128 1.000000]}, ... % Biak-Numfoor rain forests
    {'ECO_ID',10104,'FaceColor',[1.000000 0.751808 0.658436]}, ... % Buru rain forests
    {'ECO_ID',10105,'FaceColor',[0.667744 1.000000 0.696412]}, ... % Central Range montane rain forests
    {'ECO_ID',10106,'FaceColor',[0.690935 1.000000 0.596311]}, ... % Halmahera rain forests
    {'ECO_ID',10107,'FaceColor',[0.746155 1.000000 0.700988]}, ... % Huon Peninsula montane rain forests
    {'ECO_ID',10108,'FaceColor',[1.000000 0.880099 0.668201]}, ... % Yapen rain forests
    {'ECO_ID',10109,'FaceColor',[1.000000 0.705662 0.955712]}, ... % Lord Howe Island subtropical forests
    {'ECO_ID',10110,'FaceColor',[1.000000 0.693180 0.635417]}, ... % Louisiade Archipelago rain forests
    {'ECO_ID',10111,'FaceColor',[1.000000 0.903138 0.549758]}, ... % New Britain-New Ireland lowland rain forests
    {'ECO_ID',10112,'FaceColor',[0.929717 0.641144 1.000000]}, ... % New Britain-New Ireland montane rain forests
    {'ECO_ID',10113,'FaceColor',[0.729242 1.000000 0.864562]}, ... % New Caledonia rain forests
    {'ECO_ID',10114,'FaceColor',[1.000000 0.604557 0.708053]}, ... % Norfolk Island subtropical forests
    {'ECO_ID',10115,'FaceColor',[0.611500 0.935295 1.000000]}, ... % Northern New Guinea lowland rain and freshwater swamp forests
    {'ECO_ID',10116,'FaceColor',[1.000000 0.741058 0.757737]}, ... % Northern New Guinea montane rain forests
    {'ECO_ID',10117,'FaceColor',[1.000000 0.708813 0.785585]}, ... % Queensland tropical rain forests
    {'ECO_ID',10118,'FaceColor',[0.519791 0.784854 1.000000]}, ... % Seram rain forests
    {'ECO_ID',10119,'FaceColor',[0.675511 1.000000 0.654341]}, ... % Solomon Islands rain forests
    {'ECO_ID',10120,'FaceColor',[1.000000 0.620349 0.811378]}, ... % Southeastern Papuan rain forests
    {'ECO_ID',10121,'FaceColor',[1.000000 0.670493 0.999955]}, ... % Southern New Guinea freshwater swamp forests
    {'ECO_ID',10122,'FaceColor',[0.762958 1.000000 0.616746]}, ... % Southern New Guinea lowland rain forests
    {'ECO_ID',10123,'FaceColor',[1.000000 0.579522 0.808837]}, ... % Sulawesi lowland rain forests
    {'ECO_ID',10124,'FaceColor',[0.885314 0.667187 1.000000]}, ... % Sulawesi montane rain forests
    {'ECO_ID',10125,'FaceColor',[0.698662 1.000000 0.853527]}, ... % Trobriand Islands rain forests
    {'ECO_ID',10126,'FaceColor',[0.973500 0.584065 1.000000]}, ... % Vanuatu rain forests
    {'ECO_ID',10127,'FaceColor',[0.513791 1.000000 0.665559]}, ... % Vogelkop montane rain forests
    {'ECO_ID',10128,'FaceColor',[0.716326 0.946743 1.000000]}, ... % Vogelkop-Aru lowland rain forests
    {'ECO_ID',10201,'FaceColor',[1.000000 0.760422 0.673259]}, ... % Lesser Sundas deciduous forests
    {'ECO_ID',10202,'FaceColor',[1.000000 0.564057 0.586826]}, ... % New Caledonia dry forests
    {'ECO_ID',10203,'FaceColor',[0.600615 1.000000 0.941242]}, ... % Sumba deciduous forests
    {'ECO_ID',10204,'FaceColor',[1.000000 0.736925 0.849822]}, ... % Timor and Wetar deciduous forests
    {'ECO_ID',10401,'FaceColor',[0.632607 0.596776 1.000000]}, ... % Chatham Island temperate forests
    {'ECO_ID',10402,'FaceColor',[0.688256 1.000000 0.915972]}, ... % Eastern Australian temperate forests
    {'ECO_ID',10403,'FaceColor',[1.000000 0.849129 0.661140]}, ... % Fiordland temperate forests
    {'ECO_ID',10404,'FaceColor',[1.000000 0.744265 0.775183]}, ... % Nelson Coast temperate forests
    {'ECO_ID',10405,'FaceColor',[0.704868 1.000000 0.603915]}, ... % North Island temperate forests
    {'ECO_ID',10406,'FaceColor',[0.752836 1.000000 0.728086]}, ... % Northland temperate kauri forests
    {'ECO_ID',10407,'FaceColor',[0.582470 0.760462 1.000000]}, ... % Rakiura Island temperate forests
    {'ECO_ID',10408,'FaceColor',[1.000000 0.607433 0.821372]}, ... % Richmond temperate forests
    {'ECO_ID',10409,'FaceColor',[0.520046 1.000000 0.605027]}, ... % Southeast Australia temperate forests
    {'ECO_ID',10410,'FaceColor',[0.790634 1.000000 0.682028]}, ... % South Island temperate forests
    {'ECO_ID',10411,'FaceColor',[0.547476 0.999997 1.000000]}, ... % Tasmanian Central Highland forests
    {'ECO_ID',10412,'FaceColor',[0.716534 0.924506 1.000000]}, ... % Tasmanian temperate forests
    {'ECO_ID',10413,'FaceColor',[1.000000 0.723289 0.730266]}, ... % Tasmanian temperate rain forests
    {'ECO_ID',10414,'FaceColor',[0.666955 0.549989 1.000000]}, ... % Westland temperate forests
    {'ECO_ID',10701,'FaceColor',[0.873050 0.672836 1.000000]}, ... % Arnhem Land tropical savanna
    {'ECO_ID',10702,'FaceColor',[0.795740 0.729610 1.000000]}, ... % Brigalow tropical savanna
    {'ECO_ID',10703,'FaceColor',[0.664563 0.506093 1.000000]}, ... % Cape York Peninsula tropical savanna
    {'ECO_ID',10704,'FaceColor',[0.773722 0.691511 1.000000]}, ... % Carpentaria tropical savanna
    {'ECO_ID',10705,'FaceColor',[1.000000 0.704431 0.962542]}, ... % Einasleigh upland savanna
    {'ECO_ID',10706,'FaceColor',[0.648389 1.000000 0.539717]}, ... % Kimberly tropical savanna
    {'ECO_ID',10707,'FaceColor',[1.000000 0.688487 0.981604]}, ... % Mitchell grass downs
    {'ECO_ID',10708,'FaceColor',[1.000000 0.727126 0.766844]}, ... % Trans Fly savanna and grasslands
    {'ECO_ID',10709,'FaceColor',[0.502804 0.515709 1.000000]}, ... % Victoria Plains tropical savanna
    {'ECO_ID',10801,'FaceColor',[0.635787 1.000000 0.805455]}, ... % Cantebury-Otago tussock grasslands
    {'ECO_ID',10802,'FaceColor',[0.987543 1.000000 0.609468]}, ... % Eastern Australia mulga shrublands
    {'ECO_ID',10803,'FaceColor',[0.661959 1.000000 0.903951]}, ... % Southeast Australia temperate savanna
    {'ECO_ID',11001,'FaceColor',[1.000000 0.736712 0.884792]}, ... % Australian Alps montane grasslands
    {'ECO_ID',11002,'FaceColor',[0.746763 0.968085 1.000000]}, ... % Central Range sub-alpine grasslands
    {'ECO_ID',11003,'FaceColor',[1.000000 0.517553 0.938603]}, ... % South Island montane grasslands
    {'ECO_ID',11101,'FaceColor',[0.657816 1.000000 0.639385]}, ... % Antipodes Subantarctic Islands tundra
    {'ECO_ID',11201,'FaceColor',[1.000000 0.574587 0.923635]}, ... % Coolgardie woodlands
    {'ECO_ID',11202,'FaceColor',[0.514430 0.937353 1.000000]}, ... % Esperance mallee
    {'ECO_ID',11203,'FaceColor',[1.000000 0.745870 0.876329]}, ... % Eyre and York mallee
    {'ECO_ID',11204,'FaceColor',[0.788114 1.000000 0.684977]}, ... % Jarrah-Karri forest and shrublands
    {'ECO_ID',11205,'FaceColor',[1.000000 0.630750 0.794184]}, ... % Swan Coastal Plain Scrub and Woodlands
    {'ECO_ID',11206,'FaceColor',[1.000000 0.607973 0.934955]}, ... % Mount Lofty woodlands
    {'ECO_ID',11207,'FaceColor',[0.611648 1.000000 0.560260]}, ... % Murray-Darling woodlands and mallee
    {'ECO_ID',11208,'FaceColor',[1.000000 0.921710 0.687146]}, ... % Naracoorte woodlands
    {'ECO_ID',11209,'FaceColor',[0.654327 0.649089 1.000000]}, ... % Southwest Australia savanna
    {'ECO_ID',11210,'FaceColor',[0.919754 0.730669 1.000000]}, ... % Southwest Australia woodlands
    {'ECO_ID',11301,'FaceColor',[0.699516 1.000000 0.794154]}, ... % Carnarvon xeric shrublands
    {'ECO_ID',11302,'FaceColor',[0.527629 1.000000 0.679911]}, ... % Central Ranges xeric scrub
    {'ECO_ID',11303,'FaceColor',[1.000000 0.585508 0.954393]}, ... % Gibson desert
    {'ECO_ID',11304,'FaceColor',[0.591308 1.000000 0.875122]}, ... % Great Sandy-Tanami desert
    {'ECO_ID',11305,'FaceColor',[0.992762 0.746069 1.000000]}, ... % Great Victoria desert
    {'ECO_ID',11306,'FaceColor',[1.000000 0.703852 0.995990]}, ... % Nullarbor Plains xeric shrublands
    {'ECO_ID',11307,'FaceColor',[1.000000 0.743776 0.908894]}, ... % Pilbara shrublands
    {'ECO_ID',11308,'FaceColor',[0.779559 0.551344 1.000000]}, ... % Simpson desert
    {'ECO_ID',11309,'FaceColor',[0.690188 0.674651 1.000000]}, ... % Tirari-Sturt stony desert
    {'ECO_ID',11310,'FaceColor',[1.000000 0.896569 0.628380]}, ... % Western Australian Mulga shrublands
    {'ECO_ID',11401,'FaceColor',[1.000000 0.692840 0.626715]}, ... % New Guinea mangroves
    {'ECO_ID',21101,'FaceColor',[0.734935 0.819363 1.000000]}, ... % Marielandia Antarctic tundra
    {'ECO_ID',21102,'FaceColor',[0.739453 0.571483 1.000000]}, ... % Maudlandia Antarctic desert
    {'ECO_ID',21103,'FaceColor',[1.000000 0.749891 0.821189]}, ... % Scotia Sea Islands tundra
    {'ECO_ID',21104,'FaceColor',[0.570527 0.674335 1.000000]}, ... % Southern Indian Ocean Islands tundra
    {'ECO_ID',30101,'FaceColor',[0.634810 1.000000 0.931711]}, ... % Albertine Rift montane forests
    {'ECO_ID',30102,'FaceColor',[0.574197 1.000000 0.964555]}, ... % Atlantic Equatorial coastal forests
    {'ECO_ID',30103,'FaceColor',[1.000000 0.552799 0.911527]}, ... % Cameroonian Highlands forests
    {'ECO_ID',30104,'FaceColor',[0.976381 0.747833 1.000000]}, ... % Central Congolian lowland forests
    {'ECO_ID',30105,'FaceColor',[0.687364 0.796691 1.000000]}, ... % Comoros forests
    {'ECO_ID',30106,'FaceColor',[0.726698 0.888143 1.000000]}, ... % Cross-Niger transition forests
    {'ECO_ID',30107,'FaceColor',[0.553847 0.981387 1.000000]}, ... % Cross-Sanaga-Bioko coastal forests
    {'ECO_ID',30108,'FaceColor',[1.000000 0.745995 0.951748]}, ... % East African montane forests
    {'ECO_ID',30109,'FaceColor',[0.556487 0.541334 1.000000]}, ... % Eastern Arc forests
    {'ECO_ID',30110,'FaceColor',[0.804475 1.000000 0.732707]}, ... % Eastern Congolian swamp forests
    {'ECO_ID',30111,'FaceColor',[1.000000 0.702481 0.870550]}, ... % Eastern Guinean forests
    {'ECO_ID',30112,'FaceColor',[1.000000 0.826779 0.730714]}, ... % Ethiopian montane forests
    {'ECO_ID',30113,'FaceColor',[0.562296 0.925157 1.000000]}, ... % Granitic Seychelles forests
    {'ECO_ID',30114,'FaceColor',[0.713509 0.985833 1.000000]}, ... % Guinean montane forests
    {'ECO_ID',30115,'FaceColor',[0.652462 1.000000 0.974908]}, ... % Knysna-Amatole montane forests
    {'ECO_ID',30116,'FaceColor',[1.000000 0.635224 0.964121]}, ... % KwaZulu-Cape coastal forest mosaic
    {'ECO_ID',30117,'FaceColor',[1.000000 0.700246 0.909258]}, ... % Madagascar lowland forests
    {'ECO_ID',30118,'FaceColor',[1.000000 0.669083 0.805148]}, ... % Madagascar subhumid forests
    {'ECO_ID',30119,'FaceColor',[1.000000 0.952480 0.510427]}, ... % Maputaland coastal forest mosaic
    {'ECO_ID',30120,'FaceColor',[1.000000 0.764808 0.710507]}, ... % Mascarene forests
    {'ECO_ID',30121,'FaceColor',[0.924693 1.000000 0.571008]}, ... % Mount Cameroon and Bioko montane forests
    {'ECO_ID',30122,'FaceColor',[0.691265 0.746269 1.000000]}, ... % Niger Delta swamp forests
    {'ECO_ID',30123,'FaceColor',[0.775876 0.547205 1.000000]}, ... % Nigerian lowland forests
    {'ECO_ID',30124,'FaceColor',[0.619506 1.000000 0.553937]}, ... % Northeastern Congolian lowland forests
    {'ECO_ID',30125,'FaceColor',[0.564287 1.000000 0.805687]}, ... % Northern Zanzibar-Inhambane coastal forest mosaic
    {'ECO_ID',30126,'FaceColor',[0.564360 0.667081 1.000000]}, ... % Northwestern Congolian lowland forests
    {'ECO_ID',30127,'FaceColor',[0.728410 0.798293 1.000000]}, ... % Sao Tome, Principe and Annobon moist lowland forests
    {'ECO_ID',30128,'FaceColor',[0.673921 0.827534 1.000000]}, ... % Southern Zanzibar-Inhambane coastal forest mosaic
    {'ECO_ID',30129,'FaceColor',[0.692087 1.000000 0.635533]}, ... % Western Congolian swamp forests
    {'ECO_ID',30130,'FaceColor',[0.632604 1.000000 0.613931]}, ... % Western Guinean lowland forests
    {'ECO_ID',30201,'FaceColor',[1.000000 0.643763 0.762611]}, ... % Cape Verde Islands dry forests
    {'ECO_ID',30202,'FaceColor',[1.000000 0.693813 0.936541]}, ... % Madagascar dry deciduous forests
    {'ECO_ID',30203,'FaceColor',[0.660905 0.729124 1.000000]}, ... % Zambezian Cryptosepalum dry forests
    {'ECO_ID',30701,'FaceColor',[0.728039 0.907788 1.000000]}, ... % Angolan Miombo woodlands
    {'ECO_ID',30702,'FaceColor',[0.644903 1.000000 0.722528]}, ... % Angolan Mopane woodlands
    {'ECO_ID',30703,'FaceColor',[0.736375 0.950668 1.000000]}, ... % Ascension scrub and grasslands
    {'ECO_ID',30704,'FaceColor',[0.586619 0.500400 1.000000]}, ... % Central Zambezian Miombo woodlands
    {'ECO_ID',30705,'FaceColor',[0.825319 0.702551 1.000000]}, ... % East Sudanian savanna
    {'ECO_ID',30706,'FaceColor',[0.682753 0.728336 1.000000]}, ... % Eastern Miombo woodlands
    {'ECO_ID',30707,'FaceColor',[0.895843 0.722756 1.000000]}, ... % Guinean forest-savanna mosaic
    {'ECO_ID',30708,'FaceColor',[0.830511 1.000000 0.512383]}, ... % Itigi-Sumbu thicket
    {'ECO_ID',30709,'FaceColor',[0.585635 1.000000 0.830516]}, ... % Kalahari Acacia-Baikiaea woodlands
    {'ECO_ID',30710,'FaceColor',[0.679366 1.000000 0.530776]}, ... % Mandara Plateau mosaic
    {'ECO_ID',30711,'FaceColor',[0.975817 0.521944 1.000000]}, ... % Northern Acacia-Commiphora bushlands and thickets
    {'ECO_ID',30712,'FaceColor',[0.742774 0.895583 1.000000]}, ... % Northern Congolian forest-savanna mosaic
    {'ECO_ID',30713,'FaceColor',[0.878425 0.635683 1.000000]}, ... % Sahelian Acacia savanna
    {'ECO_ID',30714,'FaceColor',[0.643758 1.000000 0.791662]}, ... % Serengeti volcanic grasslands
    {'ECO_ID',30715,'FaceColor',[0.670303 0.628117 1.000000]}, ... % Somali Acacia-Commiphora bushlands and thickets
    {'ECO_ID',30716,'FaceColor',[0.991022 0.522970 1.000000]}, ... % Southern Acacia-Commiphora bushlands and thickets
    {'ECO_ID',30717,'FaceColor',[0.936036 0.524327 1.000000]}, ... % Southern Africa bushveld
    {'ECO_ID',30718,'FaceColor',[1.000000 0.592689 0.975962]}, ... % Southern Congolian forest-savanna mosaic
    {'ECO_ID',30719,'FaceColor',[0.533673 1.000000 0.575752]}, ... % Southern Miombo woodlands
    {'ECO_ID',30720,'FaceColor',[1.000000 0.583178 0.736262]}, ... % St. Helena scrub and woodlands
    {'ECO_ID',30721,'FaceColor',[1.000000 0.809417 0.662177]}, ... % Victoria Basin forest-savanna mosaic
    {'ECO_ID',30722,'FaceColor',[0.954412 1.000000 0.693955]}, ... % West Sudanian savanna
    {'ECO_ID',30723,'FaceColor',[0.707246 0.913390 1.000000]}, ... % Western Congolian forest-savanna mosaic
    {'ECO_ID',30724,'FaceColor',[0.748988 1.000000 0.959439]}, ... % Western Zambezian grasslands
    {'ECO_ID',30725,'FaceColor',[1.000000 0.797466 0.627825]}, ... % Zambezian and Mopane woodlands
    {'ECO_ID',30726,'FaceColor',[1.000000 0.691294 0.629842]}, ... % Zambezian Baikiaea woodlands
    {'ECO_ID',30801,'FaceColor',[1.000000 0.779626 0.680660]}, ... % Al Hajar montane woodlands
    {'ECO_ID',30802,'FaceColor',[0.558255 1.000000 0.719828]}, ... % Amsterdam and Saint-Paul Islands temperate grasslands
    {'ECO_ID',30803,'FaceColor',[1.000000 0.561148 0.634137]}, ... % Tristan Da Cunha-Gough Islands shrub and grasslands
    {'ECO_ID',30901,'FaceColor',[0.675053 1.000000 0.723013]}, ... % East African halophytics
    {'ECO_ID',30902,'FaceColor',[0.629093 0.933675 1.000000]}, ... % Etosha Pan halophytics
    {'ECO_ID',30903,'FaceColor',[0.834285 0.650193 1.000000]}, ... % Inner Niger Delta flooded savanna
    {'ECO_ID',30904,'FaceColor',[0.655335 1.000000 0.712946]}, ... % Lake Chad flooded savanna
    {'ECO_ID',30905,'FaceColor',[0.889229 1.000000 0.623014]}, ... % Saharan flooded grasslands
    {'ECO_ID',30906,'FaceColor',[1.000000 0.596791 0.558080]}, ... % Zambezian coastal flooded savanna
    {'ECO_ID',30907,'FaceColor',[0.663880 0.653291 1.000000]}, ... % Zambezian flooded grasslands
    {'ECO_ID',30908,'FaceColor',[0.958752 1.000000 0.589354]}, ... % Zambezian halophytics
    {'ECO_ID',31001,'FaceColor',[0.673310 0.928872 1.000000]}, ... % Angolan montane forest-grassland mosaic
    {'ECO_ID',31002,'FaceColor',[0.796003 1.000000 0.646859]}, ... % Angolan scarp savanna and woodlands
    {'ECO_ID',31003,'FaceColor',[0.730330 1.000000 0.719695]}, ... % Drakensberg alti-montane grasslands and woodlands
    {'ECO_ID',31004,'FaceColor',[1.000000 0.570501 0.627047]}, ... % Drakensberg montane grasslands, woodlands and forests
    {'ECO_ID',31005,'FaceColor',[0.925118 1.000000 0.619298]}, ... % East African montane moorlands
    {'ECO_ID',31006,'FaceColor',[0.935853 0.653351 1.000000]}, ... % Eastern Zimbabwe montane forest-grassland mosaic
    {'ECO_ID',31007,'FaceColor',[0.624155 1.000000 0.904096]}, ... % Ethiopian montane grasslands and woodlands
    {'ECO_ID',31008,'FaceColor',[0.732255 0.883596 1.000000]}, ... % Ethiopian montane moorlands
    {'ECO_ID',31009,'FaceColor',[0.954127 1.000000 0.600995]}, ... % Highveld grasslands
    {'ECO_ID',31010,'FaceColor',[1.000000 0.883973 0.591096]}, ... % Jos Plateau forest-grassland mosaic
    {'ECO_ID',31011,'FaceColor',[0.810903 1.000000 0.664855]}, ... % Madagascar ericoid thickets
    {'ECO_ID',31012,'FaceColor',[0.692967 0.782619 1.000000]}, ... % Maputaland-Pondoland bushland and thickets
    {'ECO_ID',31013,'FaceColor',[0.658543 1.000000 0.993872]}, ... % Rwenzori-Virunga montane moorlands
    {'ECO_ID',31014,'FaceColor',[1.000000 0.740741 0.759089]}, ... % South Malawi montane forest-grassland mosaic
    {'ECO_ID',31015,'FaceColor',[1.000000 0.958247 0.705136]}, ... % Southern Rift montane forest-grassland mosaic
    {'ECO_ID',31201,'FaceColor',[0.720413 1.000000 0.755074]}, ... % Albany thickets
    {'ECO_ID',31202,'FaceColor',[0.576790 0.926637 1.000000]}, ... % Lowland fynbos and renosterveld
    {'ECO_ID',31203,'FaceColor',[0.616542 0.568962 1.000000]}, ... % Montane fynbos and renosterveld
    {'ECO_ID',31301,'FaceColor',[0.749925 0.976256 1.000000]}, ... % Aldabra Island xeric scrub
    {'ECO_ID',31302,'FaceColor',[1.000000 0.810286 0.583535]}, ... % Arabian Peninsula coastal fog desert
    {'ECO_ID',31303,'FaceColor',[1.000000 0.512537 0.632766]}, ... % East Saharan montane xeric woodlands
    {'ECO_ID',31304,'FaceColor',[0.584006 1.000000 0.865944]}, ... % Eritrean coastal desert
    {'ECO_ID',31305,'FaceColor',[0.753471 1.000000 0.743878]}, ... % Ethiopian xeric grasslands and shrublands
    {'ECO_ID',31306,'FaceColor',[1.000000 0.794580 0.737443]}, ... % Gulf of Oman desert and semi-desert
    {'ECO_ID',31307,'FaceColor',[0.644351 0.971570 1.000000]}, ... % Hobyo grasslands and shrublands
    {'ECO_ID',31308,'FaceColor',[0.951897 0.713919 1.000000]}, ... % Ile Europa and Bassas da India xeric scrub
    {'ECO_ID',31309,'FaceColor',[1.000000 0.666871 0.794820]}, ... % Kalahari xeric savanna
    {'ECO_ID',31310,'FaceColor',[0.680533 1.000000 0.970764]}, ... % Kaokoveld desert
    {'ECO_ID',31311,'FaceColor',[0.507607 1.000000 0.910926]}, ... % Madagascar spiny thickets
    {'ECO_ID',31312,'FaceColor',[1.000000 0.683545 0.979164]}, ... % Madagascar succulent woodlands
    {'ECO_ID',31313,'FaceColor',[1.000000 0.904355 0.649034]}, ... % Masai xeric grasslands and shrublands
    {'ECO_ID',31314,'FaceColor',[1.000000 0.970697 0.682943]}, ... % Nama Karoo
    {'ECO_ID',31315,'FaceColor',[0.554908 0.560508 1.000000]}, ... % Namib desert
    {'ECO_ID',31316,'FaceColor',[0.959085 0.572405 1.000000]}, ... % Namibian savanna woodlands
    {'ECO_ID',31318,'FaceColor',[0.947209 0.560595 1.000000]}, ... % Socotra Island xeric shrublands
    {'ECO_ID',31319,'FaceColor',[1.000000 0.691342 0.927436]}, ... % Somali montane xeric woodlands
    {'ECO_ID',31320,'FaceColor',[0.643192 1.000000 0.809945]}, ... % Southwestern Arabian foothills savanna
    {'ECO_ID',31321,'FaceColor',[1.000000 0.912720 0.711320]}, ... % Southwestern Arabian montane woodlands
    {'ECO_ID',31322,'FaceColor',[1.000000 0.785191 0.745553]}, ... % Succulent Karoo
    {'ECO_ID',31401,'FaceColor',[1.000000 0.938213 0.609956]}, ... % Central African mangroves
    {'ECO_ID',31402,'FaceColor',[0.671847 0.650316 1.000000]}, ... % East African mangroves
    {'ECO_ID',31403,'FaceColor',[1.000000 0.705237 0.985798]}, ... % Guinean mangroves
    {'ECO_ID',31404,'FaceColor',[0.553704 0.720591 1.000000]}, ... % Madagascar mangroves
    {'ECO_ID',31405,'FaceColor',[0.992954 1.000000 0.672592]}, ... % Southern Africa mangroves
    {'ECO_ID',40101,'FaceColor',[0.618307 0.844615 1.000000]}, ... % Andaman Islands rain forests
    {'ECO_ID',40102,'FaceColor',[1.000000 0.672486 0.977438]}, ... % Borneo lowland rain forests
    {'ECO_ID',40103,'FaceColor',[0.530933 1.000000 0.683768]}, ... % Borneo montane rain forests
    {'ECO_ID',40104,'FaceColor',[0.728984 0.814079 1.000000]}, ... % Borneo peat swamp forests
    {'ECO_ID',40105,'FaceColor',[0.630466 0.974633 1.000000]}, ... % Brahmaputra Valley semi-evergreen forests
    {'ECO_ID',40106,'FaceColor',[0.720663 1.000000 0.869386]}, ... % Cardamom Mountains rain forests
    {'ECO_ID',40107,'FaceColor',[1.000000 0.829666 0.572246]}, ... % Chao Phraya freshwater swamp forests
    {'ECO_ID',40108,'FaceColor',[0.866516 0.613258 1.000000]}, ... % Chao Phraya lowland moist deciduous forests
    {'ECO_ID',40109,'FaceColor',[0.723917 1.000000 0.512773]}, ... % Chin Hills-Arakan Yoma montane forests
    {'ECO_ID',40110,'FaceColor',[1.000000 0.721364 0.581045]}, ... % Christmas and Cocos Islands tropical forests
    {'ECO_ID',40111,'FaceColor',[0.680765 1.000000 0.736408]}, ... % Eastern highlands moist deciduous forests
    {'ECO_ID',40112,'FaceColor',[0.916298 1.000000 0.633545]}, ... % Eastern Java-Bali montane rain forests
    {'ECO_ID',40113,'FaceColor',[0.627241 0.584324 1.000000]}, ... % Eastern Java-Bali rain forests
    {'ECO_ID',40114,'FaceColor',[1.000000 0.889863 0.594613]}, ... % Greater Negros-Panay rain forests
    {'ECO_ID',40115,'FaceColor',[0.725850 1.000000 0.994261]}, ... % Himalayan subtropical broadleaf forests
    {'ECO_ID',40116,'FaceColor',[0.564732 0.598120 1.000000]}, ... % Irrawaddy freshwater swamp forests
    {'ECO_ID',40117,'FaceColor',[0.536382 0.912738 1.000000]}, ... % Irrawaddy moist deciduous forests
    {'ECO_ID',40118,'FaceColor',[1.000000 0.580728 0.694251]}, ... % Jian Nan subtropical evergreen forests
    {'ECO_ID',40119,'FaceColor',[0.687646 0.572876 1.000000]}, ... % Kayah-Karen montane rain forests
    {'ECO_ID',40120,'FaceColor',[1.000000 0.725826 0.974438]}, ... % Lower Gangetic Plains moist deciduous forests
    {'ECO_ID',40121,'FaceColor',[0.653534 1.000000 0.926351]}, ... % Luang Prabang montane rain forests
    {'ECO_ID',40122,'FaceColor',[0.997760 0.736443 1.000000]}, ... % Luzon montane rain forests
    {'ECO_ID',40123,'FaceColor',[0.552610 0.860317 1.000000]}, ... % Luzon rain forests
    {'ECO_ID',40124,'FaceColor',[0.703568 1.000000 0.757382]}, ... % Malabar Coast moist forests
    {'ECO_ID',40125,'FaceColor',[0.685124 0.664262 1.000000]}, ... % Maldives-Lakshadweep-Chagos Archipelago tropical moist forests
    {'ECO_ID',40126,'FaceColor',[0.890343 0.729920 1.000000]}, ... % Meghalaya subtropical forests
    {'ECO_ID',40127,'FaceColor',[0.545336 1.000000 0.897160]}, ... % Mentawai Islands rain forests
    {'ECO_ID',40128,'FaceColor',[0.709790 0.796470 1.000000]}, ... % Mindanao montane rain forests
    {'ECO_ID',40129,'FaceColor',[0.923577 1.000000 0.554877]}, ... % Mindanao-Eastern Visayas rain forests
    {'ECO_ID',40130,'FaceColor',[0.536484 0.507473 1.000000]}, ... % Mindoro rain forests
    {'ECO_ID',40131,'FaceColor',[0.938318 1.000000 0.655958]}, ... % Mizoram-Manipur-Kachin rain forests
    {'ECO_ID',40132,'FaceColor',[0.549069 0.820883 1.000000]}, ... % Myanmar coastal rain forests
    {'ECO_ID',40133,'FaceColor',[1.000000 0.712692 0.797202]}, ... % Nicobar Islands rain forests
    {'ECO_ID',40134,'FaceColor',[1.000000 0.529765 0.635969]}, ... % North Western Ghats moist deciduous forests
    {'ECO_ID',40135,'FaceColor',[0.882306 0.626094 1.000000]}, ... % North Western Ghats montane rain forests
    {'ECO_ID',40136,'FaceColor',[0.892654 0.711058 1.000000]}, ... % Northern Annamites rain forests
    {'ECO_ID',40137,'FaceColor',[0.579891 1.000000 0.997231]}, ... % Northern Indochina subtropical forests
    {'ECO_ID',40138,'FaceColor',[1.000000 0.866876 0.596070]}, ... % Northern Khorat Plateau moist deciduous forests
    {'ECO_ID',40139,'FaceColor',[1.000000 0.598296 0.802141]}, ... % Northern Thailand-Laos moist deciduous forests
    {'ECO_ID',40140,'FaceColor',[1.000000 0.557231 0.941702]}, ... % Northern Triangle subtropical forests
    {'ECO_ID',40141,'FaceColor',[0.946138 1.000000 0.681651]}, ... % Northern Vietnam lowland rain forests
    {'ECO_ID',40142,'FaceColor',[0.506212 1.000000 0.641798]}, ... % Orissa semi-evergreen forests
    {'ECO_ID',40143,'FaceColor',[0.928297 1.000000 0.636658]}, ... % Palawan rain forests
    {'ECO_ID',40144,'FaceColor',[0.642581 0.714336 1.000000]}, ... % Peninsular Malaysian montane rain forests
    {'ECO_ID',40145,'FaceColor',[1.000000 0.874771 0.625193]}, ... % Peninsular Malaysian peat swamp forests
    {'ECO_ID',40146,'FaceColor',[1.000000 0.735568 0.781750]}, ... % Peninsular Malaysian rain forests
    {'ECO_ID',40147,'FaceColor',[1.000000 0.639317 0.761986]}, ... % Red River freshwater swamp forests
    {'ECO_ID',40148,'FaceColor',[0.690917 0.733204 1.000000]}, ... % South China Sea Islands
    {'ECO_ID',40149,'FaceColor',[0.700296 1.000000 0.871494]}, ... % South China-Vietnam subtropical evergreen forests
    {'ECO_ID',40150,'FaceColor',[1.000000 0.622031 0.993636]}, ... % South Western Ghats moist deciduous forests
    {'ECO_ID',40151,'FaceColor',[1.000000 0.945763 0.590197]}, ... % South Western Ghats montane rain forests
    {'ECO_ID',40152,'FaceColor',[1.000000 0.999228 0.715770]}, ... % Southern Annamites montane rain forests
    {'ECO_ID',40153,'FaceColor',[1.000000 0.684097 0.846199]}, ... % Southwest Borneo freshwater swamp forests
    {'ECO_ID',40154,'FaceColor',[0.570407 1.000000 0.952109]}, ... % Sri Lanka lowland rain forests
    {'ECO_ID',40155,'FaceColor',[0.624788 1.000000 0.773001]}, ... % Sri Lanka montane rain forests
    {'ECO_ID',40156,'FaceColor',[0.709643 0.965159 1.000000]}, ... % Sulu Archipelago rain forests
    {'ECO_ID',40157,'FaceColor',[1.000000 0.659309 0.828933]}, ... % Sumatran freshwater swamp forests
    {'ECO_ID',40158,'FaceColor',[0.719824 0.721015 1.000000]}, ... % Sumatran lowland rain forests
    {'ECO_ID',40159,'FaceColor',[1.000000 0.828228 0.570172]}, ... % Sumatran montane rain forests
    {'ECO_ID',40160,'FaceColor',[1.000000 0.681857 0.817469]}, ... % Sumatran peat swamp forests
    {'ECO_ID',40161,'FaceColor',[0.850640 1.000000 0.580225]}, ... % Sundaland heath forests
    {'ECO_ID',40162,'FaceColor',[0.986714 0.580795 1.000000]}, ... % Sundarbans freshwater swamp forests
    {'ECO_ID',40163,'FaceColor',[1.000000 0.684713 0.827495]}, ... % Tenasserim-South Thailand semi-evergreen rain forests
    {'ECO_ID',40164,'FaceColor',[0.949263 0.629280 1.000000]}, ... % Tonle Sap freshwater swamp forests
    {'ECO_ID',40165,'FaceColor',[0.754307 0.629379 1.000000]}, ... % Tonle Sap-Mekong peat swamp forests
    {'ECO_ID',40166,'FaceColor',[1.000000 0.949279 0.648353]}, ... % Upper Gangetic Plains moist deciduous forests
    {'ECO_ID',40167,'FaceColor',[0.697299 0.532723 1.000000]}, ... % Western Java montane rain forests
    {'ECO_ID',40168,'FaceColor',[0.826400 0.531288 1.000000]}, ... % Western Java rain forests
    {'ECO_ID',40169,'FaceColor',[0.697933 0.658821 1.000000]}, ... % Hainan Island monsoon rain forests
    {'ECO_ID',40170,'FaceColor',[1.000000 0.603810 0.730575]}, ... % Nansei Islands subtropical evergreen forests
    {'ECO_ID',40171,'FaceColor',[0.679651 0.548637 1.000000]}, ... % South Taiwan monsoon rain forests
    {'ECO_ID',40172,'FaceColor',[0.793556 1.000000 0.563193]}, ... % Taiwan subtropical evergreen forests
    {'ECO_ID',40201,'FaceColor',[0.966647 1.000000 0.699161]}, ... % Central Deccan Plateau dry deciduous forests
    {'ECO_ID',40202,'FaceColor',[0.832659 1.000000 0.703950]}, ... % Central Indochina dry forests
    {'ECO_ID',40203,'FaceColor',[1.000000 0.835228 0.688434]}, ... % Chhota-Nagpur dry deciduous forests
    {'ECO_ID',40204,'FaceColor',[1.000000 0.618917 0.531722]}, ... % East Deccan dry-evergreen forests
    {'ECO_ID',40205,'FaceColor',[0.641776 1.000000 0.965559]}, ... % Irrawaddy dry forests
    {'ECO_ID',40206,'FaceColor',[0.675984 1.000000 0.819450]}, ... % Khathiar-Gir dry deciduous forests
    {'ECO_ID',40207,'FaceColor',[0.641475 1.000000 0.932602]}, ... % Narmada Valley dry deciduous forests
    {'ECO_ID',40208,'FaceColor',[0.603117 0.695324 1.000000]}, ... % Northern dry deciduous forests
    {'ECO_ID',40209,'FaceColor',[0.675784 1.000000 0.571263]}, ... % South Deccan Plateau dry deciduous forests
    {'ECO_ID',40210,'FaceColor',[1.000000 0.891830 0.705479]}, ... % Southeastern Indochina dry evergreen forests
    {'ECO_ID',40211,'FaceColor',[0.527547 0.907304 1.000000]}, ... % Southern Vietnam lowland dry forests
    {'ECO_ID',40212,'FaceColor',[1.000000 0.661386 0.834870]}, ... % Sri Lanka dry-zone dry evergreen forests
    {'ECO_ID',40301,'FaceColor',[0.524652 0.682484 1.000000]}, ... % Himalayan subtropical pine forests
    {'ECO_ID',40302,'FaceColor',[1.000000 0.606665 0.881875]}, ... % Luzon tropical pine forests
    {'ECO_ID',40303,'FaceColor',[0.660062 1.000000 0.637136]}, ... % Northeast India-Myanmar pine forests
    {'ECO_ID',40304,'FaceColor',[0.873249 1.000000 0.630316]}, ... % Sumatran tropical pine forests
    {'ECO_ID',40401,'FaceColor',[0.730251 0.565829 1.000000]}, ... % Eastern Himalayan broadleaf forests
    {'ECO_ID',40402,'FaceColor',[0.603468 1.000000 0.647202]}, ... % Northern Triangle temperate forests
    {'ECO_ID',40403,'FaceColor',[0.568326 1.000000 0.677366]}, ... % Western Himalayan broadleaf forests
    {'ECO_ID',40501,'FaceColor',[0.737780 1.000000 0.651918]}, ... % Eastern Himalayan subalpine conifer forests
    {'ECO_ID',40502,'FaceColor',[0.528461 1.000000 0.536882]}, ... % Western Himalayan subalpine conifer forests
    {'ECO_ID',40701,'FaceColor',[1.000000 0.509932 0.995908]}, ... % Terai-Duar savanna and grasslands
    {'ECO_ID',40901,'FaceColor',[1.000000 0.605496 0.768910]}, ... % Rann of Kutch seasonal salt marsh
    {'ECO_ID',41001,'FaceColor',[0.668816 0.681278 1.000000]}, ... % Kinabalu montane alpine meadows
    {'ECO_ID',41301,'FaceColor',[0.948579 0.739439 1.000000]}, ... % Deccan thorn scrub forests
    {'ECO_ID',41302,'FaceColor',[0.742036 1.000000 0.650860]}, ... % Indus Valley desert
    {'ECO_ID',41303,'FaceColor',[1.000000 0.567455 0.619054]}, ... % Northwestern thorn scrub forests
    {'ECO_ID',41304,'FaceColor',[1.000000 0.598257 0.755754]}, ... % Thar desert
    {'ECO_ID',41401,'FaceColor',[0.777677 1.000000 0.570253]}, ... % Goadavari-Krishna mangroves
    {'ECO_ID',41402,'FaceColor',[0.753580 0.687251 1.000000]}, ... % Indochina mangroves
    {'ECO_ID',41403,'FaceColor',[0.904350 1.000000 0.736665]}, ... % Indus River Delta-Arabian Sea mangroves
    {'ECO_ID',41404,'FaceColor',[0.655047 0.560236 1.000000]}, ... % Myanmar Coast mangroves
    {'ECO_ID',41405,'FaceColor',[0.553517 1.000000 0.658141]}, ... % Sunda Shelf mangroves
    {'ECO_ID',41406,'FaceColor',[0.887780 0.728842 1.000000]}, ... % Sundarbans mangroves
    {'ECO_ID',50201,'FaceColor',[0.558462 0.791197 1.000000]}, ... % Sonoran-Sinaloan transition subtropical dry forest
    {'ECO_ID',50301,'FaceColor',[0.555037 1.000000 0.590514]}, ... % Bermuda subtropical conifer forests
    {'ECO_ID',50302,'FaceColor',[0.552075 0.602524 1.000000]}, ... % Sierra Madre Occidental pine-oak forests
    {'ECO_ID',50303,'FaceColor',[0.882345 0.546380 1.000000]}, ... % Sierra Madre Oriental pine-oak forests
    {'ECO_ID',50401,'FaceColor',[0.886203 1.000000 0.601985]}, ... % Allegheny Highlands forests
    {'ECO_ID',50402,'FaceColor',[1.000000 0.625122 0.705608]}, ... % Appalachian mixed mesophytic forests
    {'ECO_ID',50403,'FaceColor',[0.957883 1.000000 0.604924]}, ... % Appalachian-Blue Ridge forests
    {'ECO_ID',50404,'FaceColor',[0.755592 0.718836 1.000000]}, ... % Central U.S. hardwood forests
    {'ECO_ID',50405,'FaceColor',[1.000000 0.552255 0.880421]}, ... % East Central Texas forests
    {'ECO_ID',50406,'FaceColor',[1.000000 0.683113 0.758249]}, ... % Eastern forest-boreal transition
    {'ECO_ID',50407,'FaceColor',[0.554910 1.000000 0.861260]}, ... % Eastern Great Lakes lowland forests
    {'ECO_ID',50408,'FaceColor',[0.533345 0.551562 1.000000]}, ... % Gulf of St. Lawrence lowland forests
    {'ECO_ID',50409,'FaceColor',[0.969514 1.000000 0.548039]}, ... % Mississippi lowland forests
    {'ECO_ID',50410,'FaceColor',[0.664677 0.858755 1.000000]}, ... % New England-Acadian forests
    {'ECO_ID',50411,'FaceColor',[1.000000 0.695822 0.923290]}, ... % Northeastern coastal forests
    {'ECO_ID',50412,'FaceColor',[0.963001 1.000000 0.723423]}, ... % Ozark Mountain forests
    {'ECO_ID',50413,'FaceColor',[0.549141 0.944183 1.000000]}, ... % Southeastern mixed forests
    {'ECO_ID',50414,'FaceColor',[0.621947 1.000000 0.802441]}, ... % Southern Great Lakes forests
    {'ECO_ID',50415,'FaceColor',[0.638163 1.000000 0.762837]}, ... % Upper Midwest forest-savanna transition
    {'ECO_ID',50416,'FaceColor',[0.603815 1.000000 0.906965]}, ... % Western Great Lakes forests
    {'ECO_ID',50417,'FaceColor',[1.000000 0.671875 0.983080]}, ... % Willamette Valley forests
    {'ECO_ID',50501,'FaceColor',[1.000000 0.889527 0.698974]}, ... % Alberta Mountain forests
    {'ECO_ID',50502,'FaceColor',[0.590564 0.794100 1.000000]}, ... % Alberta-British Columbia foothills forests
    {'ECO_ID',50503,'FaceColor',[0.628628 1.000000 0.816480]}, ... % Arizona Mountains forests
    {'ECO_ID',50504,'FaceColor',[0.802826 1.000000 0.724335]}, ... % Atlantic coastal pine barrens
    {'ECO_ID',50505,'FaceColor',[1.000000 0.734157 0.968820]}, ... % Blue Mountains forests
    {'ECO_ID',50506,'FaceColor',[0.596278 1.000000 0.569475]}, ... % British Columbia mainland coastal forests
    {'ECO_ID',50507,'FaceColor',[1.000000 0.777631 0.689408]}, ... % Cascade Mountains leeward forests
    {'ECO_ID',50508,'FaceColor',[0.753435 0.574520 1.000000]}, ... % Central and Southern Cascades forests
    {'ECO_ID',50509,'FaceColor',[1.000000 0.673719 0.613254]}, ... % Central British Columbia Mountain forests
    {'ECO_ID',50510,'FaceColor',[1.000000 0.573553 0.557687]}, ... % Central Pacific coastal forests
    {'ECO_ID',50511,'FaceColor',[0.567721 1.000000 0.807038]}, ... % Colorado Rockies forests
    {'ECO_ID',50512,'FaceColor',[1.000000 0.877428 0.609805]}, ... % Eastern Cascades forests
    {'ECO_ID',50513,'FaceColor',[1.000000 0.893554 0.682813]}, ... % Florida sand pine scrub
    {'ECO_ID',50514,'FaceColor',[0.663416 0.797290 1.000000]}, ... % Fraser Plateau and Basin complex
    {'ECO_ID',50515,'FaceColor',[0.558987 1.000000 0.659115]}, ... % Great Basin montane forests
    {'ECO_ID',50516,'FaceColor',[0.927219 1.000000 0.609899]}, ... % Klamath-Siskiyou forests
    {'ECO_ID',50517,'FaceColor',[0.721242 0.925776 1.000000]}, ... % Middle Atlantic coastal forests
    {'ECO_ID',50518,'FaceColor',[0.601323 1.000000 0.774188]}, ... % North Central Rockies forests
    {'ECO_ID',50519,'FaceColor',[1.000000 0.645872 0.886838]}, ... % Northern California coastal forests
    {'ECO_ID',50520,'FaceColor',[0.660174 1.000000 0.642895]}, ... % Northern Pacific coastal forests
    {'ECO_ID',50521,'FaceColor',[0.718810 1.000000 0.780898]}, ... % Northern transitional alpine forests
    {'ECO_ID',50522,'FaceColor',[0.664875 1.000000 0.880812]}, ... % Okanagan dry forests
    {'ECO_ID',50523,'FaceColor',[1.000000 0.885836 0.659163]}, ... % Piney Woods forests
    {'ECO_ID',50524,'FaceColor',[0.599032 0.926520 1.000000]}, ... % Puget lowland forests
    {'ECO_ID',50525,'FaceColor',[1.000000 0.931088 0.581517]}, ... % Queen Charlotte Islands
    {'ECO_ID',50526,'FaceColor',[0.696226 0.729575 1.000000]}, ... % Sierra Juarez and San Pedro Martir pine-oak forests
    {'ECO_ID',50527,'FaceColor',[1.000000 0.712324 0.785511]}, ... % Sierra Nevada forests
    {'ECO_ID',50528,'FaceColor',[0.719206 0.723274 1.000000]}, ... % South Central Rockies forests
    {'ECO_ID',50529,'FaceColor',[0.929213 0.685641 1.000000]}, ... % Southeastern conifer forests
    {'ECO_ID',50530,'FaceColor',[0.741297 1.000000 0.881775]}, ... % Wasatch and Uinta montane forests
    {'ECO_ID',50601,'FaceColor',[1.000000 0.944287 0.537455]}, ... % Alaska Peninsula montane taiga
    {'ECO_ID',50602,'FaceColor',[0.568119 1.000000 0.956108]}, ... % Central Canadian Shield forests
    {'ECO_ID',50603,'FaceColor',[0.992632 0.646768 1.000000]}, ... % Cook Inlet taiga
    {'ECO_ID',50604,'FaceColor',[0.758709 1.000000 0.713485]}, ... % Copper Plateau taiga
    {'ECO_ID',50605,'FaceColor',[1.000000 0.613079 0.844665]}, ... % Eastern Canadian forests
    {'ECO_ID',50606,'FaceColor',[0.548143 0.901506 1.000000]}, ... % Eastern Canadian Shield taiga
    {'ECO_ID',50607,'FaceColor',[1.000000 0.795676 0.659173]}, ... % Interior Alaska-Yukon lowland taiga
    {'ECO_ID',50608,'FaceColor',[0.984231 1.000000 0.631676]}, ... % Mid-Continental Canadian forests
    {'ECO_ID',50609,'FaceColor',[1.000000 0.784228 0.637812]}, ... % Midwestern Canadian Shield forests
    {'ECO_ID',50610,'FaceColor',[0.970418 0.571930 1.000000]}, ... % Muskwa-Slave Lake forests
    {'ECO_ID',50611,'FaceColor',[0.688224 1.000000 0.547963]}, ... % Newfoundland Highland forests
    {'ECO_ID',50612,'FaceColor',[0.944393 0.694656 1.000000]}, ... % Northern Canadian Shield taiga
    {'ECO_ID',50613,'FaceColor',[1.000000 0.919650 0.675285]}, ... % Northern Cordillera forests
    {'ECO_ID',50614,'FaceColor',[0.504923 1.000000 0.646090]}, ... % Northwest Territories taiga
    {'ECO_ID',50615,'FaceColor',[0.896294 1.000000 0.573960]}, ... % South Avalon-Burin oceanic barrens
    {'ECO_ID',50616,'FaceColor',[0.963712 1.000000 0.649840]}, ... % Southern Hudson Bay taiga
    {'ECO_ID',50617,'FaceColor',[0.795985 0.655766 1.000000]}, ... % Yukon Interior dry forests
    {'ECO_ID',50701,'FaceColor',[0.851458 0.667001 1.000000]}, ... % Western Gulf coastal grasslands
    {'ECO_ID',50801,'FaceColor',[1.000000 0.566675 0.627341]}, ... % California Central Valley grasslands
    {'ECO_ID',50802,'FaceColor',[0.651749 0.614385 1.000000]}, ... % Canadian Aspen forests and parklands
    {'ECO_ID',50803,'FaceColor',[0.975051 0.611791 1.000000]}, ... % Central and Southern mixed grasslands
    {'ECO_ID',50804,'FaceColor',[1.000000 0.990584 0.715549]}, ... % Central forest-grasslands transition
    {'ECO_ID',50805,'FaceColor',[1.000000 0.761834 0.578906]}, ... % Central tall grasslands
    {'ECO_ID',50806,'FaceColor',[0.678032 1.000000 0.957038]}, ... % Edwards Plateau savanna
    {'ECO_ID',50807,'FaceColor',[0.519991 1.000000 0.611014]}, ... % Flint Hills tall grasslands
    {'ECO_ID',50808,'FaceColor',[0.719071 0.742778 1.000000]}, ... % Montana Valley and Foothill grasslands
    {'ECO_ID',50809,'FaceColor',[0.863079 0.560782 1.000000]}, ... % Nebraska Sand Hills mixed grasslands
    {'ECO_ID',50810,'FaceColor',[0.639083 0.732629 1.000000]}, ... % Northern mixed grasslands
    {'ECO_ID',50811,'FaceColor',[1.000000 0.649065 0.527959]}, ... % Northern short grasslands
    {'ECO_ID',50812,'FaceColor',[0.537675 0.850711 1.000000]}, ... % Northern tall grasslands
    {'ECO_ID',50813,'FaceColor',[0.978161 0.587608 1.000000]}, ... % Palouse grasslands
    {'ECO_ID',50814,'FaceColor',[0.506700 0.927443 1.000000]}, ... % Texas blackland prairies
    {'ECO_ID',50815,'FaceColor',[1.000000 0.534008 0.605204]}, ... % Western short grasslands
    {'ECO_ID',51101,'FaceColor',[0.631674 0.929861 1.000000]}, ... % Alaska-St. Elias Range tundra
    {'ECO_ID',51102,'FaceColor',[1.000000 0.523322 0.689936]}, ... % Aleutian Islands tundra
    {'ECO_ID',51103,'FaceColor',[0.876386 0.668684 1.000000]}, ... % Arctic coastal tundra
    {'ECO_ID',51104,'FaceColor',[1.000000 0.590789 0.619173]}, ... % Arctic foothills tundra
    {'ECO_ID',51105,'FaceColor',[0.516073 0.877542 1.000000]}, ... % Baffin coastal tundra
    {'ECO_ID',51106,'FaceColor',[0.707604 0.648983 1.000000]}, ... % Beringia lowland tundra
    {'ECO_ID',51107,'FaceColor',[0.528566 1.000000 0.920754]}, ... % Beringia upland tundra
    {'ECO_ID',51108,'FaceColor',[0.786343 1.000000 0.595742]}, ... % Brooks-British Range tundra
    {'ECO_ID',51109,'FaceColor',[0.985670 1.000000 0.727438]}, ... % Davis Highlands tundra
    {'ECO_ID',51110,'FaceColor',[1.000000 0.570095 0.857019]}, ... % High Arctic tundra
    {'ECO_ID',51111,'FaceColor',[0.782537 0.718335 1.000000]}, ... % Interior Yukon-Alaska alpine tundra
    {'ECO_ID',51112,'FaceColor',[1.000000 0.781314 0.536700]}, ... % Kalaallit Nunaat high arctic tundra
    {'ECO_ID',51113,'FaceColor',[0.737279 0.745922 1.000000]}, ... % Kalaallit Nunaat low arctic tundra
    {'ECO_ID',51114,'FaceColor',[1.000000 0.659540 0.844639]}, ... % Low Arctic tundra
    {'ECO_ID',51115,'FaceColor',[0.720709 0.531680 1.000000]}, ... % Middle Arctic tundra
    {'ECO_ID',51116,'FaceColor',[0.799176 1.000000 0.621186]}, ... % Ogilvie-MacKenzie alpine tundra
    {'ECO_ID',51117,'FaceColor',[1.000000 0.991412 0.603242]}, ... % Pacific Coastal Mountain icefields and tundra
    {'ECO_ID',51118,'FaceColor',[0.780119 1.000000 0.574808]}, ... % Torngat Mountain tundra
    {'ECO_ID',51201,'FaceColor',[0.534255 0.538829 1.000000]}, ... % California coastal sage and chaparral
    {'ECO_ID',51202,'FaceColor',[0.697553 1.000000 0.959933]}, ... % California interior chaparral and woodlands
    {'ECO_ID',51203,'FaceColor',[0.653683 1.000000 0.974083]}, ... % California montane chaparral and woodlands
    {'ECO_ID',51301,'FaceColor',[0.674325 1.000000 0.549827]}, ... % Baja California desert
    {'ECO_ID',51302,'FaceColor',[0.625942 0.628205 1.000000]}, ... % Central Mexican matorral
    {'ECO_ID',51303,'FaceColor',[0.725203 0.979902 1.000000]}, ... % Chihuahuan desert
    {'ECO_ID',51304,'FaceColor',[0.651139 0.737511 1.000000]}, ... % Colorado Plateau shrublands
    {'ECO_ID',51305,'FaceColor',[0.525566 1.000000 0.936088]}, ... % Great Basin shrub steppe
    {'ECO_ID',51306,'FaceColor',[0.711882 1.000000 0.712045]}, ... % Gulf of California xeric scrub
    {'ECO_ID',51307,'FaceColor',[1.000000 0.559109 0.840775]}, ... % Meseta Central matorral
    {'ECO_ID',51308,'FaceColor',[0.505530 1.000000 0.587709]}, ... % Mojave desert
    {'ECO_ID',51309,'FaceColor',[0.710906 0.923774 1.000000]}, ... % Snake-Columbia shrub steppe
    {'ECO_ID',51310,'FaceColor',[0.948940 1.000000 0.523667]}, ... % Sonoran desert
    {'ECO_ID',51311,'FaceColor',[1.000000 0.661345 0.733157]}, ... % Tamaulipan matorral
    {'ECO_ID',51312,'FaceColor',[1.000000 0.577168 0.937860]}, ... % Tamaulipan mezquital
    {'ECO_ID',51313,'FaceColor',[0.927972 1.000000 0.731856]}, ... % Wyoming Basin shrub steppe
    {'ECO_ID',60101,'FaceColor',[0.660672 0.965497 1.000000]}, ... % Araucaria moist forests
    {'ECO_ID',60102,'FaceColor',[1.000000 0.677911 0.535352]}, ... % Atlantic Coast restingas
    {'ECO_ID',60103,'FaceColor',[0.637579 1.000000 0.813202]}, ... % Bahia coastal forests
    {'ECO_ID',60104,'FaceColor',[0.723763 1.000000 0.727421]}, ... % Bahia interior forests
    {'ECO_ID',60105,'FaceColor',[0.620955 1.000000 0.652737]}, ... % Bolivian Yungas
    {'ECO_ID',60106,'FaceColor',[1.000000 0.749575 0.644677]}, ... % Caatinga Enclaves moist forests
    {'ECO_ID',60107,'FaceColor',[0.827745 1.000000 0.554558]}, ... % Caqueta moist forests
    {'ECO_ID',60108,'FaceColor',[0.871317 1.000000 0.521174]}, ... % Catatumbo moist forests
    {'ECO_ID',60109,'FaceColor',[0.905039 1.000000 0.580642]}, ... % Cauca Valley montane forests
    {'ECO_ID',60110,'FaceColor',[0.686355 0.602085 1.000000]}, ... % Cayos Miskitos-San Andrés and Providencia moist forests
    {'ECO_ID',60111,'FaceColor',[0.966119 1.000000 0.624560]}, ... % Central American Atlantic moist forests
    {'ECO_ID',60112,'FaceColor',[0.547221 1.000000 0.534650]}, ... % Central American montane forests
    {'ECO_ID',60113,'FaceColor',[0.820129 1.000000 0.658103]}, ... % Chiapas montane forests
    {'ECO_ID',60114,'FaceColor',[0.602937 0.955237 1.000000]}, ... % Chimalapas montane forests
    {'ECO_ID',60115,'FaceColor',[0.735234 0.889353 1.000000]}, ... % Chocó-Darién moist forests
    {'ECO_ID',60116,'FaceColor',[0.803747 1.000000 0.565521]}, ... % Cocos Island moist forests
    {'ECO_ID',60117,'FaceColor',[1.000000 0.976563 0.651154]}, ... % Cordillera La Costa montane forests
    {'ECO_ID',60118,'FaceColor',[1.000000 0.695810 0.958961]}, ... % Cordillera Oriental montane forests
    {'ECO_ID',60119,'FaceColor',[0.814393 1.000000 0.709353]}, ... % Costa Rican seasonal moist forests
    {'ECO_ID',60120,'FaceColor',[0.600953 0.911141 1.000000]}, ... % Cuban moist forests
    {'ECO_ID',60121,'FaceColor',[0.715591 0.760014 1.000000]}, ... % Eastern Cordillera real montane forests
    {'ECO_ID',60122,'FaceColor',[1.000000 0.747536 0.948966]}, ... % Eastern Panamanian montane forests
    {'ECO_ID',60123,'FaceColor',[1.000000 0.543740 0.619656]}, ... % Fernando de Noronha-Atol das Rocas moist forests
    {'ECO_ID',60124,'FaceColor',[0.703264 0.873238 1.000000]}, ... % Guianan Highlands moist forests
    {'ECO_ID',60125,'FaceColor',[0.889829 0.730151 1.000000]}, ... % Guianan moist forests
    {'ECO_ID',60126,'FaceColor',[0.796528 0.727258 1.000000]}, ... % Gurupa varzeá
    {'ECO_ID',60127,'FaceColor',[1.000000 0.561372 0.650833]}, ... % Hispaniolan moist forests
    {'ECO_ID',60128,'FaceColor',[0.518808 0.628998 1.000000]}, ... % Iquitos varzeá
    {'ECO_ID',60129,'FaceColor',[0.722863 0.922000 1.000000]}, ... % Isthmian-Atlantic moist forests
    {'ECO_ID',60130,'FaceColor',[0.592815 0.849003 1.000000]}, ... % Isthmian-Pacific moist forests
    {'ECO_ID',60131,'FaceColor',[0.906086 1.000000 0.543390]}, ... % Jamaican moist forests
    {'ECO_ID',60132,'FaceColor',[0.740739 0.727853 1.000000]}, ... % Japurá-Solimoes-Negro moist forests
    {'ECO_ID',60133,'FaceColor',[0.973984 1.000000 0.745101]}, ... % Juruá-Purus moist forests
    {'ECO_ID',60134,'FaceColor',[0.525163 0.594527 1.000000]}, ... % Leeward Islands moist forests
    {'ECO_ID',60135,'FaceColor',[0.629276 1.000000 0.861340]}, ... % Madeira-Tapajós moist forests
    {'ECO_ID',60136,'FaceColor',[0.559860 0.546426 1.000000]}, ... % Magdalena Valley montane forests
    {'ECO_ID',60137,'FaceColor',[1.000000 0.518142 0.980785]}, ... % Magdalena-Urabá moist forests
    {'ECO_ID',60138,'FaceColor',[0.927399 0.715425 1.000000]}, ... % Marajó varzeá
    {'ECO_ID',60139,'FaceColor',[0.884520 0.714378 1.000000]}, ... % Maranhão Babaçu forests
    {'ECO_ID',60140,'FaceColor',[0.531570 0.863712 1.000000]}, ... % Mato Grosso seasonal forests
    {'ECO_ID',60141,'FaceColor',[1.000000 0.694144 0.672572]}, ... % Monte Alegre varzeá
    {'ECO_ID',60142,'FaceColor',[0.957822 0.707227 1.000000]}, ... % Napo moist forests
    {'ECO_ID',60143,'FaceColor',[0.947277 0.539723 1.000000]}, ... % Negro-Branco moist forests
    {'ECO_ID',60144,'FaceColor',[0.633230 0.667652 1.000000]}, ... % Northeastern Brazil restingas
    {'ECO_ID',60145,'FaceColor',[1.000000 0.740162 0.616152]}, ... % Northwestern Andean montane forests
    {'ECO_ID',60146,'FaceColor',[0.503438 1.000000 0.831646]}, ... % Oaxacan montane forests
    {'ECO_ID',60147,'FaceColor',[0.780262 1.000000 0.722127]}, ... % Orinoco Delta swamp forests
    {'ECO_ID',60148,'FaceColor',[0.590726 1.000000 0.834166]}, ... % Pantanos de Centla
    {'ECO_ID',60149,'FaceColor',[1.000000 0.717212 0.724810]}, ... % Guianan freshwater swamp forests
    {'ECO_ID',60150,'FaceColor',[1.000000 0.524364 0.645848]}, ... % Alto Paraná Atlantic forests
    {'ECO_ID',60151,'FaceColor',[0.520179 0.641943 1.000000]}, ... % Pernambuco coastal forests
    {'ECO_ID',60152,'FaceColor',[0.611192 1.000000 0.661542]}, ... % Pernambuco interior forests
    {'ECO_ID',60153,'FaceColor',[1.000000 0.668300 0.793374]}, ... % Peruvian Yungas
    {'ECO_ID',60154,'FaceColor',[1.000000 0.918955 0.521733]}, ... % Petén-Veracruz moist forests
    {'ECO_ID',60155,'FaceColor',[0.770905 1.000000 0.641508]}, ... % Puerto Rican moist forests
    {'ECO_ID',60156,'FaceColor',[0.726919 1.000000 0.554166]}, ... % Purus varzeá
    {'ECO_ID',60157,'FaceColor',[0.697546 0.691994 1.000000]}, ... % Purus-Madeira moist forests
    {'ECO_ID',60158,'FaceColor',[1.000000 0.824233 0.688166]}, ... % Rio Negro campinarana
    {'ECO_ID',60159,'FaceColor',[0.999286 1.000000 0.734708]}, ... % Santa Marta montane forests
    {'ECO_ID',60160,'FaceColor',[0.616343 0.947476 1.000000]}, ... % Serra do Mar coastal forests
    {'ECO_ID',60161,'FaceColor',[0.909192 1.000000 0.628211]}, ... % Sierra de los Tuxtlas
    {'ECO_ID',60162,'FaceColor',[0.550005 0.553507 1.000000]}, ... % Sierra Madre de Chiapas moist forests
    {'ECO_ID',60163,'FaceColor',[1.000000 0.580704 0.698218]}, ... % Solimões-Japurá moist forests
    {'ECO_ID',60164,'FaceColor',[0.575594 1.000000 0.779432]}, ... % South Florida rocklands
    {'ECO_ID',60165,'FaceColor',[1.000000 0.756015 0.661041]}, ... % Southern Andean Yungas
    {'ECO_ID',60166,'FaceColor',[0.611107 1.000000 0.913658]}, ... % Southwest Amazon moist forests
    {'ECO_ID',60167,'FaceColor',[0.943410 0.617247 1.000000]}, ... % Talamancan montane forests
    {'ECO_ID',60168,'FaceColor',[1.000000 0.653948 0.727745]}, ... % Tapajós-Xingu moist forests
    {'ECO_ID',60169,'FaceColor',[1.000000 0.898191 0.562187]}, ... % Pantepui
    {'ECO_ID',60170,'FaceColor',[0.580042 1.000000 0.768014]}, ... % Tocantins/Pindare moist forests
    {'ECO_ID',60171,'FaceColor',[0.602226 0.733912 1.000000]}, ... % Trinidad and Tobago moist forests
    {'ECO_ID',60172,'FaceColor',[0.992764 1.000000 0.732069]}, ... % Trindade-Martin Vaz Islands tropical forests
    {'ECO_ID',60173,'FaceColor',[0.736443 0.712444 1.000000]}, ... % Uatuma-Trombetas moist forests
    {'ECO_ID',60174,'FaceColor',[0.669654 1.000000 0.996152]}, ... % Ucayali moist forests
    {'ECO_ID',60175,'FaceColor',[0.531712 1.000000 0.786436]}, ... % Venezuelan Andes montane forests
    {'ECO_ID',60176,'FaceColor',[1.000000 0.552536 0.587167]}, ... % Veracruz moist forests
    {'ECO_ID',60177,'FaceColor',[0.581646 1.000000 0.853329]}, ... % Veracruz montane forests
    {'ECO_ID',60178,'FaceColor',[0.903122 0.649950 1.000000]}, ... % Western Ecuador moist forests
    {'ECO_ID',60179,'FaceColor',[0.511562 0.865782 1.000000]}, ... % Windward Islands moist forests
    {'ECO_ID',60180,'FaceColor',[1.000000 0.536898 0.926609]}, ... % Xingu-Tocantins-Araguaia moist forests
    {'ECO_ID',60181,'FaceColor',[1.000000 0.652745 0.850781]}, ... % Yucatán moist forests
    {'ECO_ID',60182,'FaceColor',[0.880117 0.579879 1.000000]}, ... % Guianan piedmont and lowland moist forests
    {'ECO_ID',60201,'FaceColor',[1.000000 0.633180 0.894691]}, ... % Apure-Villavicencio dry forests
    {'ECO_ID',60202,'FaceColor',[1.000000 0.881893 0.712290]}, ... % Atlantic dry forests
    {'ECO_ID',60204,'FaceColor',[0.890058 1.000000 0.689898]}, ... % Bajío dry forests
    {'ECO_ID',60205,'FaceColor',[0.695447 0.726212 1.000000]}, ... % Balsas dry forests
    {'ECO_ID',60206,'FaceColor',[0.604497 1.000000 0.932874]}, ... % Bolivian montane dry forests
    {'ECO_ID',60207,'FaceColor',[0.738645 0.669201 1.000000]}, ... % Cauca Valley dry forests
    {'ECO_ID',60209,'FaceColor',[1.000000 0.971324 0.743374]}, ... % Central American dry forests
    {'ECO_ID',60210,'FaceColor',[0.917701 1.000000 0.599228]}, ... % Dry Chaco
    {'ECO_ID',60211,'FaceColor',[0.613417 1.000000 0.714325]}, ... % Chiapas Depression dry forests
    {'ECO_ID',60212,'FaceColor',[0.600386 1.000000 0.598597]}, ... % Chiquitano dry forests
    {'ECO_ID',60213,'FaceColor',[0.628265 1.000000 0.660010]}, ... % Cuban dry forests
    {'ECO_ID',60214,'FaceColor',[0.500802 0.663732 1.000000]}, ... % Ecuadorian dry forests
    {'ECO_ID',60215,'FaceColor',[0.672478 0.987964 1.000000]}, ... % Hispaniolan dry forests
    {'ECO_ID',60216,'FaceColor',[0.830816 1.000000 0.682124]}, ... % Islas Revillagigedo dry forests
    {'ECO_ID',60217,'FaceColor',[1.000000 0.698712 0.711436]}, ... % Jalisco dry forests
    {'ECO_ID',60218,'FaceColor',[0.534854 0.905963 1.000000]}, ... % Jamaican dry forests
    {'ECO_ID',60219,'FaceColor',[0.752520 1.000000 0.717904]}, ... % Lara-Falcón dry forests
    {'ECO_ID',60220,'FaceColor',[0.545601 1.000000 0.738912]}, ... % Lesser Antillean dry forests
    {'ECO_ID',60221,'FaceColor',[0.876362 0.535106 1.000000]}, ... % Magdalena Valley dry forests
    {'ECO_ID',60222,'FaceColor',[1.000000 0.673556 0.625651]}, ... % Maracaibo dry forests
    {'ECO_ID',60223,'FaceColor',[1.000000 0.868573 0.531898]}, ... % Marañón dry forests
    {'ECO_ID',60224,'FaceColor',[0.687829 1.000000 0.572355]}, ... % Panamanian dry forests
    {'ECO_ID',60225,'FaceColor',[1.000000 0.592586 0.831890]}, ... % Patía Valley dry forests
    {'ECO_ID',60226,'FaceColor',[0.592125 0.982865 1.000000]}, ... % Puerto Rican dry forests
    {'ECO_ID',60227,'FaceColor',[1.000000 0.519584 0.776749]}, ... % Sierra de la Laguna dry forests
    {'ECO_ID',60228,'FaceColor',[0.693167 1.000000 0.504135]}, ... % Sinaloan dry forests
    {'ECO_ID',60229,'FaceColor',[1.000000 0.582619 0.998186]}, ... % Sinú Valley dry forests
    {'ECO_ID',60230,'FaceColor',[0.713173 0.791139 1.000000]}, ... % Southern Pacific dry forests
    {'ECO_ID',60232,'FaceColor',[0.741647 0.866695 1.000000]}, ... % Tumbes-Piura dry forests
    {'ECO_ID',60233,'FaceColor',[0.696451 0.778227 1.000000]}, ... % Veracruz dry forests
    {'ECO_ID',60235,'FaceColor',[0.666321 1.000000 0.718540]}, ... % Yucatán dry forests
    {'ECO_ID',60301,'FaceColor',[0.610408 1.000000 0.941449]}, ... % Bahamian pine mosaic
    {'ECO_ID',60302,'FaceColor',[0.691124 1.000000 0.650492]}, ... % Belizian pine forests
    {'ECO_ID',60303,'FaceColor',[1.000000 0.842381 0.737835]}, ... % Central American pine-oak forests
    {'ECO_ID',60304,'FaceColor',[0.828120 1.000000 0.624816]}, ... % Cuban pine forests
    {'ECO_ID',60305,'FaceColor',[0.638861 0.770656 1.000000]}, ... % Hispaniolan pine forests
    {'ECO_ID',60306,'FaceColor',[0.672998 1.000000 0.866597]}, ... % Miskito pine forests
    {'ECO_ID',60307,'FaceColor',[0.535084 1.000000 0.819055]}, ... % Sierra de la Laguna pine-oak forests
    {'ECO_ID',60308,'FaceColor',[1.000000 0.834467 0.615079]}, ... % Sierra Madre de Oaxaca pine-oak forests
    {'ECO_ID',60309,'FaceColor',[1.000000 0.782120 0.661418]}, ... % Sierra Madre del Sur pine-oak forests
    {'ECO_ID',60310,'FaceColor',[1.000000 0.728552 0.935144]}, ... % Trans-Mexican Volcanic Belt pine-oak forests
    {'ECO_ID',60401,'FaceColor',[1.000000 0.999251 0.648342]}, ... % Juan Fernández Islands temperate forests
    {'ECO_ID',60402,'FaceColor',[1.000000 0.944869 0.633912]}, ... % Magellanic subpolar forests
    {'ECO_ID',60403,'FaceColor',[0.694409 0.715577 1.000000]}, ... % San Félix-San Ambrosio Islands temperate forests
    {'ECO_ID',60404,'FaceColor',[1.000000 0.870164 0.732618]}, ... % Valdivian temperate forests
    {'ECO_ID',60702,'FaceColor',[0.849058 0.569248 1.000000]}, ... % Beni savanna
    {'ECO_ID',60703,'FaceColor',[0.696654 0.957197 1.000000]}, ... % Campos Rupestres montane savanna
    {'ECO_ID',60704,'FaceColor',[0.853007 1.000000 0.675746]}, ... % Cerrado
    {'ECO_ID',60705,'FaceColor',[1.000000 0.909224 0.605999]}, ... % Clipperton Island shrub and grasslands
    {'ECO_ID',60707,'FaceColor',[1.000000 0.880737 0.559632]}, ... % Guianan savanna
    {'ECO_ID',60708,'FaceColor',[1.000000 0.668936 0.544685]}, ... % Humid Chaco
    {'ECO_ID',60709,'FaceColor',[0.904121 0.628500 1.000000]}, ... % Llanos
    {'ECO_ID',60710,'FaceColor',[1.000000 0.804961 0.632520]}, ... % Uruguayan savanna
    {'ECO_ID',60801,'FaceColor',[0.624873 1.000000 0.913674]}, ... % Espinal
    {'ECO_ID',60802,'FaceColor',[1.000000 0.560517 0.947290]}, ... % Low Monte
    {'ECO_ID',60803,'FaceColor',[0.676652 0.702333 1.000000]}, ... % Humid Pampas
    {'ECO_ID',60805,'FaceColor',[0.913969 0.546480 1.000000]}, ... % Patagonian steppe
    {'ECO_ID',60902,'FaceColor',[1.000000 0.574275 0.612353]}, ... % Cuban wetlands
    {'ECO_ID',60903,'FaceColor',[0.810640 0.748703 1.000000]}, ... % Enriquillo wetlands
    {'ECO_ID',60904,'FaceColor',[0.710575 1.000000 0.778533]}, ... % Everglades
    {'ECO_ID',60905,'FaceColor',[0.678820 0.585241 1.000000]}, ... % Guayaquil flooded grasslands
    {'ECO_ID',60906,'FaceColor',[0.920525 0.535461 1.000000]}, ... % Orinoco wetlands
    {'ECO_ID',60907,'FaceColor',[1.000000 0.836522 0.651626]}, ... % Pantanal
    {'ECO_ID',60908,'FaceColor',[1.000000 0.752661 0.576999]}, ... % Paraná flooded savanna
    {'ECO_ID',60909,'FaceColor',[0.821208 0.504730 1.000000]}, ... % Southern Cone Mesopotamian savanna
    {'ECO_ID',61001,'FaceColor',[1.000000 0.520360 0.908800]}, ... % Central Andean dry puna
    {'ECO_ID',61002,'FaceColor',[0.621148 1.000000 0.667558]}, ... % Central Andean puna
    {'ECO_ID',61003,'FaceColor',[0.635634 0.591579 1.000000]}, ... % Central Andean wet puna
    {'ECO_ID',61004,'FaceColor',[0.654958 0.783806 1.000000]}, ... % Cordillera Central páramo
    {'ECO_ID',61005,'FaceColor',[0.952842 1.000000 0.727306]}, ... % Cordillera de Merida páramo
    {'ECO_ID',61006,'FaceColor',[0.692118 0.725405 1.000000]}, ... % Northern Andean páramo
    {'ECO_ID',61007,'FaceColor',[0.735830 1.000000 0.728976]}, ... % Santa Marta páramo
    {'ECO_ID',61008,'FaceColor',[0.503040 1.000000 0.773134]}, ... % Southern Andean steppe
    {'ECO_ID',61010,'FaceColor',[0.947584 0.634528 1.000000]}, ... % High Monte
    {'ECO_ID',61201,'FaceColor',[0.670942 0.558522 1.000000]}, ... % Chilean matorral
    {'ECO_ID',61301,'FaceColor',[0.649514 1.000000 0.563177]}, ... % Araya and Paria xeric scrub
    {'ECO_ID',61303,'FaceColor',[1.000000 0.851462 0.632492]}, ... % Atacama desert
    {'ECO_ID',61304,'FaceColor',[0.637940 1.000000 0.676054]}, ... % Caatinga
    {'ECO_ID',61305,'FaceColor',[1.000000 0.549054 0.916604]}, ... % Caribbean shrublands
    {'ECO_ID',61306,'FaceColor',[1.000000 0.600122 0.887188]}, ... % Cuban cactus scrub
    {'ECO_ID',61307,'FaceColor',[1.000000 0.643279 0.685061]}, ... % Galápagos Islands scrubland mosaic
    {'ECO_ID',61308,'FaceColor',[0.671952 1.000000 0.870747]}, ... % Guajira-Barranquilla xeric scrub
    {'ECO_ID',61309,'FaceColor',[0.954563 1.000000 0.672578]}, ... % La Costa xeric shrublands
    {'ECO_ID',61311,'FaceColor',[0.570260 1.000000 0.667996]}, ... % Malpelo Island xeric scrub
    {'ECO_ID',61312,'FaceColor',[0.578190 1.000000 0.713063]}, ... % Motagua Valley thornscrub
    {'ECO_ID',61313,'FaceColor',[0.921148 1.000000 0.611675]}, ... % Paraguana xeric scrub
    {'ECO_ID',61314,'FaceColor',[0.997654 0.530222 1.000000]}, ... % San Lucan xeric scrub
    {'ECO_ID',61315,'FaceColor',[0.733840 1.000000 0.765001]}, ... % Sechura desert
    {'ECO_ID',61316,'FaceColor',[0.527174 1.000000 0.807907]}, ... % Tehuacán Valley matorral
    {'ECO_ID',61318,'FaceColor',[0.593664 1.000000 0.604552]}, ... % St. Peter and St. Paul rocks
    {'ECO_ID',61401,'FaceColor',[1.000000 0.972371 0.734891]}, ... % Amazon-Orinoco-Southern Caribbean mangroves
    {'ECO_ID',61402,'FaceColor',[0.817937 1.000000 0.504579]}, ... % Bahamian-Antillean mangroves
    {'ECO_ID',61403,'FaceColor',[0.526221 0.653849 1.000000]}, ... % Mesoamerican Gulf-Caribbean mangroves
    {'ECO_ID',61404,'FaceColor',[0.895384 0.674233 1.000000]}, ... % Northern Mesoamerican Pacific mangroves
    {'ECO_ID',61405,'FaceColor',[0.846976 1.000000 0.614201]}, ... % South American Pacific mangroves
    {'ECO_ID',61406,'FaceColor',[1.000000 0.710637 0.662971]}, ... % Southern Atlantic mangroves
    {'ECO_ID',61407,'FaceColor',[0.658710 0.817252 1.000000]}, ... % Southern Mesoamerican Pacific mangroves
    {'ECO_ID',70101,'FaceColor',[1.000000 0.973779 0.621720]}, ... % Carolines tropical moist forests
    {'ECO_ID',70102,'FaceColor',[1.000000 0.908433 0.549580]}, ... % Central Polynesian tropical moist forests
    {'ECO_ID',70103,'FaceColor',[0.630842 0.773607 1.000000]}, ... % Cook Islands tropical moist forests
    {'ECO_ID',70104,'FaceColor',[0.664509 0.502366 1.000000]}, ... % Eastern Micronesia tropical moist forests
    {'ECO_ID',70105,'FaceColor',[0.796781 0.656721 1.000000]}, ... % Fiji tropical moist forests
    {'ECO_ID',70106,'FaceColor',[1.000000 0.538234 0.858811]}, ... % Hawaii tropical moist forests
    {'ECO_ID',70107,'FaceColor',[1.000000 0.741492 0.977623]}, ... % Kermadec Islands subtropical moist forests
    {'ECO_ID',70108,'FaceColor',[0.710724 1.000000 0.555844]}, ... % Marquesas tropical moist forests
    {'ECO_ID',70109,'FaceColor',[0.666874 1.000000 0.985622]}, ... % Ogasawara subtropical moist forests
    {'ECO_ID',70110,'FaceColor',[0.684932 1.000000 0.755142]}, ... % Palau tropical moist forests
    {'ECO_ID',70111,'FaceColor',[0.830794 0.587657 1.000000]}, ... % Rapa Nui subtropical broadleaf forests
    {'ECO_ID',70112,'FaceColor',[0.915150 0.508437 1.000000]}, ... % Samoan tropical moist forests
    {'ECO_ID',70113,'FaceColor',[0.603956 0.797069 1.000000]}, ... % Society Islands tropical moist forests
    {'ECO_ID',70114,'FaceColor',[0.570255 0.533293 1.000000]}, ... % Tongan tropical moist forests
    {'ECO_ID',70115,'FaceColor',[0.867504 1.000000 0.619525]}, ... % Tuamotu tropical moist forests
    {'ECO_ID',70116,'FaceColor',[0.904009 1.000000 0.646950]}, ... % Tubuai tropical moist forests
    {'ECO_ID',70117,'FaceColor',[0.659597 0.615005 1.000000]}, ... % Western Polynesian tropical moist forests
    {'ECO_ID',70201,'FaceColor',[1.000000 0.678290 0.890542]}, ... % Fiji tropical dry forests
    {'ECO_ID',70202,'FaceColor',[0.782111 1.000000 0.579954]}, ... % Hawaii tropical dry forests
    {'ECO_ID',70203,'FaceColor',[1.000000 0.648259 0.973543]}, ... % Marianas tropical dry forests
    {'ECO_ID',70204,'FaceColor',[1.000000 0.930714 0.716318]}, ... % Yap tropical dry forests
    {'ECO_ID',70701,'FaceColor',[0.604516 0.670879 1.000000]}, ... % Hawaii tropical high shrublands
    {'ECO_ID',70702,'FaceColor',[1.000000 0.719061 0.805755]}, ... % Hawaii tropical low shrublands
    {'ECO_ID',70703,'FaceColor',[0.868151 0.514519 1.000000]}, ... % Northwestern Hawaii scrub
    {'ECO_ID',80101,'FaceColor',[0.669251 0.781483 1.000000]}, ... % Guizhou Plateau broadleaf and mixed forests
    {'ECO_ID',80102,'FaceColor',[0.569748 0.817145 1.000000]}, ... % Yunnan Plateau subtropical evergreen forests
    {'ECO_ID',80401,'FaceColor',[1.000000 0.558020 0.542410]}, ... % Appenine deciduous montane forests
    {'ECO_ID',80402,'FaceColor',[0.734352 0.835470 1.000000]}, ... % Atlantic mixed forests
    {'ECO_ID',80403,'FaceColor',[0.848671 1.000000 0.690697]}, ... % Azores temperate mixed forests
    {'ECO_ID',80404,'FaceColor',[0.658722 1.000000 0.598306]}, ... % Balkan mixed forests
    {'ECO_ID',80405,'FaceColor',[0.642874 0.542649 1.000000]}, ... % Baltic mixed forests
    {'ECO_ID',80406,'FaceColor',[0.577957 1.000000 0.985114]}, ... % Cantabrian mixed forests
    {'ECO_ID',80407,'FaceColor',[1.000000 0.738134 0.789634]}, ... % Caspian Hyrcanian mixed forests
    {'ECO_ID',80408,'FaceColor',[1.000000 0.709149 0.578965]}, ... % Caucasus mixed forests
    {'ECO_ID',80409,'FaceColor',[1.000000 0.525479 0.732839]}, ... % Celtic broadleaf forests
    {'ECO_ID',80410,'FaceColor',[0.841897 1.000000 0.735550]}, ... % Central Anatolian steppe and woodlands
    {'ECO_ID',80411,'FaceColor',[1.000000 0.725630 0.817524]}, ... % Central China loess plateau mixed forests
    {'ECO_ID',80412,'FaceColor',[0.650504 0.698198 1.000000]}, ... % Central European mixed forests
    {'ECO_ID',80413,'FaceColor',[0.526423 1.000000 0.924897]}, ... % Central Korean deciduous forests
    {'ECO_ID',80414,'FaceColor',[0.885410 0.582349 1.000000]}, ... % Changbai Mountains mixed forests
    {'ECO_ID',80415,'FaceColor',[1.000000 0.566453 0.543891]}, ... % Changjiang Plain evergreen forests
    {'ECO_ID',80416,'FaceColor',[1.000000 0.946344 0.532865]}, ... % Crimean Submediterranean forest complex
    {'ECO_ID',80417,'FaceColor',[0.639003 0.592400 1.000000]}, ... % Daba Mountains evergreen forests
    {'ECO_ID',80418,'FaceColor',[0.606882 0.905375 1.000000]}, ... % Dinaric Mountains mixed forests
    {'ECO_ID',80419,'FaceColor',[0.635499 0.900047 1.000000]}, ... % East European forest steppe
    {'ECO_ID',80420,'FaceColor',[0.639396 1.000000 0.962738]}, ... % Eastern Anatolian deciduous forests
    {'ECO_ID',80421,'FaceColor',[1.000000 0.906478 0.728599]}, ... % English Lowlands beech forests
    {'ECO_ID',80422,'FaceColor',[0.742704 0.897433 1.000000]}, ... % Euxine-Colchic broadleaf forests
    {'ECO_ID',80423,'FaceColor',[0.548200 1.000000 0.587783]}, ... % Hokkaido deciduous forests
    {'ECO_ID',80424,'FaceColor',[0.974281 0.581372 1.000000]}, ... % Huang He Plain mixed forests
    {'ECO_ID',80425,'FaceColor',[0.680311 1.000000 0.953660]}, ... % Madeira evergreen forests
    {'ECO_ID',80426,'FaceColor',[1.000000 0.701771 0.738268]}, ... % Manchurian mixed forests
    {'ECO_ID',80427,'FaceColor',[1.000000 0.782535 0.651542]}, ... % Nihonkai evergreen forests
    {'ECO_ID',80428,'FaceColor',[0.869270 1.000000 0.591903]}, ... % Nihonkai montane deciduous forests
    {'ECO_ID',80429,'FaceColor',[0.693463 0.871306 1.000000]}, ... % North Atlantic moist mixed forests
    {'ECO_ID',80430,'FaceColor',[0.800885 1.000000 0.740041]}, ... % Northeast China Plain deciduous forests
    {'ECO_ID',80431,'FaceColor',[0.727720 1.000000 0.754600]}, ... % Pannonian mixed forests
    {'ECO_ID',80432,'FaceColor',[0.669146 0.995448 1.000000]}, ... % Po Basin mixed forests
    {'ECO_ID',80433,'FaceColor',[1.000000 0.598257 0.835640]}, ... % Pyrenees conifer and mixed forests
    {'ECO_ID',80434,'FaceColor',[0.642979 1.000000 0.981860]}, ... % Qin Ling Mountains deciduous forests
    {'ECO_ID',80435,'FaceColor',[1.000000 0.681613 0.525348]}, ... % Rodope montane mixed forests
    {'ECO_ID',80436,'FaceColor',[0.977318 1.000000 0.618820]}, ... % Sarmatic mixed forests
    {'ECO_ID',80437,'FaceColor',[0.542381 1.000000 0.750678]}, ... % Sichuan Basin evergreen broadleaf forests
    {'ECO_ID',80438,'FaceColor',[0.620623 0.657837 1.000000]}, ... % South Sakhalin-Kurile mixed forests
    {'ECO_ID',80439,'FaceColor',[0.650926 1.000000 0.975878]}, ... % Southern Korea evergreen forests
    {'ECO_ID',80440,'FaceColor',[1.000000 0.698402 0.812403]}, ... % Taiheiyo evergreen forests
    {'ECO_ID',80441,'FaceColor',[1.000000 0.569633 0.829564]}, ... % Taiheiyo montane deciduous forests
    {'ECO_ID',80442,'FaceColor',[0.658673 0.672133 1.000000]}, ... % Tarim Basin deciduous forests and steppe
    {'ECO_ID',80443,'FaceColor',[0.995450 0.611385 1.000000]}, ... % Ussuri broadleaf and mixed forests
    {'ECO_ID',80444,'FaceColor',[1.000000 0.590149 0.927587]}, ... % Western Siberian hemiboreal forests
    {'ECO_ID',80445,'FaceColor',[0.561566 1.000000 0.614960]}, ... % Western European broadleaf forests
    {'ECO_ID',80446,'FaceColor',[0.637231 1.000000 0.773100]}, ... % Zagros Mountains forest steppe
    {'ECO_ID',80501,'FaceColor',[1.000000 0.839021 0.744806]}, ... % Alps conifer and mixed forests
    {'ECO_ID',80502,'FaceColor',[0.700861 0.862560 1.000000]}, ... % Altai montane forest and forest steppe
    {'ECO_ID',80503,'FaceColor',[0.813112 0.685104 1.000000]}, ... % Caledon conifer forests
    {'ECO_ID',80504,'FaceColor',[1.000000 0.620920 0.823873]}, ... % Carpathian montane forests
    {'ECO_ID',80505,'FaceColor',[0.687836 1.000000 0.996802]}, ... % Da Hinggan-Dzhagdy Mountains conifer forests
    {'ECO_ID',80506,'FaceColor',[0.590714 1.000000 0.611112]}, ... % East Afghan montane conifer forests
    {'ECO_ID',80507,'FaceColor',[0.776104 1.000000 0.576668]}, ... % Elburz Range forest steppe
    {'ECO_ID',80508,'FaceColor',[1.000000 0.559841 0.930698]}, ... % Helanshan montane conifer forests
    {'ECO_ID',80509,'FaceColor',[0.684736 0.891863 1.000000]}, ... % Hengduan Mountains subalpine conifer forests
    {'ECO_ID',80510,'FaceColor',[1.000000 0.701162 0.759538]}, ... % Hokkaido montane conifer forests
    {'ECO_ID',80511,'FaceColor',[1.000000 0.539958 0.737360]}, ... % Honshu alpine conifer forests
    {'ECO_ID',80512,'FaceColor',[0.696808 1.000000 0.839218]}, ... % Khangai Mountains conifer forests
    {'ECO_ID',80513,'FaceColor',[1.000000 0.764304 0.569897]}, ... % Mediterranean conifer and mixed forests
    {'ECO_ID',80514,'FaceColor',[1.000000 0.600571 0.668377]}, ... % Northeastern Himalayan subalpine conifer forests
    {'ECO_ID',80515,'FaceColor',[0.712451 1.000000 0.780177]}, ... % Northern Anatolian conifer and deciduous forests
    {'ECO_ID',80516,'FaceColor',[1.000000 0.855754 0.606749]}, ... % Nujiang Langcang Gorge alpine conifer and mixed forests
    {'ECO_ID',80517,'FaceColor',[0.832408 1.000000 0.649580]}, ... % Qilian Mountains conifer forests
    {'ECO_ID',80518,'FaceColor',[1.000000 0.665142 0.892473]}, ... % Qionglai-Minshan conifer forests
    {'ECO_ID',80519,'FaceColor',[0.675428 0.612662 1.000000]}, ... % Sayan montane conifer forests
    {'ECO_ID',80520,'FaceColor',[0.795968 1.000000 0.536026]}, ... % Scandinavian coastal conifer forests
    {'ECO_ID',80521,'FaceColor',[1.000000 0.636563 0.909295]}, ... % Tian Shan montane conifer forests
    {'ECO_ID',80601,'FaceColor',[0.784752 0.661346 1.000000]}, ... % East Siberian taiga
    {'ECO_ID',80602,'FaceColor',[0.771144 0.646392 1.000000]}, ... % Iceland boreal birch forests and alpine tundra
    {'ECO_ID',80603,'FaceColor',[0.669574 0.688407 1.000000]}, ... % Kamchatka-Kurile meadows and sparse forests
    {'ECO_ID',80604,'FaceColor',[0.632931 0.522992 1.000000]}, ... % Kamchatka-Kurile taiga
    {'ECO_ID',80605,'FaceColor',[1.000000 0.525633 0.512544]}, ... % Northeast Siberian taiga
    {'ECO_ID',80606,'FaceColor',[1.000000 0.573718 0.995333]}, ... % Okhotsk-Manchurian taiga
    {'ECO_ID',80607,'FaceColor',[0.726822 0.800557 1.000000]}, ... % Sakhalin Island taiga
    {'ECO_ID',80608,'FaceColor',[0.653249 1.000000 0.547718]}, ... % Scandinavian and Russian taiga
    {'ECO_ID',80609,'FaceColor',[0.682273 0.889539 1.000000]}, ... % Trans-Baikal conifer forests
    {'ECO_ID',80610,'FaceColor',[1.000000 0.859911 0.578295]}, ... % Ural montane forests and tundra
    {'ECO_ID',80611,'FaceColor',[0.840187 1.000000 0.521659]}, ... % West Siberian taiga
    {'ECO_ID',80801,'FaceColor',[0.726569 0.941634 1.000000]}, ... % Alai-Western Tian Shan steppe
    {'ECO_ID',80802,'FaceColor',[0.675759 0.806646 1.000000]}, ... % Altai steppe and semi-desert
    {'ECO_ID',80803,'FaceColor',[1.000000 0.557471 0.858948]}, ... % Central Anatolian steppe
    {'ECO_ID',80804,'FaceColor',[1.000000 0.963344 0.620257]}, ... % Daurian forest steppe
    {'ECO_ID',80805,'FaceColor',[1.000000 0.595724 0.607149]}, ... % Eastern Anatolian montane steppe
    {'ECO_ID',80806,'FaceColor',[0.902271 1.000000 0.720205]}, ... % Emin Valley steppe
    {'ECO_ID',80807,'FaceColor',[1.000000 0.609864 0.711524]}, ... % Faroe Islands boreal grasslands
    {'ECO_ID',80808,'FaceColor',[0.999650 1.000000 0.510881]}, ... % Gissaro-Alai open woodlands
    {'ECO_ID',80809,'FaceColor',[0.568143 0.574204 1.000000]}, ... % Kazakh forest steppe
    {'ECO_ID',80810,'FaceColor',[0.519169 1.000000 0.523962]}, ... % Kazakh steppe
    {'ECO_ID',80811,'FaceColor',[0.736671 0.979085 1.000000]}, ... % Kazakh upland
    {'ECO_ID',80812,'FaceColor',[0.568668 1.000000 0.898912]}, ... % Middle East steppe
    {'ECO_ID',80813,'FaceColor',[0.729446 0.738622 1.000000]}, ... % Mongolian-Manchurian grassland
    {'ECO_ID',80814,'FaceColor',[1.000000 0.896721 0.569065]}, ... % Pontic steppe
    {'ECO_ID',80815,'FaceColor',[0.738497 0.931443 1.000000]}, ... % Sayan Intermontane steppe
    {'ECO_ID',80816,'FaceColor',[1.000000 0.918543 0.603634]}, ... % Selenge-Orkhon forest steppe
    {'ECO_ID',80817,'FaceColor',[0.674703 1.000000 0.840902]}, ... % South Siberian forest steppe
    {'ECO_ID',80818,'FaceColor',[0.646346 0.725724 1.000000]}, ... % Tian Shan foothill arid steppe
    {'ECO_ID',80901,'FaceColor',[0.510349 0.968252 1.000000]}, ... % Amur meadow steppe
    {'ECO_ID',80902,'FaceColor',[1.000000 0.700383 0.817633]}, ... % Bohai Sea saline meadow
    {'ECO_ID',80903,'FaceColor',[0.626502 0.747874 1.000000]}, ... % Nenjiang River grassland
    {'ECO_ID',80904,'FaceColor',[1.000000 0.727640 0.735307]}, ... % Nile Delta flooded savanna
    {'ECO_ID',80905,'FaceColor',[1.000000 0.539798 0.649284]}, ... % Saharan halophytics
    {'ECO_ID',80906,'FaceColor',[0.588887 0.683247 1.000000]}, ... % Tigris-Euphrates alluvial salt marsh
    {'ECO_ID',80907,'FaceColor',[0.881728 1.000000 0.748106]}, ... % Suiphun-Khanka meadows and forest meadows
    {'ECO_ID',80908,'FaceColor',[0.510476 1.000000 0.800800]}, ... % Yellow Sea saline meadow
    {'ECO_ID',81001,'FaceColor',[0.694003 1.000000 0.849912]}, ... % Altai alpine meadow and tundra
    {'ECO_ID',81002,'FaceColor',[1.000000 0.692555 0.862883]}, ... % Central Tibetan Plateau alpine steppe
    {'ECO_ID',81003,'FaceColor',[1.000000 0.893821 0.555480]}, ... % Eastern Himalayan alpine shrub and meadows
    {'ECO_ID',81004,'FaceColor',[1.000000 0.501926 0.548184]}, ... % Ghorat-Hazarajat alpine meadow
    {'ECO_ID',81005,'FaceColor',[0.866473 1.000000 0.613288]}, ... % Hindu Kush alpine meadow
    {'ECO_ID',81006,'FaceColor',[0.818040 0.724357 1.000000]}, ... % Karakoram-West Tibetan Plateau alpine steppe
    {'ECO_ID',81007,'FaceColor',[1.000000 0.735960 0.962288]}, ... % Khangai Mountains alpine meadow
    {'ECO_ID',81008,'FaceColor',[0.771646 1.000000 0.693385]}, ... % Kopet Dag woodlands and forest steppe
    {'ECO_ID',81009,'FaceColor',[1.000000 0.672614 0.751120]}, ... % Kuh Rud and Eastern Iran montane woodlands
    {'ECO_ID',81010,'FaceColor',[0.546947 1.000000 0.700430]}, ... % Mediterranean High Atlas juniper steppe
    {'ECO_ID',81011,'FaceColor',[0.536025 0.688880 1.000000]}, ... % North Tibetan Plateau-Kunlun Mountains alpine desert
    {'ECO_ID',81012,'FaceColor',[0.907362 0.713924 1.000000]}, ... % Northwestern Himalayan alpine shrub and meadows
    {'ECO_ID',81013,'FaceColor',[0.739216 1.000000 0.696741]}, ... % Ordos Plateau steppe
    {'ECO_ID',81014,'FaceColor',[1.000000 0.743329 0.786596]}, ... % Pamir alpine desert and tundra
    {'ECO_ID',81015,'FaceColor',[0.960094 0.665771 1.000000]}, ... % Qilian Mountains subalpine meadows
    {'ECO_ID',81016,'FaceColor',[1.000000 0.580918 0.704286]}, ... % Sayan Alpine meadows and tundra
    {'ECO_ID',81017,'FaceColor',[0.511172 1.000000 0.772048]}, ... % Southeast Tibet shrublands and meadows
    {'ECO_ID',81018,'FaceColor',[0.737495 1.000000 0.795408]}, ... % Sulaiman Range alpine meadows
    {'ECO_ID',81019,'FaceColor',[0.572085 0.605962 1.000000]}, ... % Tian Shan montane steppe and meadows
    {'ECO_ID',81020,'FaceColor',[1.000000 0.692088 0.910675]}, ... % Tibetan Plateau alpine shrublands and meadows
    {'ECO_ID',81021,'FaceColor',[0.968773 0.709998 1.000000]}, ... % Western Himalayan alpine shrub and Meadows
    {'ECO_ID',81022,'FaceColor',[0.564055 0.742875 1.000000]}, ... % Yarlung Tsangpo arid steppe
    {'ECO_ID',81101,'FaceColor',[0.507248 0.996513 1.000000]}, ... % Arctic desert
    {'ECO_ID',81102,'FaceColor',[0.657438 1.000000 0.829796]}, ... % Bering tundra
    {'ECO_ID',81103,'FaceColor',[0.586197 1.000000 0.974731]}, ... % Cherskii-Kolyma mountain tundra
    {'ECO_ID',81104,'FaceColor',[1.000000 0.579609 0.777408]}, ... % Chukchi Peninsula tundra
    {'ECO_ID',81105,'FaceColor',[0.718332 0.947608 1.000000]}, ... % Kamchatka Mountain tundra and forest tundra
    {'ECO_ID',81106,'FaceColor',[0.863154 0.508117 1.000000]}, ... % Kola Peninsula tundra
    {'ECO_ID',81107,'FaceColor',[1.000000 0.863817 0.689384]}, ... % Northeast Siberian coastal tundra
    {'ECO_ID',81108,'FaceColor',[1.000000 0.848311 0.616811]}, ... % Northwest Russian-Novaya Zemlya tundra
    {'ECO_ID',81109,'FaceColor',[0.713283 1.000000 0.542140]}, ... % Novosibirsk Islands arctic desert
    {'ECO_ID',81110,'FaceColor',[1.000000 0.579426 0.712092]}, ... % Scandinavian Montane Birch forest and grasslands
    {'ECO_ID',81111,'FaceColor',[1.000000 0.620714 0.676385]}, ... % Taimyr-Central Siberian tundra
    {'ECO_ID',81112,'FaceColor',[0.764412 0.647557 1.000000]}, ... % Trans-Baikal Bald Mountain tundra
    {'ECO_ID',81113,'FaceColor',[0.714019 0.713724 1.000000]}, ... % Wrangel Island arctic desert
    {'ECO_ID',81114,'FaceColor',[1.000000 0.688638 0.940792]}, ... % Yamal-Gydan tundra
    {'ECO_ID',81201,'FaceColor',[0.575283 1.000000 0.829623]}, ... % Aegean and Western Turkey sclerophyllous and mixed forests
    {'ECO_ID',81202,'FaceColor',[0.800480 1.000000 0.645416]}, ... % Anatolian conifer and deciduous mixed forests
    {'ECO_ID',81203,'FaceColor',[0.711920 1.000000 0.873396]}, ... % Canary Islands dry woodlands and forests
    {'ECO_ID',81204,'FaceColor',[1.000000 0.546654 0.945604]}, ... % Corsican montane broadleaf and mixed forests
    {'ECO_ID',81205,'FaceColor',[0.945759 0.725982 1.000000]}, ... % Crete Mediterranean forests
    {'ECO_ID',81206,'FaceColor',[1.000000 0.531679 0.834759]}, ... % Cyprus Mediterranean forests
    {'ECO_ID',81207,'FaceColor',[1.000000 0.934406 0.621133]}, ... % Eastern Mediterranean conifer-sclerophyllous-broadleaf forests
    {'ECO_ID',81208,'FaceColor',[0.896732 0.709073 1.000000]}, ... % Iberian conifer forests
    {'ECO_ID',81209,'FaceColor',[0.635096 1.000000 0.563540]}, ... % Iberian sclerophyllous and semi-deciduous forests
    {'ECO_ID',81210,'FaceColor',[0.927289 1.000000 0.642441]}, ... % Illyrian deciduous forests
    {'ECO_ID',81211,'FaceColor',[0.710576 1.000000 0.861605]}, ... % Italian sclerophyllous and semi-deciduous forests
    {'ECO_ID',81212,'FaceColor',[1.000000 0.809885 0.728748]}, ... % Mediterranean acacia-argania dry woodlands and succulent thickets
    {'ECO_ID',81213,'FaceColor',[0.671435 1.000000 0.534013]}, ... % Mediterranean dry woodlands and steppe
    {'ECO_ID',81214,'FaceColor',[1.000000 0.794632 0.555716]}, ... % Mediterranean woodlands and forests
    {'ECO_ID',81215,'FaceColor',[1.000000 0.762081 0.683246]}, ... % Northeastern Spain and Southern France Mediterranean forests
    {'ECO_ID',81216,'FaceColor',[0.729379 1.000000 0.678837]}, ... % Northwest Iberian montane forests
    {'ECO_ID',81217,'FaceColor',[0.993054 0.598253 1.000000]}, ... % Pindus Mountains mixed forests
    {'ECO_ID',81218,'FaceColor',[1.000000 0.755280 0.738169]}, ... % South Appenine mixed montane forests
    {'ECO_ID',81219,'FaceColor',[1.000000 0.541112 0.946759]}, ... % Southeastern Iberian shrubs and woodlands
    {'ECO_ID',81220,'FaceColor',[0.507799 1.000000 0.530204]}, ... % Southern Anatolian montane conifer and deciduous forests
    {'ECO_ID',81221,'FaceColor',[0.562475 1.000000 0.632100]}, ... % Southwest Iberian Mediterranean sclerophyllous and mixed forests
    {'ECO_ID',81222,'FaceColor',[0.518942 1.000000 0.696392]}, ... % Tyrrhenian-Adriatic Sclerophyllous and mixed forests
    {'ECO_ID',81301,'FaceColor',[0.729592 0.723250 1.000000]}, ... % Afghan Mountains semi-desert
    {'ECO_ID',81302,'FaceColor',[1.000000 0.919510 0.522707]}, ... % Alashan Plateau semi-desert
    {'ECO_ID',81303,'FaceColor',[0.545105 1.000000 0.705163]}, ... % Arabian Desert and East Sahero-Arabian xeric shrublands
    {'ECO_ID',81304,'FaceColor',[0.627263 1.000000 0.589097]}, ... % Atlantic coastal desert
    {'ECO_ID',81305,'FaceColor',[0.977346 0.500291 1.000000]}, ... % Azerbaijan shrub desert and steppe
    {'ECO_ID',81306,'FaceColor',[1.000000 0.892641 0.696303]}, ... % Badghyz and Karabil semi-desert
    {'ECO_ID',81307,'FaceColor',[1.000000 0.502316 0.685480]}, ... % Baluchistan xeric woodlands
    {'ECO_ID',81308,'FaceColor',[0.744367 1.000000 0.865721]}, ... % Caspian lowland desert
    {'ECO_ID',81309,'FaceColor',[0.885211 0.651195 1.000000]}, ... % Central Afghan Mountains xeric woodlands
    {'ECO_ID',81310,'FaceColor',[0.609244 1.000000 0.846173]}, ... % Central Asian northern desert
    {'ECO_ID',81311,'FaceColor',[0.947418 1.000000 0.609029]}, ... % Central Asian riparian woodlands
    {'ECO_ID',81312,'FaceColor',[1.000000 0.807484 0.632639]}, ... % Central Asian southern desert
    {'ECO_ID',81313,'FaceColor',[1.000000 0.639109 0.834069]}, ... % Central Persian desert basins
    {'ECO_ID',81314,'FaceColor',[0.699607 1.000000 0.751810]}, ... % Eastern Gobi desert steppe
    {'ECO_ID',81315,'FaceColor',[1.000000 0.700956 0.918888]}, ... % Gobi Lakes Valley desert steppe
    {'ECO_ID',81316,'FaceColor',[0.536942 0.931447 1.000000]}, ... % Great Lakes Basin desert steppe
    {'ECO_ID',81317,'FaceColor',[0.577215 1.000000 0.799793]}, ... % Junggar Basin semi-desert
    {'ECO_ID',81318,'FaceColor',[1.000000 0.655286 0.884861]}, ... % Kazakh semi-desert
    {'ECO_ID',81319,'FaceColor',[0.702437 1.000000 0.788091]}, ... % Kopet Dag semi-desert
    {'ECO_ID',81320,'FaceColor',[0.686094 1.000000 0.748217]}, ... % Mesopotamian shrub desert
    {'ECO_ID',81321,'FaceColor',[0.899042 1.000000 0.675766]}, ... % North Saharan steppe and woodlands
    {'ECO_ID',81322,'FaceColor',[1.000000 0.526049 0.849713]}, ... % Paropamisus xeric woodlands
    {'ECO_ID',81323,'FaceColor',[0.502260 1.000000 0.694826]}, ... % Persian Gulf desert and semi-desert
    {'ECO_ID',81324,'FaceColor',[1.000000 0.960162 0.729001]}, ... % Qaidam Basin semi-desert
    {'ECO_ID',81325,'FaceColor',[0.964870 0.663240 1.000000]}, ... % Red Sea Nubo-Sindian tropical desert and semi-desert
    {'ECO_ID',81326,'FaceColor',[0.727878 1.000000 0.933571]}, ... % Registan-North Pakistan sandy desert
    {'ECO_ID',81327,'FaceColor',[0.773819 1.000000 0.592341]}, ... % Sahara desert
    {'ECO_ID',81328,'FaceColor',[0.756424 0.687040 1.000000]}, ... % South Iran Nubo-Sindian desert and semi-desert
    {'ECO_ID',81329,'FaceColor',[0.643526 1.000000 0.870850]}, ... % South Saharan steppe and woodlands
    {'ECO_ID',81330,'FaceColor',[1.000000 0.681310 0.622719]}, ... % Taklimakan desert
    {'ECO_ID',81331,'FaceColor',[0.702730 1.000000 0.680384]}, ... % Tibesti-Jebel Uweinat montane xeric woodlands
    {'ECO_ID',81332,'FaceColor',[0.615429 1.000000 0.836401]}, ... % West Saharan montane xeric woodlands
    {'ECO_ID',81333,'FaceColor',[0.713957 1.000000 0.549370]}, ... % Red Sea coastal desert
    {'Default','FaceColor','k'});





