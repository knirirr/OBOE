% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function left(argsfile)
% LEFT  Compile target for LEFT jobs on the VIBRANT/OBOE automation server.
%
%   LEFT args.txt
%
% Compile options:
%   mcc -m -N -p map -p stats -p images left.m

% ------------------------------------------------------------------------
clc
% ------------------------------------------------------------------------
% Warning states
warning on all
warning off verbose
warning off backtrace
warning off MATLAB:MKDIR:DirectoryExists
warning off map:geotiffinfo:tiffWarning
warning off map:geotiff:undefinedGTModelTypeGeoKey
warning off map:geotiff:clampingLatitudeCorner
% ------------------------------------------------------------------------
% Timestamp - first call to logmsg will create the logfile
logmsg(0,'LEFT job started at %s',datestr(now));
% ------------------------------------------------------------------------
% Running as deployed?
host = deblank(evalc('!hostname'));
if isdeployed
    logmsg(0,'Running as a deployed application on %s',upper(host));
else
    logmsg(0,'Running as a native application on %s',upper(host));
end
% ------------------------------------------------------------------------
% Check the working directory - 
%   should be C:\Users\<user>\Documents\WORK\left\<jobid>\input
if isempty(regexp(pwd,'\\WORK\\left\\\w+\\input','once'))
    logmsg(1,'Working directory is not correct -\n\n %s\n',pwd);
    return
end
% ------------------------------------------------------------------------
% Make the output directory
try
    mkdir('..\output');
catch ME
    logmsg(ME,'Can''t make output directory')
    rethrow(ME)
end
% ------------------------------------------------------------------------
% We should now be in the right place, with the right directories
% ------------------------------------------------------------------------
% Read the args file
try 
    data.args = readpvpairs(argsfile);
catch ME
    logmsg(ME,'Args file not read')
    rethrow(ME)
end
% ------------------------------------------------------------------------
% Set the dev flags
fields = fieldnames(data.args);
devflags = {
    'location' 
    'streetmap'
    'globcover' 
    'ecoregions' 
    'speciesrecords' 
    'betadiversity' 
    'vulnerability' 
    'fragmentation' 
    'migratoryspecies' 
    'hydrosheds' 
    'resilience' 
    'summary' };
% default values
data.dev.location            = 1;    % Figure 1a & 1b
data.dev.streetmap           = 1;    % Figure 1c
data.dev.globcover           = 1;    % Figure 2
data.dev.ecoregions          = 1;    % Figure 3
data.dev.speciesrecords      = 1;    % Figure 4
data.dev.betadiversity       = 1;    % Figure 5
data.dev.vulnerability       = 1;    % Figure 6
data.dev.fragmentation       = 1;    % Figure 7
data.dev.migratoryspecies    = 1;    % Figure 8
data.dev.hydrosheds          = 1;    % Figure 9
data.dev.resilience          = 1;    % Figure 10
data.dev.summary             = 1;    % Figure 11
% setting from args.txt
for i = find(ismember(devflags,fields))'
    switch data.args.(devflags{i})
        case 'yes'
            data.dev.(devflags{i}) = 1;
        case 'no'
            data.dev.(devflags{i}) = 0;
    end
end
% ------------------------------------------------------------------------
% Read coordinates and calculate bounding box
%
% %% PS. no attempt here to actually parse WKT - just find the bounding box
coords = regexprep(data.args.coords,'[^\d\.-]',' ');
coords = sscanf(coords,'%f %f');
coords = reshape(coords,2,numel(coords)./2)';

