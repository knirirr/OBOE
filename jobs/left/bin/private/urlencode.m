% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function urlOut = urlencode(urlIn)
%URLENCODE Replace special characters with escape characters URLs need
% Copyright 1984-2008 The MathWorks, Inc.

urlOut = char(java.net.URLEncoder.encode(urlIn,'UTF-8'));