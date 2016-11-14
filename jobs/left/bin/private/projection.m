% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function [data,p] = projection(data,species,names,option)

if nargin<4, option = 'alpha'; end

covars = {'bio1' 'bio4' 'bio12' 'bio15' 'gtopo'};

% load the covars
try
    for i = 1:numel(covars)
        this_covar = char(covars{i});
        [bio_covar.(this_covar),~,this_refmat,~] = mygeotiffread( ...
            data.file.(this_covar), ...
            data.coord.inner.poly.BoundingBox, ...
            data.tile.refmat);
    end
    [m,n] = size(bio_covar.(this_covar));
catch ME
    logmsg(ME,'Failed while reading projection data files')
end

% reshape as projection set
projdata = zeros(numel(bio_covar.(this_covar)),numel(covars));
for i = 1:numel(covars)
    this_covar = char(covars{i});
    projdata(:,i) = bio_covar.(this_covar)(:);
end

% lets see what's here
p = zeros(size(projdata,1),1);
for i = 1:numel(names)
    this_name = names{i};
    if isfield(species.data,this_name)
        if isfield(species.data.(this_name),'Model')
            if any(species.data.(this_name).Model.sigma)
                switch option
                    case 'alpha'
                        p = p + csm2(projdata,species.data.(this_name).Model);
                    case 'beta'
                        y = csm2(projdata,species.data.(this_name).Model);
                        y = pdf('norm', y, .5, .02);
                        y = y * (1/max(y));
                        p = p + y;
                end
            end
        end
    end
end

p = reshape(p,m,n);