data.args.minlatitude = min(coords(:,1));
data.args.maxlatitude = max(coords(:,1));
data.args.minlongitude = min(coords(:,2));
data.args.maxlongitude = max(coords(:,2));
% ------------------------------------------------------------------------
% Add job specific details
data.job.status         = 'Success';
data.job.exception      = 'None';
tnow = now;
data.job.elapsed_time   = 'null';
data.job.start_iso      = datestr(tnow,30);
data.job.start_date     = datestr(tnow,'dd mmmm yyyy');
data.job.start_time     = datestr(tnow,'HH:MM:SS.FFF');
data.job.host           = deblank(evalc('!hostname'));
data.job.submitter      = data.args.jobsubmitter;
data.job.title          = data.args.jobtitle;
data.job.description    = data.args.jobdescription;
data.job.id             = data.args.jobid;
logmsg(0,'Submitter: %s',data.job.submitter)
logmsg(0,'Title: %s',data.job.title)
logmsg(0,'Description: %s',data.job.description)
logmsg(0,'JobID: %s',data.job.id)
logmsg(0,'North latitude: %f',data.args.maxlatitude)
logmsg(0,'South latitude: %f',data.args.minlatitude)
logmsg(0,'West longitude: %f',data.args.minlongitude)
logmsg(0,'East longitude: %f',data.args.maxlongitude)
% ------------------------------------------------------------------------
% Get path to files
try 
    data = pathto(data);
catch ME
    logmsg(ME,'Can''t set path to files')
    rethrow(ME)
end
% ------------------------------------------------------------------------
% Make image directories and copy static image files
%   avoid .svn folders by copying individual files, not whole folders
try 
    outputimages = data.file.outputimages;
    templateimages = data.file.templateimages;
    logosdir = fullfile(outputimages,'logos');
    extrasdir = fullfile(outputimages,'extras');
    mkdir(outputimages);
    mkdir(logosdir);
    mkdir(extrasdir);
    % default pics - puppy playing dead
    copyfile(fullfile(templateimages,'Fig 2 - Globcover.png'),fullfile(outputimages));
    copyfile(fullfile(templateimages,'Fig 3 - Ecoregions.png'),fullfile(outputimages));
    copyfile(fullfile(templateimages,'Fig 4 - Species Records.png'),fullfile(outputimages));
    copyfile(fullfile(templateimages,'Fig 5 - Dissimilarity.png'),fullfile(outputimages));
    copyfile(fullfile(templateimages,'Fig 6 - Vulnerability.png'),fullfile(outputimages));
    copyfile(fullfile(templateimages,'Fig 7 - Fragmentation.png'),fullfile(outputimages));
    copyfile(fullfile(templateimages,'Fig 8 - Migratoryspecies.png'),fullfile(outputimages));
    copyfile(fullfile(templateimages,'Fig 9 - Wetland.png'),fullfile(outputimages));
    copyfile(fullfile(templateimages,'Fig 10 - Resilience.png'),fullfile(outputimages));
    copyfile(fullfile(templateimages,'Fig 11 - Summary.png'),fullfile(outputimages));
    % logos
    copyfile(fullfile(templateimages,'logos','uoxf_logo.gif'),logosdir);
    copyfile(fullfile(templateimages,'logos','oerc_logo.gif'),logosdir);
    copyfile(fullfile(templateimages,'logos','bioinst_logo.jpg'),logosdir);
    copyfile(fullfile(templateimages,'logos','statoil_logo.png'),logosdir);
    % extras
    copyfile(fullfile(templateimages,'extras','qrcode.png'),extrasdir);
catch ME
    logmsg(ME,'Can''t copy image files')
    rethrow(ME)
end
% ------------------------------------------------------------------------
% Make the directory for data files
try
    mkdir(data.file.outputdata);
    mkdir(data.file.gbifdata);
    mkdir(data.file.gdmdata);
catch ME
    logmsg(ME,'Can''t make data directories')
    rethrow(ME)
end
% ------------------------------------------------------------------------
% Short URLs from Bitley
%   initial values set in PATHTO
try 
    [data.url.short,data.url.plus,data.url.qrcode] = bitley(data.url.long);
catch ME
    logmsg(ME,'Short url not set')
end
try 
    q = imread(data.url.qrcode);
    imwrite(q,data.file.qrcode,'png');
catch ME
    logmsg(ME,'Qrcode not set')
