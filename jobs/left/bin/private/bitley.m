% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function [short,plus,qrcode] = bitley(long)

url = [ ...
    'http://api.bitly.com/v3/shorten?' ...
    'login=neilcaithness&' ...
    'apiKey=R_440eadf8a89cb0968b60112b9e3d5fbc&' ...
    'longUrl=' urlencode(long) '&format=txt'];

short = deblank(urlread(url));
plus = [short '+'];
qrcode = [short '.qrcode'];

