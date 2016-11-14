function cde(argsfile)
% CDE  Compile target for CDE jobs on the OBOE automation server.
%
%   CDE inputfile
%
% Compile options:
%   mcc -m -N -p map -p stats -p images cde.m
%
% Copyright 2012-2013, neil.caithness@oerc.ox.ac.uk

% ------------------------------------------------------------------------
% Warning states
warning on all
warning on verbose
warning on backtrace
warning off MATLAB:MKDIR:DirectoryExists
warning off map:geotiff:clampingLatitudeCorner
% warning off map:geotiffinfo:tiffWarning
% warning off map:geotiff:undefinedGTModelTypeGeoKey
% ------------------------------------------------------------------------
% Initialize the DATA structure that holds job parameters, global
% constants, path to files, etc. 
data = config; % (NB. CONFIG is a local function in this file)
% ------------------------------------------------------------------------
logmsg(0,'Running as a %s application on %s',data.job.mode,data.job.hostname);
logmsg(0,'Reported version number is %s',data.job.version);
% ------------------------------------------------------------------------
% Read the input file 
data.args = readpvpairs(argsfile); % (NB. READPVPAIRS is a local function)
logmsg(0,'----------------------------------------')
logmsg(0,'Submitter: %s',    data.args.jobsubmitter)
logmsg(0,'Title: %s',        data.args.jobtitle)
logmsg(0,'Description: %s',  data.args.jobdescription)
logmsg(0,'JobID: %s',        data.args.jobid)
logmsg(0,'----------------------------------------')
clear argsfile
% Check the ID from the ARGSFILE against the ID inferred earlier from the
% working directory.
assert(isequal(data.job.id,data.args.jobid));
% ------------------------------------------------------------------------
% Set the development flags 
data = devflags(data); % (NB. DEVFLAGS is a local function in this file)
% ------------------------------------------------------------------------
% Set the job status flags
data.job.status  = '';
data.job.exception  = '';
% ------------------------------------------------------------------------
% Timestamp at start
data.job.start = datestr(now);
% ------------------------------------------------------------------------
% Call MAIN
logmsg(0,'MAIN started at %s',datestr(now));
tic, data = main(data); elapsed_time = toc;
data.job.elapsed_time = sprintf('%0.2f',elapsed_time);
logmsg(0,'MAIN completed in %i minutes',ceil(elapsed_time./60));
logmsg(0,'----------------------------------------')
clear elapsed_time
% ------------------------------------------------------------------------
% Timestamp at stop
data.job.stop = datestr(now);
% ------------------------------------------------------------------------
% Write output.htm
switch data.job.status
    case 'Success'
        whichtemplate = data.dir.work.output.output_template_htm;
    otherwise
        whichtemplate = data.dir.work.output.error_template_htm;
        logmsg(1,'Using HTM error template')
end
try
    % Write using the template, but first remove some fields from DATA
    write2template(rmfield(data,{'dir' 'devflags'}), ...
        whichtemplate,data.dir.work.output.output_htm);
    logmsg(0,'Output HTM file written')
catch ME
    logmsg(ME,'Output HTM file failed')
end
try
    delete(data.dir.work.output.output_template_htm)
    delete(data.dir.work.output.error_template_htm)
catch ME
    logmsg(ME,'Can''t delete HTM template files')
end
clear whichtemplate
% ------------------------------------------------------------------------
% Write output.pdf
try
    html2pdf( ...
        data.dir.work.output.output_htm, ...
        data.dir.work.output.output_pdf);
    if exist(data.dir.work.output.output_pdf,'file')
        logmsg(0,'Output PDF file written')
    else
        logmsg(1,'Output PDF file NOT written')
    end
catch ME
    logmsg(ME,'Output PDF file failed')
end
% ------------------------------------------------------------------------
% Remove the temp directory
try
    delete(fullfile(data.dir.work.output__,'temp','*.*'))
    rmdir(fullfile(data.dir.work.output__,'temp',''))
catch ME
    logmsg(ME,'Can''t delete TEMP directory')
end
% ------------------------------------------------------------------------
% Remove output files and directories that we don't want to distribute
try
    delete(fullfile(data.dir.work.output__,'output.htm'))
    delete(fullfile(data.dir.work.output__,'images','icons','*.*'))
    delete(fullfile(data.dir.work.output__,'images','logos','*.*'))
    rmdir(fullfile(data.dir.work.output__,'images','icons',''))
    rmdir(fullfile(data.dir.work.output__,'images','logos',''))
catch ME
    logmsg(ME,'Can''t delete OUTPUT files or folders')
end
% ------------------------------------------------------------------------
% Completion log and console messages
switch data.job.status
    case 'Success'
        logmsg(0,'Job completed successfully\n\n')
        fprintf(1,'\n[OBOE:%s:%s][Exit status = 0]\n', ...
            upper(data.job.type),upper(data.job.hostname));
    otherwise
        logmsg(1,'Job failed!\n%s\n\n',data.job.exception);
        fprintf(2,'\n[OBOE:%s:%s][Exit status = 1]\n', ...
            upper(data.job.type),upper(data.job.hostname));
end
% ------------------------------------------------------------------------
% Send email notifications
if isdeployed
    addressFile = fullfile('V:','Jobs','config','notify.txt');
    if exist(addressFile,'file')
        try
            emailprefs; % sets smtp preferences
            address = fileread(addressFile); 
            subject = sprintf('OBOE/%s job completed',data.job.type);
            message = fileread(logmsg); % returns file location
            attachment = data.dir.work.output.output_pdf;
            if exist(attachment,'file')
                sendmail(address,subject,message,attachment);
            else
                sendmail(address,subject,message);
            end
        catch ME
            logmsg(ME,'Email notifications NOT sent')
        end
    end
