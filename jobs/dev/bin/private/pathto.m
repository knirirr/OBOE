function data = pathto(data)

host = data.job.host;
type = data.job.type;

switch host
    case 'gecko'
        root = fullfile('C:','Users','Neil','Documents','SVN','jobs',type,'');
    otherwise
        root = fullfile('C:','Users','oerc0003','Documents','SVN','jobs',type,'');
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

