% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
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
