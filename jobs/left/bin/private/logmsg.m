% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function logmsg(state,message,varargin)
% LOGMSG    Generalized message logger.
%
%   LOGMSG(STATE, MESSAGE, VARARGIN)
%
% STATE may be one of:
%   0:  normal
%   1:  error (2..n may be used in later versions)
%   ME: an ME object, e.g. as captured by try/catch ME/end
%
%   MESSAGE is a message format specifier. See FPRINTF for details.
%   VARAGIN is a series of variables matching the format specifiers in MESSAGE.
%
% LOGMSG writes a formatted message to various locations depending on host and 
% deployed state. Specific file locations are configured internally. See the code 
% for details.
%
% Examples:
%
% LOGMSG using a normal state 0.
%   In function main.m
%       logmsg(0, 'Job started at %s', datestr(now));
%   writes the following:
%
%       13:51:45 + MAIN Job started at 17-Oct-2011 13:51:45
%
% LOGMSG using an error state 1 (or integers>1).
%   In function gbif.m
%       logmsg(1, 'Could not determine the tile number');
%   writes the following (to stderr if writing to the console):
%
%       13:54:59 - GBIF Could not determine the tile number
%
% LOGMSG using an ME object as the state.
%   In function gdmr.m
%       try
%           ...
%       catch ME
%           logmsg(ME, 'Failed during GDM for %s', taxonStr);
%       end
%   writes the following (to stderr if writing to the console):
%
%       14:09:10 - GDMR Failed during GDM for Reptilia
%       14:09:10 - GDMR    Index exceeds matrix dimensions.
%       14:09:10 - GDMR    gdm_R (150)
%       14:09:10 - GDMR    left (393)
%       14:09:10 - GDMR    main (157)
%
% Copyright 2010-2011
%   Neil Caithness <neil.caithness@oerc.ox.ac.uk>

% ------------------------------------------------------------------------
% Host name
hostName = deblank(evalc('!hostname'));

% ------------------------------------------------------------------------
% Time stamp
tnow = now;
date = datestr(tnow,1);
time = datestr(tnow,13);

% ------------------------------------------------------------------------
% Call stack
db = dbstack;
caller = upper(db(2).name);

% ------------------------------------------------------------------------
% Extract JOBTYPE and JOBID from the current path
parts = regexp(pwd,filesep,'split');
% We should be in ...<jobtype>\<jobid>\input
assert(strcmp(parts(end),'input'), ...
    'LOGMSG can''t find its logfile from here - \n\n%s\n',pwd);
jobType = char(parts(end-2)); 
jobID = char(parts(end-1)); 

% ------------------------------------------------------------------------
% Host specific file locations
switch hostName
    case 'gecko' % Development machine (Neil's laptop)
        logFile = fullfile('C:','Users','Neil','Documents','WORK',jobType,'logs',[jobID '.txt']);
        historyFile = fullfile('C:','Users','Neil','Documents','WORK',jobType,'logs','history.html');
        versionFile = fullfile('C:','Users','Neil','Documents','Dropbox','Jobs',jobType,'version.txt');
        if exist(versionFile,'file'), version = deblank(fileread(versionFile)); else version = 'N/A'; end
        tableData = sprintf('<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td><a href="file:///C:/Users/Neil/Documents/WORK/%s/logs/%s.txt">%s</a></td></tr>', ...
            date, time, hostName, version, jobType, jobID, jobID);

    % case {'nyogtha' 'syncerus' 'hippotragus'} % Virtual Windows hosts at OeRC
    otherwise % Any other host
        % logFile = fullfile('C:','Users','oerc0003','Documents','Dropbox','Public',jobType,'logs',[jobID '.txt']);
        logFile = fullfile('V:','Jobs',jobType,'logs',[jobID '.txt']);
        % historyFile = fullfile('C:','Users','oerc0003','Documents','Dropbox','Public',jobType,'logs','history.html');
        historyFile = fullfile('V:','Jobs',jobType,'logs','history.html');
        % versionFile = fullfile('C:','Users','oerc0003','Documents','Dropbox','Jobs',jobType,'version.txt');
        versionFile = fullfile('V:','Jobs',jobType,'version.txt');
        if exist(versionFile,'file'), version = deblank(fileread(versionFile)); else version = 'N/A'; end
        tableData = sprintf('<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td><a href="http://dl.dropbox.com/u/44079403/%s/logs/%s.txt">%s</a></td></tr>', ...
            date, time, hostName, version, jobType, jobID, jobID);
end

% ------------------------------------------------------------------------
% Message, prefix (- or +) and fid (stdout or stderr)
switch class(state)
    case 'double'
        switch state
            case 0
                std = 1;
                prefix = '+';
            case 1
                std = 2;
                prefix = '-';
            otherwise
                std = 2;
                prefix = '-';
        end
        str = sprintf([time ' ' prefix ' '  caller ' '  message '\n'],varargin{:});
    case 'MException'
        std = 2;
        prefix = '-';
        str = '';
        str = [str sprintf([time ' ' prefix ' '  caller ' '  message '\n'],varargin{:})];
        str = [str sprintf([time ' ' prefix ' '  caller '    %s\n'],state.message)];
        for i = 1:numel(state.stack)
            str = [str sprintf([time ' ' prefix ' '  caller '    %s (%i)\n'], ...
                state.stack(i).name,state.stack(i).line)]; %#ok<AGROW>
        end
end

% ------------------------------------------------------------------------
% Fix escape sequences that may be in STR
str = strrep(str,'\','\\'); 

% ------------------------------------------------------------------------
% Write to the history file
%   If the log file doesn't yet exist, then this is the first call in this job.
%   Add an entry to the history file with a link to the logfile.
%   If the history file doesn't exist either, then make that as well.
% try
%     if ~exist(logFile,'file')
%         if ~exist(historyFile,'file')
%             header = '<table border="1"><tr><th align="left">Date</th><th align="left">Time</th><th align="left">Host</th><th align="left">Ver</th><th align="left">JobID</th></tr>';
%             fid = fopen(historyFile,'w');
%             fprintf(fid,header);
%             fclose(fid);
%         end
%         fid = fopen(historyFile,'a');
%         fprintf(fid,tableData);
%         fclose(fid);
%     end
% catch ME
%     % TODO
%     rethrow(ME)
% end

% ------------------------------------------------------------------------
% Write to the log file
try 
    fid = fopen(logFile,'a');
    fprintf(fid,str);
    fclose(fid);
catch ME
    % TODO
    rethrow(ME)
end

% ------------------------------------------------------------------------
% Write to the console
try
    if ~isdeployed 
        fprintf(std,str);
    end
catch ME
    % TODO
    rethrow(ME)
end
