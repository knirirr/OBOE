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
function urlOut = urlencode(urlIn)
%URLENCODE Replace special characters with escape characters URLs need
% Copyright 1984-2008 The MathWorks, Inc.

urlOut = char(java.net.URLEncoder.encode(urlIn,'UTF-8'));