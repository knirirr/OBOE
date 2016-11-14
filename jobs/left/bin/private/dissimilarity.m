% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
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
