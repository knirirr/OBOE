function mymapsettings

setm(gca,'FEdgeColor','none')
setm(gca,'MLabelParallel','north');
setm(gca,'PLabelMeridian','east');
setm(gca,'LabelRotation','on');
setm(gca,'FontColor','blue');

% projection  
idstr = getm(gca,'MapProjection');
idlist = cellstr(maps('idlist'));
namelist = cellstr(maps('namelist'));
namestr = char(namelist(strcmp(idlist,idstr)));
caption = sprintf('%s',namestr);
g = get(gca);
yloc = g.YLim(1) - (g.YLim(2) - g.YLim(1)) .* 0.025;
xloc = g.XLim(1);
text(xloc,yloc,caption, ...
    'Color','blue', ...
    'HorizontalAlignment','left', ...
    'FontSize',9, ...
    'FontAngle','italic');

% scaleruler 
g = get(gca);
yloc = g.YLim(1) + (g.YLim(2) - g.YLim(1)) .* 0.025;
scaleruler( ...
    'Color','blue', ...
    'YLoc',yloc, ...
    'ZLoc',1);

