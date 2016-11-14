% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function str = write2template(data,template,output)

str = fileread(template);
fields = fieldnames(data);
[~,~,ext] = fileparts(template);

switch lower(ext)
    case {'.htm','.html'}
        ldel = '&lt;&lt;&lt;';
        rdel = '&gt;&gt;&gt;';
    otherwise
        ldel = '<<<';
        rdel = '>>>';
end

for i = 1:numel(fields)
    str = regexprep(str,sprintf('%s%s%s',ldel,fields{i},rdel),data.(fields{i}));
end

str = deblank(str);
if nargin>2
    fid = fopen(output,'w+');
    fprintf(fid,'%s',str);
    fclose(fid);
end

