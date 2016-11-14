% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
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




