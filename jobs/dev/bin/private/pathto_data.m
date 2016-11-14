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
function data = pathto_data(data,tilen)

switch deblank(evalc('!hostname'))

    % V:\left\left - \\jupiter\projects\vibrant

    % C:\Users\Neil\Documents\DATA\left
    case 'gecko' 
        % path2data = fullfile('C:','Users','Neil','Documents','DATA','left','');
        path2data = fullfile('V:','left','left','');
        
    % case {'nyogtha' 'syncerus' 'hippotragus'}
    otherwise
        path2data = fullfile('V:','left','left','');

    % otherwise
    %     error('Host name "%s" is not configured.',host);
end

data.file.mask                   = fullfile(path2data,'mask',               sprintf('mask%i.TIF',tilen));
% data.file.globcover              = fullfile(path2data,'globcover',          sprintf('globcover%i.TIF',tilen));
data.file.globcover              = fullfile(path2data,'globcover2009',      sprintf('GLOBCOVER_L4_200901_200912_V2.3_%i.TIF',tilen));
% data.file.vulnerability          = fullfile(path2data,'vulnerability',      sprintf('vuln%i.TIF',tilen));
data.file.fragmentation          = fullfile(path2data,'fragmentation',      sprintf('frag%i.TIF',tilen));
data.file.migratoryspecies       = fullfile(path2data,'migratoryspecies',   sprintf('groms%i.TIF',tilen));
data.file.hydrosheds             = fullfile(path2data,'wetland',            sprintf('wetland%i.TIF',tilen));
data.file.resilience             = fullfile(path2data,'resilience',         sprintf('resilience%i.TIF',tilen));
data.file.npp                    = fullfile(path2data,'npp2005',            sprintf('npp_%i.TIF',tilen));
data.file.gtopo                  = fullfile(path2data,'gtopo',              sprintf('gtopo_%i.TIF',tilen));

data.file.countries              = fullfile(path2data,'countries',          'TM_WORLD_BORDERS-0.3.shp');
data.file.ecoregions             = fullfile(path2data,'ecoregions',         'wwf_terr_ecos.shp');
% data.file.vulnerablespecies      = fullfile(path2data,'vulnerablespecies',  'terr_vert_iucn_threatened.shp');
data.file.vuln                   = fullfile(path2data,'vuln',               'VULN.mat');
data.file.lambdas                = fullfile(path2data,'vuln',               'lambdas','OUT');
data.file.groms                  = fullfile(path2data,'groms',              'groms.shp');
% data.file.iucn                   = fullfile(path2data,'iucn',               'IUCN.mat');

data.file.slope                  = fullfile(path2data,'slope',              sprintf('slope_%i.TIF',tilen));
data.file.aspect                 = fullfile(path2data,'aspect',             sprintf('aspect_%i.TIF',tilen));
data.file.nitrogen               = fullfile(path2data,'nitrogen',           sprintf('nitrogen_%i.TIF',tilen));
data.file.fieldcap               = fullfile(path2data,'fieldcap',           sprintf('fieldcap_%i.TIF',tilen));
data.file.wetdist                = fullfile(path2data,'wetdist',            sprintf('wetdist_%i.TIF',tilen));


data.file.bio1                   = fullfile(path2data,'bioclim',            sprintf('bio1_%i.TIF',tilen));
% data.file.bio2                   = fullfile(path2data,'bioclim',            sprintf('bio2_%i.TIF',tilen));
% data.file.bio3                   = fullfile(path2data,'bioclim',            sprintf('bio3_%i.TIF',tilen));
data.file.bio4                   = fullfile(path2data,'bioclim',            sprintf('bio4_%i.TIF',tilen));
% data.file.bio5                   = fullfile(path2data,'bioclim',            sprintf('bio5_%i.TIF',tilen));
% data.file.bio6                   = fullfile(path2data,'bioclim',            sprintf('bio6_%i.TIF',tilen));
% data.file.bio7                   = fullfile(path2data,'bioclim',            sprintf('bio7_%i.TIF',tilen));
% data.file.bio8                   = fullfile(path2data,'bioclim',            sprintf('bio8_%i.TIF',tilen));
% data.file.bio9                   = fullfile(path2data,'bioclim',            sprintf('bio9_%i.TIF',tilen));
% data.file.bio10                  = fullfile(path2data,'bioclim',            sprintf('bio10_%i.TIF',tilen));
% data.file.bio11                  = fullfile(path2data,'bioclim',            sprintf('bio11_%i.TIF',tilen));
data.file.bio12                  = fullfile(path2data,'bioclim',            sprintf('bio12_%i.TIF',tilen));
% data.file.bio13                  = fullfile(path2data,'bioclim',            sprintf('bio13_%i.TIF',tilen));
% data.file.bio14                  = fullfile(path2data,'bioclim',            sprintf('bio14_%i.TIF',tilen));
data.file.bio15                  = fullfile(path2data,'bioclim',            sprintf('bio15_%i.TIF',tilen));
% data.file.bio16                  = fullfile(path2data,'bioclim',            sprintf('bio16_%i.TIF',tilen));
% data.file.bio17                  = fullfile(path2data,'bioclim',            sprintf('bio17_%i.TIF',tilen));
% data.file.bio18                  = fullfile(path2data,'bioclim',            sprintf('bio18_%i.TIF',tilen));
% data.file.bio19                  = fullfile(path2data,'bioclim',            sprintf('bio19_%i.TIF',tilen));

