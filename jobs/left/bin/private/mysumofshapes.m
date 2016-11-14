% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function z = mysumofshapes(refmat, size, shapes)


% Using INPOLY from the File Exchange - much faster than INPOLYGON.
% From the File Exchange - Fast points-in-polygon test

z = zeros(size);
n = prod(size);
[Y,X] = ind2sub(size, 1:n);
for i = 1:numel(shapes)
    edges = createEdges([shapes(i).Lat shapes(i).Lon]);
    [y,x] = latlon2abspix(refmat, shapes(i).Lat, shapes(i).Lon);
    z(:) = z(:) + inpoly([X' Y'],[x y],edges);
end


function  edges = createEdges(shp)

shpEnd = find(isnan(shp(:,1))); 
shpEnd = vertcat(0,shpEnd,length(shp(:,1))+1); 
edges = nan(length(shp(:,1))-length(shpEnd),2); 
count = 1; 
for j=1:length(shpEnd)-1 
    endCount = count+length((shpEnd(j)+1:shpEnd(j+1)-2)); 
    edges(count:endCount,:) = [(shpEnd(j)+1:shpEnd(j+1)-2)' ... 
    (shpEnd(j)+2:shpEnd(j+1)-1)';shpEnd(j+1)-1 shpEnd(j)+1]; 
    count = endCount+1; 
end

% 01 Jul 2011
% Luke
% Great and fast little tool. Much faster than matlab inpolygon. My only
% issue is that I wish it natively understood the typical "GIS" format for
% polygons which includes a NaN separated list of polygons (NaNs separate
% the major outline from the 'islands').
% 
% Of course you can just handle this with the edges field though, so for
% future reference, here's my simple create edges code for NaN separated
% GIS objects. 'shp' variable is n Nx2 matrix of latitudes and longitudes.
% 
%     shpEnd = find(isnan(shp(:,1))); 
%     shpEnd = vertcat(0,shpEnd); % NB See changes above
%     edges = nan(length(shp(:,1))-length(shpEnd),2); 
%     count = 1; 
%     for j=1:length(shpEnd)-1 
%         endCount = count+length((shpEnd(j)+1:shpEnd(j+1)-2)); 
%         edges(count:endCount,:) = [(shpEnd(j)+1:shpEnd(j+1)-2)' ... 
%         (shpEnd(j)+2:shpEnd(j+1)-1)';shpEnd(j+1)-1 shpEnd(j)+1]; 
%         count = endCount+1; 
%     end



% Original version using INPOLYGON - very slow.
% 
% z = zeros(size);
% n = prod(size);
% [Y,X] = ind2sub(size, 1:n);
% for i = 1:numel(shapes)
%     [y,x] = latlon2abspix(refmat, shapes(i).Lat, shapes(i).Lon);
%     z(:) = z(:) + inpolygon(X,Y,x,y)';
% end


% Segmented verion trying to give INPOLYGON smaller problems in an attempt
% to speed it up for big problem sizes - doesn't help much.
%
% z = zeros(size);
% n = prod(size);
% incr = 10000;
% [Y,X] = ind2sub(size, 1:n);
% for i = 1:numel(shapes)
%     % logmsg(0,'Processing shape %i',i)
%     [y,x] = latlon2abspix(refmat, shapes(i).Lat, shapes(i).Lon);
%     for j = 1:incr:n
%         k = min(j+incr-1,n);
%         z(j:k) = z(j:k) + inpolygon(X(j:k),Y(j:k),x,y);
%     end
% end