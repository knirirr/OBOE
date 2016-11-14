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
function [u,s,data] = gbifdata(data)

try
    x = getgbifdata(olat1,olat2,olon1,olon2);
    [lat_{1:numel(x)}] = deal(x.latitude);
    [lon_{1:numel(x)}] = deal(x.longitude);
    lat = str2double(lat_)';
    lon = str2double(lon_)';
    [u,i,j] = unique([lon lat],'rows');
    s = histc(j,1:numel(i));
    numberofgbifrecords = numel(x);
    data.number_of_gbif_records = sprintf('%i',numberofgbifrecords);
    numberofuniquelocalities = numel(i);
    data.number_of_unique_localities = sprintf('%i',numberofuniquelocalities);
catch ME
end   


% % ------------------------------------------------------------------------
% % Figure 001
% h = scatterm(u(:,2),u(:,1),s.*4,s);
% axis equal; box on
% axis([olon1 olon2 olat1 olat2])
% colorbar
% drawnow
% figurecount = figurecount + 1;
% saveas(h,fullfile(file.outputimages,sprintf('image%03i',figurecount)),'png')
% close






