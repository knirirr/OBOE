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
