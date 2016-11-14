function data = countries(data)

%countryfile = fullfile(data.dir.data,'gadm','gadm_v2','gadm2.shp');
countryfile = fullfile(data.dir.data,'countries','TM_WORLD_BORDERS-0.3.shp');
try
    data.countries.shape = isintersect(data.gds,countryfile);
    data.countries.list = {data.countries.shape(:).NAME};
    data.countries.iso2 = {data.countries.shape(:).ISO2};
    logmsg(0,'List of countries:')
    for i = 1:numel(data.countries.list)
        logmsg(0,'    %s',data.countries.list{i})
    end
catch ME
    logmsg(ME,'Failed while getting the list of countries')
end    

% borders
% s = data.countries.shape;
% k = numel(s);
% x = []; 
% y = [];
% for i = 1:k-1
%     for j = i+1:k
%         [xi,yi,ii] = polyxpoly(s(i).X,s(i).Y,s(j).X,s(j).Y);
%         if ~isempty(xi)
%             x = [x;xi;nan]; 
%             y = [y;yi;nan];
%         end
%     end
% end
% data.countries.borders.X = x;
% data.countries.borders.Y = y;


function s = isintersect(poly,shapefile)
shape = shaperead(shapefile);
k = true(size(shape));
for i = 1:numel(shape)
    [shape(i).X_,shape(i).Y_] = polybool('intersection', ...
        poly.Lon,poly.Lat, ...
        shape(i).X,shape(i).Y);
    if isempty(shape(i).X_) && isempty(shape(i).Y_)
        k(i) = false;
    end
end
s = shape(k);

    