end
clear addressFile address subject message attachment
% ------------------------------------------------------------------------



% ------------------------------------------------------------------------
% READPVPAIRS
function args = readpvpairs(argsfile)
str = fileread(argsfile);
str = regexprep(str,'^\s*"',''); % remove leading "
str = regexprep(str,'"\s*$',''); % remove trailing "
str = regexp(str,'"\s*,\s*"','split'); % split on ","
str = deblank(str);
args = struct(str{:});
% ------------------------------------------------------------------------



% ------------------------------------------------------------------------
% DEVFLAGS
function data = devflags(data)
fields = fieldnames(data.args);
mydevflags = { 'main' };
% default values
data.devflags.main = 1;   
% setting from input file
for i = find(ismember(mydevflags,fields))'
    switch data.args.(mydevflags{i})
        case 'yes'
            data.devflags.(mydevflags{i}) = 1;
        case 'no'
            data.devflags.(mydevflags{i}) = 0;
    end
end
% ------------------------------------------------------------------------



% ------------------------------------------------------------------------
% CONFIG
function data = config
% Initialize the DATA struct that is used to hold job parameters, global
% constants, the path to files, etc.
%
% DIRSTRUCT is used to map a directory structure onto a Matlab struct with
% fields. Name mapping isn't perfect, but if it is kept simple then this
% approach can be quite useful.
%
% The local copies of TYPE and USER are uneccessary but convenient.
% ------------------------------------------------------------------------
% Job TYPE and ID
data.job = regexp(pwd,'\\WORK\\(?<type>\w+)\\(?<id>\w+)\\input','names');
% NB. Don't try inferring the job TYPE by useing MFILENAME, it returns ''
% when deployed. Instead we infer both TYPE and ID from the working
% directory. We can check TYPE against MFILENAME when not deployed, and
% later check ID against the input file entry after reading ARGSFILE.
assert(~isempty(data.job),'Working directorty is not correct')
if ~isdeployed, assert(isequal(data.job.type,mfilename)); end
TYPE = data.job.type;
% ------------------------------------------------------------------------
% HOSTNAME
data.job.hostname = getenv('computername'); 
% ------------------------------------------------------------------------
% USERNAME
data.job.username = getenv('username'); 
USER = data.job.username;
% ------------------------------------------------------------------------
% MODE
if isdeployed
    data.job.mode = 'deployed';
else
    data.job.mode = 'native';
end
% ------------------------------------------------------------------------
% VERSION
%   The shared V:\Jobs folder may not be available on development machines
%   so have 'not available' as the default
data.job.version = 'not available';
versionFile = fullfile('V:','Jobs',TYPE,'version.txt');
if exist(versionFile,'file')
    data.job.version = deblank(fileread(versionFile)); 
end
% ------------------------------------------------------------------------
% COPYRIGHT
data.job.copyright = sprintf('2010-%s',datestr(now,'yyyy'));
% ------------------------------------------------------------------------
% DATA = location of data folders
%   There are two possibilities:
%       a network folder identified as V:\data
%       or a local folder C:\Users\_username_\Documents\DATA
remote = fullfile('V:','data','');
local = fullfile('C:','Users',USER,'Documents','DATA','');
if ~isempty(dir(remote)), data.dir.data = remote;
elseif ~isempty(dir(local)), data.dir.data = local;
else error('OBOE:PATHTO:NoDataDirectories', ...
        'No local or remote data directories found.\nLooking for:\n\t%s\n\t%s', ...
        remote,local)
end
% ------------------------------------------------------------------------
% ROOT = source files for this job TYPE
%   This is most likely an SVN repository
root = fullfile('C:','Users',USER,'Documents','SVN','jobs',TYPE,'');
data.dir.root = dirstruct(root,'ignore',{'private'});
% ------------------------------------------------------------------------
% IMAGES = common images 
%   This is most likely also in the SVN repository
images = fullfile('C:','Users',USER,'Documents','SVN','jobs','images','');
data.dir.images = dirstruct(images);
% ------------------------------------------------------------------------
% WORK = working directory
work = fullfile(regexprep(pwd,'\\input',''));
% ------------------------------------------------------------------------
% Copy the contents of the root\output
copyfile(fullfile(root,'output',''),fullfile(work,'output',''));
% ------------------------------------------------------------------------
% Then explicitely copy the logos
%   The default template uses the following logos:
%   UOXF, OERC, VIBRANT, QRCODE and CC_licence
logos_source = fullfile(images,'logos','');
logos_destination = fullfile(work,'output','images','logos','');
copyfile(logos_source, logos_destination);
% ------------------------------------------------------------------------
% ... and copy the icons
%   Choose 10 icons at random for the default template
icons_destination = fullfile(work,'output','images','icons','');
names = fieldnames(data.dir.images.icons);
numicons = 10; assert(numel(names)>=numicons);
k = randperm(numel(names),numicons);
for i = 1:numicons
    copyfile(data.dir.images.icons.(names{k(i)}), ...
        fullfile(icons_destination,sprintf('icon_%i.png',i)));
end
% ... and copy the specific icon for this job TYPE
copyfile(data.dir.images.icons.(sprintf('icon_%s_png',TYPE)), ...
    fullfile(icons_destination,'icon_dev.png'));
% ------------------------------------------------------------------------
% Now make the working directory structure
data.dir.work = dirstruct(work);
% ------------------------------------------------------------------------
% Add the path name for the output directory
%   Useful later when we want to add files to the output
data.dir.work.output__ = fullfile(work,'output','');
% ------------------------------------------------------------------------
% Finally, add some names for files that don't exist yet
data.dir.work.output.output_htm = fullfile(work,'output','output.htm');
data.dir.work.output.output_pdf = fullfile(work,'output','output.pdf');
% ------------------------------------------------------------------------

