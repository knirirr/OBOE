% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function str = xmlentity(str)

str = regexprep(str,'&quot;','\[\[QUOT\]\]');
str = regexprep(str,'"','&quot;');
str = regexprep(str,'\[\[QUOT\]\]','&quot;');

str = regexprep(str,'&amp;','\[\[AMP\]\]');
str = regexprep(str,'&','&amp;');
str = regexprep(str,'\[\[AMP\]\]','&amp;');

str = regexprep(str,'&apos;','\[\[APOS\]\]');
str = regexprep(str,'''','&apos;');
str = regexprep(str,'\[\[APOS\]\]','&apos;');

str = regexprep(str,'&lt;','\[\[LT\]\]');
str = regexprep(str,'<','&lt;');
str = regexprep(str,'\[\[LT\]\]','&lt;');

str = regexprep(str,'&gt;','\[\[GT\]\]');
str = regexprep(str,'>','&gt;');
str = regexprep(str,'\[\[GT\]\]','&gt;');


