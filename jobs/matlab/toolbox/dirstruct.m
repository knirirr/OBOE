function v = dirstruct(pathstr,varargin) %#ok<STOUT>
% DIRSTRUCT     Produce a struct with fields that match a directory structure
%
% Copyright 2012, neil.caithness@oerc.ox.ac.uk

if numel(varargin) && strcmp(varargin{1},'ignore')
    ignore = varargin{2};
else
    ignore = {''};
end
if ~strcmp(pathstr(end),filesep)
    pathstr = [pathstr filesep];
end

[s,t] = deal(sub({},pathstr,ignore));
if isempty(s)
    v = [];
    return
end

s = regexprep(s,regexprep(pathstr,'\','\\\'),'');
s = regexprep(s,'[^a-z_A-Z0-9\\]','_');
s = regexprep(s,'[\\]','#');
s = regexprep(s,'#_','#x_');
s = regexprep(s,'#(\d)','#d$1_');
for i = 1:numel(s)
    u = regexp(s{i},'#','split');
    try
        eval([sprintf('v%s',sprintf('.%s',u{:})) '=''' t{i} ''';']);
    catch ME %#ok<NASGU>
        fprintf('Can''t translate path at %s',t{i})
    end
end

        
function s = sub(s,pathstr,exclude)
d = dir(pathstr);
for i = 1:numel(d)
    if d(i).isdir
        if isempty(intersect(d(i).name,{'..' '.' exclude{:}})) %#ok<CCAT>
            s = sub(s,fullfile(pathstr,d(i).name),exclude);
        end
    else
        s{end+1} = fullfile(pathstr,d(i).name); %#ok<AGROW>
    end
end
        
