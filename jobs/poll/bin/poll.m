function poll(option)
%POLL   Scan for pending jobs and runs the first job in the queue.
%
%   POLL
%   POLL -help
%   POLL -config
%
% The compiled executable POLL.EXE is expected to run on VM hosts on a
% schedule set from the Windows Task Manager. 
% 
% Compile options:
%   mcc -m -N poll.m
%
% Copyright 2010-2011
%   Neil Caithness <neil.caithness@oerc.ox.ac.uk>

% ------------------------------------------------------------------------
% Set option flags
flag.config = false;
if nargin
    switch option
        case {'-help' '-h' '-?' '/help' '/h' '/?'}
            fprintf(1,'Polls for pending jobs and runs the first job in the queue.\n');
            fprintf(1,'\n');
            fprintf(1,'Options\n');
            fprintf(1,'  -help       display this message\n');
            fprintf(1,'  -config     display configuration details\n');
            fprintf(1,'\n');
            return
        case {'-config' '-c' '/config' '/c'}
            flag.config = true;
        otherwise
            fprintf(1,'Option "%s" is not recognised.\n',option);
            fprintf(1,'  Type POLL /? for help.\n');
            return
    end
end

% ------------------------------------------------------------------------
% Host name
thisHostName = deblank(evalc('!hostname'));

% ------------------------------------------------------------------------
% Host specific paths and files
ff = pathinfo(thisHostName);

% ------------------------------------------------------------------------
% Folders in path2jobs
jobFolders = mydir(ff.path2jobs,'folders');

% ------------------------------------------------------------------------
% Folders in path2source
sourceFolders = mydir(ff.path2source,'folders');

% ------------------------------------------------------------------------
% Folders in path2work
workFolders = mydir(ff.path2work,'folders');

% ------------------------------------------------------------------------
% Which folders to Watch?
% ... find all jobFolders with thisHostName in hostConfigFileName
watch = [];
for jobFolder = jobFolders
     thisFolder = strrep(ff.hostConfigFileName,'<jobType>',char(jobFolder));
     if exist(thisFolder,'file')
         hosts = mytextscan(thisFolder);
         if  any(strcmp(thisHostName,hosts))
             watch = [watch;jobFolder];
         end
     end
end

% ------------------------------------------------------------------------
% Addresses in emailNotifyFileName
addresses = mytextscan(ff.emailNotifyFileName);

% ------------------------------------------------------------------------
% Pending job name pattern
todo = sprintf('(\\S+)\\.%s\\.zip',thisHostName);

% ------------------------------------------------------------------------
% List of pending jobs
list = {};
for i = 1:numel(watch)
    [files,dates] = mydir(fullfile(ff.path2jobs,watch{i}),'files');
    match = regexp(files,todo);
    for j = 1:numel(match)
        if ~isempty(match{j})
            row = size(list,1)+1;
            list{row,1} = watch{i}; 
            list{row,2} = files{j}; 
            list{row,3} = dates{j}; 
        end
    end
end

% ------------------------------------------------------------------------
% Display configuration
%   POLL -config
if flag.config
    fprintf(1,'POLL - Configuration on %s\n',upper(thisHostName));
    fprintf(1,'\n');

    % Job folders
    fprintf(1,'Job folders:\n\t%s\n',ff.path2jobs);
    for i = 1:numel(jobFolders)
        % config is a special folder so exclude it here
        if ~strcmp(jobFolders{i},'config')
            fprintf(1,'\t\t%s\n',jobFolders{i});
        end
    end
    fprintf(1,'\n');

    % Work spaces
    fprintf(1,'Work spaces:\n\t%s\n',ff.path2work);
    for i = 1:numel(workFolders)
        fprintf(1,'\t\t%s\n',workFolders{i});
    end
    fprintf(1,'\n');

    % Executables
    fprintf(1,'Executables:\n\t%s\n',ff.path2source);
    for i = 1:numel(sourceFolders)
        ss = mystrrep(ff,'<jobType>',sourceFolders{i});
        if exist(ss.exeFileName,'file')
            fprintf(1,'\t\t%s\n',sourceFolders{i});
        end
    end
    fprintf(1,'\n');
    
    % Watch folders
    fprintf(1,'Watch folders:\n\t%s\n',ff.hostConfigFileName);
    if ~isempty(watch)
        for i = 1:numel(watch)
            fprintf(1,'\t\t%s\n',watch{i});
        end
    else
        fprintf(1,'\t\tlist is empty\n');
    end
    fprintf(1,'\n');
    
    % Notifications
    fprintf(1,'Notifications:\n\t%s\n',ff.emailNotifyFileName);
    if ~isempty(addresses)
        for i = 1:numel(addresses)
            fprintf(1,'\t\t%s\n',addresses{i});
        end
    else
        fprintf(1,'\t\tlist is empty\n');
    end
    fprintf(1,'\n');

    % Pending jobs
    fprintf(1,'Pending jobs:\n');
    if ~isempty(list)
        for i = 1:size(list,1)
            fprintf(1,'\t\t%s\t%s\t%s\n',list{i,1},datestr(list{i,3}),list{i,2});
        end
    else
        fprintf(1,'\t\tlist is empty\n');
    end
    fprintf(1,'\n');
    
    % display configuration ended
    return
