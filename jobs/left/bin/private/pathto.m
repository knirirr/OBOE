% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function data = pathto(data)

host = deblank(evalc('!hostname'));

% self = char(regexp(mfilename('fullpath'),'jobs[\\/](.+)[\\/]bin','tokens','once'));
% MFILENAME returns '' when deployed. Use DBSTACK instead.
dbs = dbstack;
self = dbs(end).name;
if strcmp(self,'poll')
    self = dbs(end-1).name;
end

switch host
    case 'gecko'
        root = fullfile('C:','Users','Neil','Documents','SVN','jobs',self,'');
    % case {'nyogtha' 'syncerus' 'hippotragus'}
    otherwise
        root = fullfile('C:','Users','oerc0003','Documents','SVN','jobs',self,'');
    % otherwise
    %     error('Host name "%s" is not configured.',host);
end

data.file.templateimages         = fullfile(root,'templates','images','');
data.file.outputtemplate         = fullfile(root,'templates','output_template.htm');
data.file.mobiletemplate         = fullfile(root,'templates','mobile_template.htm');
data.file.errortemplate          = fullfile(root,'templates','error_template.htm');
data.file.left_exe               = fullfile(root,'bin','left.exe');
data.file.left_m                 = fullfile(root,'bin','left.m');
data.file.main                   = fullfile(root,'bin','private','main.m');

% Absolute paths from ...\WORK\<jobid>\input\
home = regexprep(pwd,'\\input','');
input = fullfile(home,'input');
output = fullfile(home,'output');
temp = fullfile(home,'temp');

data.file.inputdata              = fullfile(input,'data','');
data.file.outputdata             = fullfile(output,'data','');
data.file.gbifdatain             = fullfile(input,'data','gbif','');
data.file.gbifdata               = fullfile(output,'data','gbif','');
data.file.gdmdatain              = fullfile(input,'data','gdm','');
data.file.gdmdata                = fullfile(output,'data','gdm','');
data.file.outputimages           = fullfile(output,'images','');
data.file.qrcode                 = fullfile(output,'images','extras','qrcode.png');
data.file.argsfile               = fullfile(input,'args.txt');
data.file.mat                    = fullfile(output,'data.mat');
data.file.txt                    = fullfile(output,'data.txt');
data.file.html                   = fullfile(output,'output.html');
data.file.pdf                    = fullfile(output,'output.pdf');
data.file.mobile_html            = fullfile(output,'output_mobile.html');
data.file.mobile_pdf             = fullfile(output,'output_mobile.pdf');
data.file.logfile                = fullfile(output,'logfile.txt');
data.file.zip                    = fullfile(home,[data.job.id '.zip']);
data.file.finished               = fullfile(home,[data.job.id '.finished']);
data.file.layers                 = fullfile(temp,'layers','');
data.file.projection             = fullfile(temp,'projection','projection.asc');

% URLs
data.url.long                    = ['http://vibrant.oerc.ox.ac.uk/download/' data.job.id];
data.url.short                   = ['http://vibrant.oerc.ox.ac.uk/download/' data.job.id];
data.url.plus                    = '';
data.url.qrcode                  = '';

