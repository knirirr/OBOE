% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
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

