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
function [status,message,data] = datascan(tilen)

data.tile.number = tilen;
data = pathto_data(data,tilen);
files = fieldnames(data.file);

message = cell(numel(files),1);
status = nan(numel(files),1);

try
    for i = 1:numel(files)
        file = files{i};
        try
            warning('off','map:geotiffinfo:tiffWarning')
            data.tiff(i) = geotiffinfo(data.file.(file));
            warning('on','map:geotiffinfo:tiffWarning')
            status(i) = 1;
        catch ME
            message{i} = ME.message;
            status(i) = 0;
        end
    end
catch ME
    message = ME.message;
    status = 0;
end
    


