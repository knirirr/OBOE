function str = write2template(data,template,output)

% Add the all_fields_table entry 
try
    table = '<table border="0" style="font-family:Courier New; font-size:10px; color:#4F81BD">'; 
    data.all_fields_table = sprintf('%s%s</table>',table,all_fields_table(data,'',''));
catch ME
    logmsg(1,'Failed writing all_fields_table entry')
end

% Replace text fields throughout
str = fileread(template);
str = replace_fields(data,'',str);
str = deblank(str);

if nargin>2
    fid = fopen(output,'w+');
    fprintf(fid,'%s',str);
    fclose(fid);
end

if ~nargout
    clear str
end


% ------------------------------------------------------------------------
function str = replace_fields(data,prefix,str)
fields = fieldnames(data);
for i = 1:numel(fields)
    if isstruct(data.(fields{i}))
        try
            str = replace_fields( ...
                data.(fields{i}), ... 
                sprintf('%s%s\\.',prefix,fields{i}), ...
                str);
        catch ME
            logmsg(1,'Fields not replaced at field: %s',fields{i})
        end
    elseif ischar(data.(fields{i}))
        str = regexprep(str, ...
            sprintf('\\[%s%s\\]',prefix,fields{i}), ...
            regexprep(data.(fields{i}),'\\','\\\\'));
        str = regexprep(str, ...
            sprintf('%%5b%s%s%%5d',prefix,fields{i}), ...
            regexprep(data.(fields{i}),'\\','\\\\'));
    end
end


% ------------------------------------------------------------------------
function tbl = all_fields_table(data,prefix,tbl)
fields = fieldnames(data);
for i = 1:numel(fields)
    if isstruct(data.(fields{i}))
        tbl = all_fields_table( ... 
            data.(fields{i}), ... 
            sprintf('%s%s.',prefix,fields{i}), ...
            tbl);
    elseif ischar(data.(fields{i}))
        tbl = [tbl sprintf('<tr><td valign="top">%s</td><td>%s</td></tr>', ...
            sprintf('%s%s',prefix,fields{i}), ...
            data.(fields{i}))];
    end
end
