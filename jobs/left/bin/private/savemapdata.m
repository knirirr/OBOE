% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function savemapdata(data,name)

filename = fullfile(data.file.outputdata,[name '.tif']);
geotiffwrite(filename,data.map.(name).a,data.map.(name).refmat)
