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
function [data,species] = enm_pca(data,species,names)

% lets see what's here
for i = 1:numel(names)
    this_name = names{i};
    if isfield(species.data,this_name)
        if isfield(species.data.(this_name),'Covars')
            covars = species.data.(this_name).('Covars');
            % logmsg(0,'%7i  -  %s',size(covars,1),regexprep(this_name,'_',' '))
            species.data.(this_name).Model = csm1(covars);
        end
    end
end

return