end

% ------------------------------------------------------------------------
% Run a job from the list
if ~isempty(list)
    [~,k] = sort(cell2mat(list(:,3)));
    list = list(k,1:2);
    for i = 1:numel(k)
        jobType = list{i,1};
        jobID = char(regexp(list{i,2},todo,'tokens','once'));
        ff = mystrrep(ff,'<jobType>',jobType,'<jobID>',jobID);
        % ********************
        % Rename <jobid>.<host>.zip to <jobid>.<host>_running.zip
        % to indicate that this host has claimed the job.
        status = movefile(ff.todoFileName,ff.holdFileName);
        % ********************
        % If renaming was successful continue processing.
        if status
            fileNames = unzip(ff.holdFileName,ff.path2workType); 
            warning off MATLAB:MKDIR:DirectoryExists
            mkdir(ff.path2workOutput);
            warning on MATLAB:MKDIR:DirectoryExists
            % ********************
            % CD to the working directory, bang the executable, and CD
            % back. If anything goes wrong, write the exception message
            % to output. 
            try
                myDir = cd(ff.path2workInput);
                % Are we in deployed or development mode?
                switch isdeployed
                    case true
                        % ********************
                        % Send start notification
                        if ~isempty(addresses)
                            emailprefs; % sets smtp preferences
                            subject = sprintf('%s job started on %s',upper(jobType),upper(thisHostName));
                            message = sprintf('\n\n%s\n',ff.link2logFile);
                            sendmail(addresses,subject,message);
                        end
                        % ********************
                        output = evalc(sprintf('!%s args.txt',ff.exeFileName));
                    case false
                        output = evalc(sprintf('%s args.txt',jobType));
                end
                cd(myDir);
            catch ME
                output = ME.message;
            end
            % Zip the contents of the working directory. Check for
            % something in the output to indicate a good completion - by
            % agreement "[Exit status = 0]". If string not found then treat
            % as a fail. In either case, zip the whole working directory
            % back to the Dropbox.
            entryNames = zip(ff.tempFileName,ff.path2workRoot); 
            success = regexp(output,'\[Exit status = 0\]');
            if success 
                status = movefile(ff.tempFileName,ff.doneFileName);
            else
                status = movefile(ff.tempFileName,ff.failFileName);
            end
            % ********************
            % Append output to the log file
            try 
                fid = fopen(ff.logFileName,'a');
                fprintf(fid,'\n\n%s\n',output);
                fclose(fid);
            catch ME
                % TODO
                rethrow(ME)
            end
            % ********************
            % Delete the hold file
            delete(ff.holdFileName);
            % ********************
            % We've now done one job. We don't want to work our way 
            % through the whole list, so break out of the loop here.
            break
        end
    end
end


% ------------------------------------------------------------------------
function s = mystrrep(s,varargin)

fields = fieldnames(s);
for i = 1:numel(fields)
    for j = 1:2:numel(varargin)-1
        s.(fields{i}) = regexprep(s.(fields{i}),varargin{j},varargin{j+1});
    end
end


% ------------------------------------------------------------------------
function s = mytextscan(f)

fid = fopen(f);
c = textscan(fid,'%s');
fclose(fid);
s = c{1};


% ------------------------------------------------------------------------
function s = myfileread(f)

s = fileread(f);
s = regexp(s,'\s+','split');

% ------------------------------------------------------------------------
function [names,dates] = mydir(p,option)

% remove names starting with '.'
d = dir(p);
k = false(1,numel(d));
for i = 1:numel(d)
    k(i) = isempty(regexp(d(i).name,'^\.','once'));
end
d = d(k);

% which are folders?
k = false(1,numel(d));
for i = 1:numel(d)
    k(i) = d(i).isdir; 
end

% select folders, files, or any
switch option
    case 'folders'
        d = d(k);
    case 'files'
        d = d(~k);
    case {'any' 'all'}
end

% deal the names and dates to a cell array
[names{1:numel(d)}] = deal(d.name);
[dates{1:numel(d)}] = deal(d.datenum);


% ------------------------------------------------------------------------
function ff = pathinfo(host)

