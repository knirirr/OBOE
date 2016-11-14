function logfile = logmsg(state,message,varargin)
% LOGMSG    Generalized message logger.
%
%   LOGMSG(STATE, MESSAGE, A, ...)
%
%   STATE may be one of:
%     0:  normal
%     1:  error (2..n may be used in later versions)
%     ME: an ME object, e.g. as captured by try/catch ME/end
%
%   MESSAGE is a message format specifier. See FPRINTF for details. A, etc.
%   is any number of variables matching the format specifiers in MESSAGE.
%
% LOGMSG is intended to be called only from within another functions. It
% writes a formatted message to various locations depending on host and
% deployed state. Specific file locations are configured internally. 
% See the code for details.
%
% LOGMSG with no arguments will return a string representing the full path
% to the logfile location.
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
% Copyright 2012, neil.caithness@oerc.ox.ac.uk

% ------------------------------------------------------------------------
% Host name
hostName = getenv('computername'); % probably works on pc only
% ------------------------------------------------------------------------
% User name
userName = getenv('username'); % probably works on pc only
% ------------------------------------------------------------------------
% Time stamp
tnow = now;
date = datestr(tnow,1);
time = datestr(tnow,13);

% ------------------------------------------------------------------------
% Call stack
db = dbstack;
if numel(db)<2
    error('OBOE:logmsg:dbstackError', ...
        'LOGMSG should only be called from within another function.');
end
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
switch upper(hostName)
    % Use a seperate case for each development machine
    case {'GECKO'} % Neil's laptop
        logFile = fullfile('C:','Users',userName,'Documents','WORK',jobType,'logs',[jobID '.txt']);

    % Any other host is assumed be be connected to (\\jupiter\projects\vibrant) as (V:\)
    otherwise 
        logFile = fullfile('V:','Jobs',jobType,'logs',[jobID '.txt']);
end

% ------------------------------------------------------------------------
% Return the file location
if ~nargin
    logfile = logFile;
    return
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
