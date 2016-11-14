% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function [data,species] = covars(data,species,names)

covars = {'bio1' 'bio4' 'bio12' 'bio15' 'gtopo'};

% load the covars
try
    for i = 1:numel(covars)
        this_covar = char(covars{i});
        [bio_covar.(this_covar),~,bio_refmat,~] = mygeotiffread( ...
            data.file.(this_covar), ...
            data.coord.outer.poly.BoundingBox, ...
            data.tile.refmat);
    end
    [m_,n_] = size(bio_covar.(this_covar));
catch ME
    logmsg(ME,'Failed while reading covariate data files')
end

% lets see what's here
for i = 1:numel(names)
    this_name = names{i};
    if isfield(species.data,this_name)
        if species.data.(this_name).RecordCount>0
            lat = species.data.(this_name).Latitude;
            lon = species.data.(this_name).Longitude;
            [m,n] = latlon2abspix(bio_refmat,lat,lon);
            k_ = m>0 & m<=m_ & n>0 & n<=n_;
            k = sub2ind([m_ n_],m(k_),n(k_));
            if numel(k)>3
                covars_mat = zeros(numel(k),numel(covars));
                for j = 1:numel(covars)
                    covars_mat(:,j) = bio_covar.(covars{j})(k);
                end
                species.data.(this_name).Index = k_;
                species.data.(this_name).Covars = covars_mat;
                % logmsg(0,'%7i  -  %s',numel(k),regexprep(this_name,'_',' '))
            end
        end
    else
        % logmsg(1,'No match -  %s',this_name)
    end
end

return




