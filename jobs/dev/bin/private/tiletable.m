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
function [t,r] = tiletable(x,y)

a = [
% top left right bottom
-6.665469111 -180.0013889 -96.66824689 -89.99861111
-6.665469111 -138.3348179 -55.00167589 -89.99861111
-6.665469111 -96.66824689 -13.33510489 -89.99861111
-6.665469111 -55.00167589 28.33146611 -89.99861111
-6.665469111 -13.33510489 69.99803711 -89.99861111
-6.665469111 28.33146611 111.6646081 -89.99861111
-6.665469111 69.99803711 153.3311791 -89.99861111
-6.665469111 111.6646081 194.9977501 -89.99861111
35.00110189 -180.0013889 -96.66824689 -48.33204011
35.00110189 -138.3348179 -55.00167589 -48.33204011
35.00110189 -96.66824689 -13.33510489 -48.33204011
35.00110189 -55.00167589 28.33146611 -48.33204011
35.00110189 -13.33510489 69.99803711 -48.33204011
35.00110189 28.33146611 111.6646081 -48.33204011
35.00110189 69.99803711 153.3311791 -48.33204011
35.00110189 111.6646081 194.9977501 -48.33204011
76.66767289 -180.0013889 -96.66824689 -6.665469111
76.66767289 -138.3348179 -55.00167589 -6.665469111
76.66767289 -96.66824689 -13.33510489 -6.665469111
76.66767289 -55.00167589 28.33146611 -6.665469111
76.66767289 -13.33510489 69.99803711 -6.665469111
76.66767289 28.33146611 111.6646081 -6.665469111
76.66767289 69.99803711 153.3311791 -6.665469111
76.66767289 111.6646081 194.9977501 -6.665469111
118.3342439 -180.0013889 -96.66824689 35.00110189
118.3342439 -138.3348179 -55.00167589 35.00110189
118.3342439 -96.66824689 -13.33510489 35.00110189
118.3342439 -55.00167589 28.33146611 35.00110189
118.3342439 -13.33510489 69.99803711 35.00110189
118.3342439 28.33146611 111.6646081 35.00110189
118.3342439 69.99803711 153.3311791 35.00110189
118.3342439 111.6646081 194.9977501 35.00110189
];

% left
minx = a(:,2); 

% bottom
miny = a(:,4);

% wrap x west around the date-line
if x < min(minx), 
    x = x + 360;
end
% wrap y south around the pole
if y < min(miny)
    y = y + 180;
end

% tile index is last of the matches
k = find(x >= minx & y >= miny); 
try
    k = k(end);
    t = k - 1; % NB. zero based
catch ME
    logmsg(ME,'Can''t determine which tile. Check coordinates?')
end

% Convert to refmat
d = 1/360;
lon11 = a(k,2) + d./2;
lat11 = a(k,1) - d./2;
dlon = d;
dlat = -d;
r = makerefmat(lon11, lat11, dlon, dlat);

