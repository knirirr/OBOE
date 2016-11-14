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
[Amphibia_prs Aves_prs Mammalia_prs Plantae_prs Reptilia_prs] = deal([]);

try load Amphibia_prs.txt, catch ME, end
try load Aves_prs.txt, catch ME, end
try load Mammalia_prs.txt, catch ME, end
try load Plantae_prs.txt, catch ME, end
try load Reptilia_prs.txt, catch ME, end

Max_prs = max([Amphibia_prs Aves_prs Mammalia_prs Plantae_prs Reptilia_prs],[],2);

fid = fopen('Max_prs.txt','w');
fprintf(fid,'%f\n',Max_prs);
fclose(fid)




