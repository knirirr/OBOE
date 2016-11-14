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
function c = cmap(option,a)

nullrow = [0 0 0];

switch option
    case 'globcover'
        c = repmat(nullrow,255,1);
        c(11,:)  = [170	240	240];
        c(14,:)  = [255	255	100];
        c(20,:)  = [220	240	100];
        c(30,:)  = [205	205	102];
        c(40,:)  = [0	100	0];
        c(50,:)  = [0	160	0];
        c(60,:)  = [170	200	0];
        c(70,:)  = [0	60	0];
        c(90,:)  = [40	100	0];
        c(100,:) = [120	130	0];
        c(110,:) = [140	160	0];
        c(120,:) = [190	150	0];
        c(130,:) = [150	100	0];
        c(140,:) = [255	180	50];
        c(150,:) = [255	235	175];
        c(160,:) = [0	120	90];
        c(170,:) = [0	150	120];
        c(180,:) = [0	220	130];
        c(190,:) = [195	20	0];
        c(200,:) = [255	245	215];
        c(210,:) = [0	70	200];
        c(220,:) = [255	255	255];
        c(230,:) = [0	0	0];
        % zero offset for uint8
        c = [nullrow; c]; 
        c = c ./ 255;
    case 'vulnerability'
        k = unique(a(:));
        c = repmat(0,max(k)+1,3);
        c(k+1,:) = jet(numel(k));
    case 'fragmentation'
        k = unique(a(:));
        c = repmat(0,max(k)+1,3);
        c(k+1,:) = jet(numel(k));
    case 'migratoryspecies'
        k = unique(a(:));
        c = repmat(0,max(k)+1,3);
        c(k+1,:) = jet(numel(k));
    case 'wetland'
        c = [.7 .7 .7; 1 0 0];
    case 'resilience'
        c = [.7 .7 .7; 0 0 .5; 1 0 0; 1 1 1];
    case 'summation'
        c = jet(255);
    otherwise
        c = jet;
end

