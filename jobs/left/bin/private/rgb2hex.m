% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function hex = rgb2hex(mat)

if all(mat(:)>=0) && all(mat(:)<=1)
    mat = round(mat.*255);
end
if any(mat(:)<0) || any(mat(:)>255)
    error('Color spec out of range')
end
m = size(mat,1);
hex = cell(m,1);
for i = 1:m
    hex{i} = sprintf('#%s%s%s', ...
        dec2hex(mat(i,1),2), ...
        dec2hex(mat(i,2),2), ...
        dec2hex(mat(i,3),2));
end