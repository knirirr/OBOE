% This source code is strictly private. The author does not give permission
% for it to be used for any purpose whatsoever, including, but not limited
% to reading, modifying, compiling or distributing. The author does not
% waived this privacy for any person or purpose.
% 
% Copyright 2012, neil.caithness@oerc.ox.ac.uk
function a = mysmoother(a)
%MYSMOOTHER     A 3x3 median filter
b = zeros(numel(a(2:end-1,2:end-1)),9);
k = a(1:end-2,1:end-2); b(:,1) = k(:);
k = a(1:end-2,2:end-1); b(:,2) = k(:);
k = a(1:end-2,3:end-0); b(:,3) = k(:);
k = a(2:end-1,1:end-2); b(:,4) = k(:);
k = a(2:end-1,2:end-1); b(:,5) = k(:);
k = a(2:end-1,3:end-0); b(:,6) = k(:);
k = a(3:end-0,1:end-2); b(:,7) = k(:);
k = a(3:end-0,2:end-1); b(:,8) = k(:);
k = a(3:end-0,3:end-0); b(:,9) = k(:);
a(2:end-1,2:end-1) = ...
    reshape(median(b,2),size(a(2:end-1,2:end-1)));