switch host
    case 'gecko' % Development machine (Neil's laptop)
        docRoot                 = fullfile('C:','Users','Neil','Documents','');
        % - Logfile
        ff.logFileName          = fullfile(docRoot,'WORK','<jobType>','logs','<jobID>.txt');
        ff.historyFileName      = fullfile(docRoot,'WORK','<jobType>','logs','history.html');
        ff.link2logFile         = ['file:///' regexprep(docRoot,filesep,'/') '/WORK/<jobType>/logs/<jobID>.txt'];
        ff.link2historyFile     = ['file:///' regexprep(docRoot,filesep,'/') '/WORK/<jobType>/logs/history.html'];
        % - Config
        ff.hostConfigFileName   = fullfile(docRoot,'Dropbox_not','Jobs','<jobType>','hosts.txt');
        ff.emailNotifyFileName  = fullfile(docRoot,'Dropbox_not','Jobs','config','notify.txt');
        % - Jobs
        ff.path2jobs            = fullfile(docRoot,'Dropbox_not','Jobs','');
        ff.path2jobType         = fullfile(docRoot,'Dropbox_not','Jobs','<jobType>','');
        ff.todoFileName         = fullfile(docRoot,'Dropbox_not','Jobs','<jobType>','<jobID>.<host>.zip');
        ff.holdFileName         = fullfile(docRoot,'Dropbox_not','Jobs','<jobType>','<jobID>.<host>_running.zip');
        ff.failFileName         = fullfile(docRoot,'Dropbox_not','Jobs','<jobType>','<jobID>.fail.zip');
        ff.doneFileName         = fullfile(docRoot,'Dropbox_not','Jobs','<jobType>','<jobID>.done.zip');
        ff.tempFileName         = fullfile(docRoot,'Dropbox_not','Jobs','<jobType>','<jobID>.temp.zip');
        % - Work
        ff.path2work            = fullfile(docRoot,'WORK','');
        ff.path2workType        = fullfile(docRoot,'WORK','<jobType>','');
        ff.path2workRoot        = fullfile(docRoot,'WORK','<jobType>','<jobID>','');
        ff.path2workInput       = fullfile(docRoot,'WORK','<jobType>','<jobID>','input','');
        ff.argsFileName         = fullfile(docRoot,'WORK','<jobType>','<jobID>','input','args.txt');
        ff.path2workOutput      = fullfile(docRoot,'WORK','<jobType>','<jobID>','output','');
        % - Source
        ff.path2source          = fullfile(docRoot,'SVN','jobs','');
        ff.path2sourceType      = fullfile(docRoot,'SVN','jobs','<jobType>','bin','');
        ff.exeFileName          = fullfile(docRoot,'SVN','jobs','<jobType>','bin','<jobType>.exe');
        ff.mFileName            = fullfile(docRoot,'SVN','jobs','<jobType>','bin','<jobType>.m');

%     case {'nyogtha' 'syncerus' 'hippotragus'} % Virtual Windows hosts at OeRC
    otherwise
        docRoot                 = fullfile('C:','Users','oerc0003','Documents','');
        jobRoot                 = fullfile('V:','Jobs','');
        % - Logfile
        ff.logFileName          = fullfile(jobRoot,'<jobType>','logs','<jobID>.txt');
        ff.historyFileName      = fullfile(jobRoot,'<jobType>','logs','history.html');
        ff.link2logFile         = 'https://oboe.oerc.ox.ac.uk/inspect/<jobType>/<jobID>';
        ff.link2historyFile     = 'https://oboe.oerc.ox.ac.uk/inspect/<jobType>/history.html';
        % - Config
        ff.hostConfigFileName   = fullfile(jobRoot,'<jobType>','hosts.txt');
        ff.emailNotifyFileName  = fullfile(jobRoot,'config','notify.txt');
        % - Jobs
        ff.path2jobs            = fullfile(jobRoot,'');
        ff.path2jobType         = fullfile(jobRoot,'<jobType>','');
        ff.todoFileName         = fullfile(jobRoot,'<jobType>','<jobID>.<host>.zip');
        ff.holdFileName         = fullfile(jobRoot,'<jobType>','<jobID>.<host>_running.zip');
        ff.failFileName         = fullfile(jobRoot,'<jobType>','<jobID>.fail.zip');
        ff.doneFileName         = fullfile(jobRoot,'<jobType>','<jobID>.done.zip');
        ff.tempFileName         = fullfile(jobRoot,'<jobType>','<jobID>.temp.zip');
        % - Work
        ff.path2work            = fullfile(docRoot,'WORK','');
        ff.path2workType        = fullfile(docRoot,'WORK','<jobType>','');
        ff.path2workRoot        = fullfile(docRoot,'WORK','<jobType>','<jobID>','');
        ff.path2workInput       = fullfile(docRoot,'WORK','<jobType>','<jobID>','input','');
        ff.argsFileName         = fullfile(docRoot,'WORK','<jobType>','<jobID>','input','args.txt');
        ff.path2workOutput      = fullfile(docRoot,'WORK','<jobType>','<jobID>','output','');
        % - Source
        ff.path2source          = fullfile(docRoot,'SVN','jobs','');
        ff.path2sourceType      = fullfile(docRoot,'SVN','jobs','<jobType>','bin','');
        ff.exeFileName          = fullfile(docRoot,'SVN','jobs','<jobType>','bin','<jobType>.exe');
        ff.mFileName            = fullfile(docRoot,'SVN','jobs','<jobType>','bin','<jobType>.m');

%     otherwise
%         error(['POLL has not been configured for host "%s"\n' ...
%             'Please see the code for configuration details.'],host);
end

% Substitute host name
ff = mystrrep(ff,'<host>',host);


