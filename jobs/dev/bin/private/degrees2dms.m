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
function dms = degrees2dms(angleInDegrees)
%DEGREES2DMS Convert degrees to degrees-minutes-seconds
%       This is a local overloaded copy of DEGREES2DMS to fix a floating
%       point tolerence issue. Consider this:
%
%             degrees2dms(101.3)
%
%       returns
% 
%              101.0000   17.0000   60.0000
%
%       instead of
% 
%              101.0000   18.0000   0.0000
%
%       It's easy to find the range of values returning incorrect
%       results. I've added a quick fix in lines 83-86. (NC)
%
%   DMS = degrees2dms(angleInDegrees) converts angles from values in
%   degrees which may include a fractional part (sometimes called
%   "decimal degrees") to degree-minutes-seconds representation.
%
%   The input should be a real-valued column vector.  Given N-by-1
%   input, DMS will be N-by-3, with one row per input angle.
%  
%   The first column of DMS contains the "degrees" element and is
%   integer-valued.  The second column contains the "minutes" element
%   and is integer-valued.  The third column contains the "seconds"
%   element, and may have a non-zero fractional part.
%  
%   In any given row of DMS, the sign of the first non-zero element indicates
%   the sign of the overall angle.  A positive number indicates north
%   latitude or east longitude; a negative number indicates south
%   latitude or west longitude.  Any remaining elements in that row will
%   have non-negative values.
%  
%   Example
%   -------
%   format long g
%   angleInDegrees = [ 30.8457722555556; ...
%                     -82.0444189583333; ...
%                      -0.504756513888889;...
%                       0.004116666666667];
%  
%   dms = degrees2dms(angleInDegrees)
%  
%   % Convert angles to a string, with each angle on its own line.
%   nonnegative = all((dms >= 0),2);
%   hemisphere = repmat('N', size(nonnegative));
%   hemisphere(~nonnegative) = 'S';
%   absvalues = num2cell(abs(dms'));
%   values = [absvalues; num2cell(hemisphere')];
%   str = sprintf('%2.0fd%2.0fm%7.5fs%s\n', values{:})
%  
%   % Split the string into cells as delimited by the newline
%   % character, then return to the original values using STR2ANGLE.
%   newline = sprintf('\n');
%   C = textscan(str,'%s',-1,'delimiter',newline);
%   a = deal(C{:});
%   for k = 1:numel(a)
%       str2angle(a{k})
%   end
%  
%   See also: dms2degrees, degtorad, degrees2dm, radtodeg.

% Copyright 2006-2009 The MathWorks, Inc.
% $Revision: 1.1.6.3 $  $Date: 2009/11/09 16:25:35 $

% Ensure column-vector input.
inputSize = size(angleInDegrees);
angleInDegrees = angleInDegrees(:);
if ~isequal(size(angleInDegrees),inputSize)
    wid = sprintf('%s:%s:reshapingInput', 'map', mfilename);
    warning(wid,...
        'Reshaping input into %d-by-1 column vector.  Output will be %d-by-3.',...
        numel(angleInDegrees), numel(angleInDegrees));
end

% Construct a DMS array in which each nonzero
% element in a given row has the same sign.
minutes = 60*rem(angleInDegrees,1);

% ---- Fix for floating point tolerence -------------------------------
mytol = 1/sqrt(eps); 
minutes = round(minutes*mytol)/mytol;
% ---- End Fix (NC) ---------------------------------------------------

dms = [fix(angleInDegrees) fix(minutes) 60*rem(minutes,1)];

% Flip the sign in the seconds column (from negative to positive)
% if either degrees or minutes is negative.
negativeDorM = any(dms(:,1:2) < 0, 2);
dms(negativeDorM,3) = -dms(negativeDorM,3);

% Flip the sign in the minutes column (from negative to positive)
% if degrees is negative.
negativeD = (dms(:,1) < 0);
dms(negativeD,2) = -dms(negativeD,2);
