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


