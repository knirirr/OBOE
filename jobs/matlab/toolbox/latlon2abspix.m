function [row,col,lat,lon] = latlon2abspix(r,lat,lon)

dlat = abs(r(1,2)); hlat = dlat ./ 2;
lat = (ceil(lat./dlat) .* dlat) - hlat;
lat = (floor(lat./dlat) .* dlat) + hlat;

dlon = abs(r(1,2)); hlon = dlon ./ 2;
lon = (floor(lon./dlon) .* dlon) + hlon;
lon = (ceil(lon./dlon) .* dlon) - hlon;
                     
[row,col] = latlon2pix(r,lat,lon);

row = round(row);
col = round(col);

% Check the reverse
% [mylat,mylon] = pix2latlon(r,row,col);






% assert(lat(1)>lat(2)) % North to South
% assert(lat(1)<=90)    % 90 to -90
% assert(lat(2)>=-90)
% 
% assert(lon(1)<lon(2)) % West to East
% assert(lon(1)>=-180)  % -180 to 180
% assert(lon(2)<=180)    
% 
% dlat = abs(r(1,2)); hlat = dlat ./ 2;
% lat(1) = (ceil(lat(1)./dlat) .* dlat) - hlat;
% lat(2) = (floor(lat(2)./dlat) .* dlat) + hlat;
% 
% dlon = abs(r(1,2)); hlon = dlon ./ 2;
% lon(1) = (floor(lon(1)./dlon) .* dlon) + hlon;
% lon(2) = (ceil(lon(2)./dlon) .* dlon) - hlon;
%                      
% [row,col] = latlon2pix(r,lat,lon);
% 
% row = round(row);
% col = round(col);
% 
% % Check the reverse
% % [mylat,mylon] = pix2latlon(r,row,col);
% 
