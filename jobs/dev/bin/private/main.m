function data = main(data)
% MAIN  
%
% Implemented for automation on the VIBRANT/OBOE automation server.
%
% Copyright 2012, neil.caithness@oerc.ox.ac.uk

% ------------------------------------------------------------------------
% Make a Geographic Data Structure from DATA.ARGS.COORDS
[data.gds,~,~] = readwkt(data.args.coords);
logmsg(0,'Coordinates read (%0.2f(North), %0.2f(South), %0.2f(West), %0.2f(East))', ...
    data.gds.BoundingBox(2,2),data.gds.BoundingBox(1,2), ...
    data.gds.BoundingBox(1,1),data.gds.BoundingBox(2,1));
% ------------------------------------------------------------------------
% Extract the subregions from the global Globcover images
glob = getglobcover(fullfile(data.dir.data,'globcover',''),data.gds);
logmsg(0,'Globcover images read (%i rows x %i cols)',size(glob.a5))
% ------------------------------------------------------------------------
% Calculate the difference matrix
xd(glob.id) = 1:numel(glob.id); % reverse index
u5 = setdiff(unique(glob.a5),0);
d = nan(numel(glob.id));
for i = 1:numel(u5)
    k = glob.a5(:)==u5(i);
    uk = unique(glob.a9(k));
    for j = 1:numel(uk)
        d(xd(u5(i)),xd(uk(j))) = sum(glob.a9(k)==uk(j));
    end
end
d = d ./ glob.nmask .* 100;
logmsg(0,'Globcover change matrix calculated (%0.0f%%%% no change)', ...
    nansum(diag(d)));
% ------------------------------------------------------------------------
s5 = nansum(d,2);
s9 = nansum(d);
diff = s9(:)-s5(:);
nloosers = -sum(diff<0);
ngainers = sum(diff>0);
% ------------------------------------------------------------------------
[ns,ew] = shift(glob.a5,glob.a9,glob.id);
% ------------------------------------------------------------------------
changeMatrix = data.dir.work.output.data.change_matrix_xlsx;
xlswrite(changeMatrix,d,'C3:Y25')
sum5 = nansum(d,2); 
sum5(sum5==0) = nan;
sum9 = nansum(d,1); 
sum9(sum9==0) = nan;
diff = sum5-sum9';
sumd = nansum(diag(d));
xlswrite(changeMatrix,sum5,'AA3:AA25')
xlswrite(changeMatrix,sum9','AB3:AB25')
xlswrite(changeMatrix,diff,'AC3:AC25')
xlswrite(changeMatrix,sum9,'C27:Y27')
xlswrite(changeMatrix,sumd,'Z26:Z26')
xlswrite(changeMatrix,[ngainers;nloosers],'AC26:AC27')
xlswrite(changeMatrix,[glob.ntotal;glob.nmask],'AE26:AE27')
xlswrite(changeMatrix,nan,'B2:B2') % this just repositions the cell selection
logmsg(0,'Change matrix spreadsheet written');
% ------------------------------------------------------------------------
% mapshow(glob.a5,glob.refmat)
% figure
% mapshow(glob.a9,glob.refmat)
% ------------------------------------------------------------------------
% Set the job status flags
if isempty(data.job.status), data.job.status = 'Success'; end
if isempty(data.job.exception), data.job.exception = 'None'; end
% ------------------------------------------------------------------------



% ------------------------------------------------------------------------
% SHIFT
function [ns,ew] = shift(a5,a9,id)

[ns,ew] = deal(nan(size(a5,1),1));

for i = 1:numel(id)
    % north-south
    k5 = a5==id(i);
    a5_ = sum(k5,2);
    k5_ = 1:numel(a5_);
    j5 = sum(a5_(:).*k5_(:))./sum(a5_);
    k9 = a9==id(i);
    a9_ = sum(k9,2);
    k9_ = 1:numel(a9_);
    j9 = sum(a9_(:).*k9_(:))./sum(a9_);
    ns(i) = -(j9 - j5);
    % east-west
    k5 = a5==id(i);
    a5_ = sum(k5,1);
    k5_ = 1:numel(a5_);
    j5 = sum(a5_(:).*k5_(:))./sum(a5_);
    k9 = a9==id(i);
    a9_ = sum(k9,1);
    k9_ = 1:numel(a9_);
    j9 = sum(a9_(:).*k9_(:))./sum(a9_);
    ew(i) = (j9 - j5);
end

ns = ns .* (1/360);
ew = ew .* (1/360);
% ------------------------------------------------------------------------
