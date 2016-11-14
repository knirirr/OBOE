% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function s = coordinates(str,signcode)

signval = 1;

if nargin<2
    signcode = 'none';
end

if isnumeric(str)
    str = num2str(str);
end

s.deg.num = nan;
s.deg.str = '';
s.dms.num = [nan nan nan];
s.dms.str = '';

try
    % Remove minus signs as separators
    if regexp(str,'[NSEW]')
        str = regexprep(str,'-',' ');
    end

    % Replace [N,S,E,W] with appropriate sign
    if regexp(str,'N')
        signcode = 'ns';
        signval = 1;
        str = regexprep(str,'N','');
    end
    if regexp(str,'S')
        signcode = 'ns';
        signval = -1;
        str = regexprep(str,'S','');
    end
    if regexp(str,'E')
        signcode = 'ew';
        signval = 1;
        str = regexprep(str,'E','');
    end
    if regexp(str,'W')
        signcode = 'ew';
        signval = -1;
        str = regexprep(str,'W','');
    end

    % Replace all non 'numeric' characters with spaces
    str = regexprep(str,'[^-.0123456789e]',' ');

    % Try reading STR as decimal degrees
    s.deg.num = str2double(str);

    % If that didn't work, try reading STR as numeric DMS
    if isnan(s.deg.num)
       s.deg.num = dms2degrees(str2num(str)) .* signval;
    end
    
    % If even that didn't work, try a custom reading as parts
    if isnan(s.deg.num)
        parts = regexp(str,'(?<degrees>[-\d]+)\s+(?<minutes>\d+)\s+(?<seconds>\d+)\.?(?<fraction>\d+)?','names');
        dms = [str2double(parts.degrees) str2double(parts.minutes) str2double([parts.seconds '.' parts.fraction])];
        s.deg.num = dms2degrees(dms) .* signval;
    end

    % Finally, return the alternative string and numeric representations
    if ~isnan(s.deg.num)
        s.deg.str = sprintf('% 0.4f',s.deg.num);
        s.dms.num = degrees2dms(s.deg.num);
        str = angl2str(s.deg.num,signcode,'degrees2dms');
        s.dms.str = regexprep(str,'\^{\\circ}',char(176)); %degree symbol
    end
catch ME
    % TODO Action on catch
end

    
