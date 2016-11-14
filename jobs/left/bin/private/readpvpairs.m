% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function args = readpvpairs(argsfile)

str = fileread(argsfile);
str = regexprep(str,'^\s*"','');
str = regexprep(str,'"\s*$','');
str = regexp(str,'"\s*,\s*"','split');
str = deblank(str);

args = struct(str{:});
