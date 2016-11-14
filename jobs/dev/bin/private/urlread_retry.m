% Copyright 2012, neil.caithness@oerc.ox.ac.uk
%
% This source is subject to the CC BY-NC-SA 3.0 license
% http://creativecommons.org/licenses/by-nc-sa/3.0/
% Please see the URL above for more information.
% All other rights reserved.
%
% THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY 
% KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
% PARTICULAR PURPOSE.
function [str,success] = urlread_retry(url,method,params,message)

maxretry = 3;
success = 0;
str = '';

if nargin<4
    message = '';
end

i = 0;
while i<maxretry && ~success
    i = i+1;
    if i>1
        logmsg(1,'Retry count = %i %s',i,message)
    end
    [str,success] = urlread(url,method,params);
end

if ~success
    logmsg(1,'Fetching url failed')
    logmsg(1,'   - %s',url)
end