end
% ------------------------------------------------------------------------
logmsg(0,'LEFT analysis begins');
% ------------------------------------------------------------------------
% Call the main LEFT analysis
tic
data = main(data); %                             <<----<<<<   calling MAIN 
elapsed_time = toc;
% ------------------------------------------------------------------------
% Elapsed time
data.job.elapsed_time = sprintf('%0.2f',elapsed_time);
logmsg(0,'LEFT analysis completed in %i minutes',ceil(elapsed_time./60));
% ------------------------------------------------------------------------
% Timestamp
tnow = now;
data.job.end_iso      = datestr(tnow,30);
data.job.end_date     = datestr(tnow,'dd mmmm yyyy');
data.job.end_time     = datestr(tnow,'HH:MM:SS.FFF');
% ------------------------------------------------------------------------
% Add JOB fields to DATA.OUTPUT
field = fieldnames(data.job);
for i = 1:numel(field)
    data.output.(sprintf('job_%s',field{i})) ...
        = sprintf(data.job.(field{i}));
end
% ------------------------------------------------------------------------
% Add URL fields to DATA.OUTPUT
field = fieldnames(data.url);
for i = 1:numel(field)
    data.output.(sprintf('url_%s',field{i})) ...
        = sprintf(data.url.(field{i}));
end
% ------------------------------------------------------------------------
% Add SYSTEM fields to DATA.OUTPUT
try
    if isdeployed
        systemupdate = dir(data.file.left_exe);
    else
        systemupdate = dir(data.file.left_m);
    end
    data.output.system_update = systemupdate.date;
catch ME
    data.output.system_update = 'not available';
    logmsg(ME,'System date not available')
end
% ------------------------------------------------------------------------
% Write output.html
switch data.job.status
    case 'Success'
        whichtemplate = data.file.outputtemplate;
    otherwise
        whichtemplate = data.file.errortemplate;
        logmsg(0,'Using error template')
end
try
    templateupdate = dir(whichtemplate);
    data.output.template_update = templateupdate.date;
catch ME
    logmsg(ME,'Template date not available')
end
try
    write2template(data.output,whichtemplate,data.file.html);
    logmsg(0,'Output html file written')
catch ME
    logmsg(ME,'Output html file failed')
end
% ------------------------------------------------------------------------
% Write output.pdf
try
    html2pdf(data.file.html,data.file.pdf);
    if exist(data.file.pdf,'file')
        logmsg(0,'Output pdf file written')
    else
        logmsg(0,'Output pdf file NOT written')
    end
catch ME
    logmsg(ME,'Output pdf file failed')
end
% ------------------------------------------------------------------------
% Write output_mobile.html
% switch data.job.status
%     case 'Success'
%         whichtemplate = data.file.mobiletemplate;
%     otherwise
%         whichtemplate = data.file.errortemplate;
%         logmsg(0,'Using error template')
% end
% try
%     write2template(data.output,whichtemplate,data.file.mobile_html);
%     logmsg(0,'Mobile html file written')
% catch ME
%     logmsg(ME,'Mobile html file failed')
% end
% ------------------------------------------------------------------------
% Write output.pdf
% try
%     html2pdf(data.file.mobile_html,data.file.mobile_pdf);
%     if exist(data.file.mobile_pdf,'file')
%         logmsg(0,'Mobile pdf file written')
%     else
%         logmsg(0,'Mobile pdf file NOT written')
%     end
% catch ME
%     logmsg(ME,'Mobile pdf file failed')
% end
% ------------------------------------------------------------------------
% Completion log and console messages
switch data.job.status
    case 'Success'
        logmsg(0,'LEFT Job completed successfully\n')
        fprintf(1,'\n\n[LEFT/%s][Exit status = 0]\n',data.job.host);
    otherwise
        logmsg(1,'LEFT Job failed!\n%s\n',data.job.exception);
        fprintf(2,'\n\n[LEFT/%s][Exit status = 1]\n',data.job.host);
end
% ------------------------------------------------------------------------
