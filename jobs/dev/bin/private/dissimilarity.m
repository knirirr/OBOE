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
function data = dissimilarity(data)

% create the data tables for GDM
try 
    if ~numel(dir(fullfile(data.file.gdmdatain,'*.txt')))
        data = gdmtables(data);
    else
        logmsg(0,'GDM data tables found so no new files written')
    end
catch ME
    logmsg(ME,'GDM data tables failed')
end

try 
    [m,n] = size(data.map.mask.a);
    
    v = nan(m,n,10);
    for i = 1:10
        logmsg(0,'Iteration %i of GDM',i)
        [data,betadiv] = gdm_R(data);
        betadiv(~data.map.mask.a) = nan;
%         d = sort(betadiv(:));
%         x = 0 : 0.001 : 1;
%         n = histc(d,x);
%         k = n>(numel(d).*0.01);
%         x = x(k);
%         betadiv(betadiv<x(1)) = x(1);
%         betadiv(betadiv>x(end)) = x(end);
        v(:,:,i) = normalise(betadiv);
    end
    betadiv = nanmedian(v,3);

    betadiv = normalise(betadiv);
    
    data.map.dissimilarity.a = betadiv;
    data.map.dissimilarity.bbox = data.map.mask.bbox;
    data.map.dissimilarity.refmat = data.map.mask.refmat;
    data.map.dissimilarity.info = data.map.mask.info;
    
    % show
    data.map.dissimilarity.color.type = 'continuous';
    % data.map.dissimilarity.color.caxis = [x(1) x(end)];
    data.map.dissimilarity.color.colorbar = 'on';
    mygeoshow(data.map.dissimilarity, data.map.mask.a);

    % save
    set(gcf,'Renderer','zbuffer')
    saveas(gcf,fullfile(data.file.outputimages, 'Fig 5 - Dissimilarity.png'))
    close
    
    
    
    
catch ME
    logmsg(ME,'GDM map failed')
end
