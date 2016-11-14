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
function shape2kmz(filename,s,varargin)


params.description = '';
params.lineColor = '0000FF00';
params.lineWidth = '2';
params.msgToScreen = '';
params.name = '';
params.polyColor = '8000FF00';
params.snippet = '';
params.tessellate = '';
params.timeSpanStart = '';
params.timeSpanStop = '';
params.visibility = '';

params = parseargs(params,varargin{:});
 

fields = fieldnames(s);
xfield = char(fields( ...
    strcmpi(fields,'x') | ...
    strcmpi(fields,'lon')));
yfield = char(fields( ...
    strcmpi(fields,'y') | ...
    strcmpi(fields,'lat')));

[~,i] = setdiff( ...
    lower(fields), ...
    lower({'Geometry','BoundingBox','X','Y','Lat','Lon'}));
fields = fields(i);

kmlstr = '';
n = numel(s);
for i = 1:n
    for j = 1:numel(fields)
        thisfield = char(fields(j));
        switch class(s(i).(thisfield))
            case 'char'
                s(i).(thisfield) = xmlentity(s(i).(thisfield));
            case 'double'
                if isnan(s(i).(thisfield)), s(i).(thisfield) = []; end
                s(i).(thisfield) = sprintf('%i',s(i).(thisfield));
        end
    end
    
    polystr = ge_poly(s(i).(xfield),s(i).(yfield), ...
        'name', s(i).name, ...
        'description', sprintf('Type: %s\nStatus: %s\nYear: %s', ...
        s(i).desig_eng, s(i).status, s(i).status_yr), ...
        'lineWidth',params.lineWidth, ...
        'lineColor',params.lineColor, ...
        'polyColor',params.polyColor);
    kmlstr = [kmlstr,ge_folder(s(i).name,polystr)];
end

allstr = ge_folder('ZAF',kmlstr);
ge_output(filename,allstr,'name','WDPA')




% params list from ge_poly

% params.altitude = '';
% params.altitudeMode = '';
% params.description = '';
% params.extrude = '';
% params.lineColor = '';
% params.lineWidth = '';
% params.msgToScreen = '';
% params.name = '';
% params.polyColor = '';
% params.snippet = '';
% params.tessellate = '';
% params.timeSpanStart = '';
% params.timeSpanStop = '';
% params.visibility = '';
% 
% params = parsepvpairs(params,varargin);

% 'altitude' Height difference relative to the plane of reference (see
%            parameter 'altitudeMode').
%
% 'altitudeMode' Specifies which plane of reference to use. Must be one of
%           'absolute', 'relativeToGround' or 'clampToGround'. Default is
%           'clampToGround'.
%
% 'autoClose' If polygons do not start at the location where they end, they
%           are unclosed. The Google Earth Viewer automatically closes
%           unclosed polygons consisting of more than 3 points. Though the
%           Google Earth Viewer closes the outline of unclosed polygons of
%           3 points, it does not fill the polygon surface. However,
%           unclosed polygons consisting of 3 or more points will be
%           automatically closed during generation of "kmlStr" if
%           'autoClose' is set to logical(1) or true. Default value is
%           true.
%
% 'description 'A description of objects can be included using this
%           parameter. Its value must be passed as a character array. It
%           will be displayed in the Google Earth Viewer within a pop-up
%           text balloon.
%
% 'extrude' See Extruding objects.
% 
% 'lineColor' Line color specification, including transparency. Color value
%           format must be passed as a character array according to the
%           format string 'TTRRGGBB', with 'TT' representing transparency;
%           'RR', 'GG', and 'BB' representing red, green, and blue colors,
%           respectively. Intensity values are denoted as two-digit
%           hexadecimal numbers ranging from 00 to FF. For example,
%           '80FF0000' is semi-transparent red and 'FF0000FF' is fully
%           opaque blue.
%
% 'lineWidth' Width of the polygon outline.
%
% 'msgToScreen' Defines whether verbose feedback is provided by the
%           function when it is accessed and when it finishes. Default is
%           false (which is equivalent to logical(0), but quicker).
%
% 'name' This character array will be used within the Google Earth Viewer
%           'Places' pane to identify objects.
%
% 'polyColor' Polygon color specification, see parameter 'lineColor'.
%
% 'snippet' A short description of the feature. In Google Earth, this
%           description is displayed in the Places panel under the name of
%           the feature. If a Snippet is not supplied, the first two lines
%           of the description are used.
%
% 'tessellate 'See Tessellation.
%
% 'timeSpanStart' See Dynamic visualization.
%
% 'timeSpanStop' See Dynamic visualization.
%
% 'visibility' Whether the object is initially visible. Must be passed to
%           ge_poly() as a numerical value 1 or 0. Visibility state can be
%           changed within the Google Earth Viewer by clicking the object's
%           checkmark in the 'Places' pane.



