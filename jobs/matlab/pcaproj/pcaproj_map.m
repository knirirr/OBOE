function [map,r,q,p,model] = pcaproj_map(sampesfile,layersdir,outputdir)

% samplesfile = 'C:\Users\Neil\Documents\MaxEnt\tutorial-data\swd\bradypus_swd.csv';
% layersdir = 'C:\Users\Neil\Documents\MaxEnt\tutorial-data\layers';
% outputdir = 'C:\Users\Neil\Documents\SVN\jobs\matlab\pcaproj';
% 
% 
% [num,txt,raw] = xlsread(samplesfile);
% x_loc = num(:,1:2);
% x = num(:,3:end);
% 
% fprintf(1,'Reading samples from:\n%s\n',samplesfile);
% fprintf(1,'The samples matrix is %i-by-%i cells\n\n',size(x,1),size(x,2));
% 
% 
% files = dir(layersdir);
% y = [];
% fprintf(1,'Reading layers files from:\n%s\n',layersdir);
% for i = 1:numel(files)
%     [~,~,ext] = fileparts(files(i).name);
%     if strcmp(ext,'.asc')
%         fprintf(1,'    %s\n',files(i).name);
%         file = fullfile(layersdir, files(i).name);
%         [z,r] = arcgridread(file);
%         y(:,end+1) = z(:);
%     end
% end
% k = all(~isnan(y),2);
% y = y(k,:);
% 
% fprintf(1,'\nThe map matrix is %i-by-%i pixels\n',size(z));
% fprintf(1,'The projection matrix is %i-by-%i cells\n',size(y,1),size(y,2));
% fprintf(1,'\nREFMAT\n  %8.4f %8.4f\n  %8.4f %8.4f\n  %8.4f %8.4f\n\n',r');
load state

tic

[q,model] = pcaproj(x,[],size(x,2));
p = pcaproj(y,model);
map = nan(size(z));
map(k) = p;

% [w,i] = sort(rand(size(y,1),1));
% Y = y(i(1:10000),:);
Y = y;

[Q,MODEL] = pcaproj(Y,[],size(Y,2));
P = pcaproj(y,MODEL);
MAP = nan(size(z));
MAP(k) = P;


etime = toc;
fprintf(1,'Model and projection completed in %2.4f seconds\n',etime);

