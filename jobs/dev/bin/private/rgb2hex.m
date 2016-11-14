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