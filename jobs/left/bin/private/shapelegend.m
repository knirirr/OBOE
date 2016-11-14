% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function shapelegend(writefile,shp,sym)

labels = {shp.ECO_NAME};
colors = sym.FaceColor{shp.ECO_ID,3};
n = numel(labels);
y = n:-1:1;
x = repmat(0.2,1,n);


figure
axis([0 1 1 n])
axis off
text(x,y,labels)

v = 0.4;
for i = 1:n
    patch([0 0 .1 .1],[y(i)-v y(i)+v y(i)+v y(i)-v],sym.FaceColor{i,3})
    disp(labels{i})
    disp(sym.FaceColor{i,3})
end


return
