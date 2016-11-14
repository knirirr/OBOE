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
function coordinates_test
% Unit tests for
%   function s = coordinates(str,signcode)

% For any of the allowable inputs, COORDINATES returns a struct as output:
%
%   e.g. 
%
%   s = coordinates('0 30 0 N')
%   
%   returns
%     s.deg.num = 0.5000
%     s.deg.str = ' 0.5000'
%     s.dms.num = [0 30 0]
%     s.dms.str = ' 0° 30'' 00.00" N '


% First do a sweep of decimal degree input values using all the outputs in
% turn as new inputs - we should always get the same output with the
% numeric value equal to the starting point. We use RAND in the loop
% increment to generate a different series of inputs for successive test
% runs.

% Parameter values for assertElementsAlmostEqual
tol_type = 'relative'; tol = 1e-4; floor_tol = 1e-4;

% Latitudes
signcode = 'ns';
incr = 0.1 + rand./10; % i.e. 0.1<=incr<=0.2
for i = -90 : incr : 90 
    s = coordinates(i,signcode);
    assertElementsAlmostEqual(i,s.deg.num,tol_type,tol,floor_tol);
    s = coordinates(s.deg.num,signcode);
    assertElementsAlmostEqual(i,s.deg.num,tol_type,tol,floor_tol);
    s = coordinates(s.deg.str,signcode);
    assertElementsAlmostEqual(i,s.deg.num,tol_type,tol,floor_tol);
    s = coordinates(s.dms.num,signcode);
    assertElementsAlmostEqual(i,s.deg.num,tol_type,tol,floor_tol);
    s = coordinates(s.dms.str,signcode);
    assertElementsAlmostEqual(i,s.deg.num,tol_type,tol,floor_tol);
end

% Longitudes
signcode = 'ew';
incr = 0.1 + rand./10; % i.e. 0.1<=incr<=0.2
for i = -180 : incr : 180
    s = coordinates(i,signcode);
    assertElementsAlmostEqual(i,s.deg.num,tol_type,tol,floor_tol);
    s = coordinates(s.deg.num,signcode);
    assertElementsAlmostEqual(i,s.deg.num,tol_type,tol,floor_tol);
    s = coordinates(s.deg.str,signcode);
    assertElementsAlmostEqual(i,s.deg.num,tol_type,tol,floor_tol);
    s = coordinates(s.dms.num,signcode);
    assertElementsAlmostEqual(i,s.deg.num,tol_type,tol,floor_tol);
    s = coordinates(s.dms.str,signcode);
    assertElementsAlmostEqual(i,s.deg.num,tol_type,tol,floor_tol);
end


% Next, a few cases of specific DMS string input

in = '0 30 0 N';
out.deg.num = 0.5000;
out.deg.str = ' 0.5000';
out.dms.num = [0 30 0];
out.dms.str = ' 0° 30'' 00.00" N ';
assertEqual(coordinates(in), out);

in = '0 30 0 S';
out.deg.num = -0.5000;
out.deg.str = '-0.5000';
out.dms.num = [0 -30 0];
out.dms.str = ' 0° 30'' 00.00" S ';
assertEqual(coordinates(in), out);

in = '0 30 0 E';
out.deg.num = 0.5000;
out.deg.str = ' 0.5000';
out.dms.num = [0 30 0];
out.dms.str = ' 0° 30'' 00.00" E ';
assertEqual(coordinates(in), out);

in = '0 30 0 W';
out.deg.num = -0.5000;
out.deg.str = '-0.5000';
out.dms.num = [0 -30 0];
out.dms.str = ' 0° 30'' 00.00" W ';
assertEqual(coordinates(in), out);


% And some with messy input

in = '0°30''0.0"N';
out.deg.num = 0.5000;
out.deg.str = ' 0.5000';
out.dms.num = [0 30 0];
out.dms.str = ' 0° 30'' 00.00" N ';
assertEqual(coordinates(in), out);

in = ' 0d-30m-0.0s-N ';
out.deg.num = 0.5000;
out.deg.str = ' 0.5000';
out.dms.num = [0 30 0];
out.dms.str = ' 0° 30'' 00.00" N ';
assertEqual(coordinates(in), out);


% Some known problems

%   The mapping toolbox function DEGREES2DMS produces inconsistent results:
%
%   degrees2dms(101.3)
%
%   returns
%        101.0000   17.0000   60.0000
% 
%   instead of
%        101.0000   18.0000   0.0000
%
%  I've added a fix in lines 83-86 of an overloaded copy of DEGREES2DMS.
signcode = 'ew';
i = 101.3;
s = coordinates(i,signcode);
t = coordinates(s.dms.str);
assertElementsAlmostEqual(i,t.deg.num,tol_type,tol,floor_tol);

% Finally, this case was producing an error before fixing the signval.
signcode = 'ns';
i = -0.5876;
s = coordinates(i,signcode);
t = coordinates(s.dms.num,signcode);
assertElementsAlmostEqual(i,t.deg.num,tol_type,tol,floor_tol);

