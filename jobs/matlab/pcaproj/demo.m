%%
[y,k,r,siz] = loadlayers;
save layers
% load layers

%%
[x,j,loc] = loadsamples(y,k,r,siz,'bradypus');
tx = false(size(loc,1),1);
w = randperm(numel(tx));
tx(w(1:round(numel(tx)*.25))) = true;
rx = ~tx;
speciesname = 'Bradypus variegatus (iPCA)';
[m,s,auc] = io(x(tx,:),y); 
t = m(j);
t = t(rx);
save bradypus
% load bradypus

%%
[x,j,loc] = loadsamples(y,k,r,siz,'microryzomys');
tx = false(size(loc,1),1);
w = randperm(numel(tx));
tx(w(1:round(numel(tx)*.75))) = true;
rx = ~tx;
speciesname = 'Microryzomys minutus';
[m,s,auc] = io(x(tx,:),y); 
t = m(j);
t = t(rx);
save microryzomys
% load microryzomys

%%
file = 'C:\Users\Neil\Documents\MaxEnt\tutorial-data\outputs\bradypus_variegatus.asc';
speciesname = 'Bradypus variegatus (MaxEnt)';
[z,r] = arcgridread(file);
m = z(k);
s = m(j);
t = [];
auc = roc(m,s);
save maxent
% load maxent

%%
nbins = (0.05:0.05:1)-(0.05/2);
color = 'jet';
figure('Renderer','zbuffer')

%%
subplot(3,3,[1 2 4 5 7 8])
colormap(eval(color));
map = nan(siz);
map(k) = m;
mapshow(map,r,'DisplayType','surface');
    hold on
    u = loc(tx,:);
    z_ = ones(size(u,1),1) + max(map(:));
    y_ = u(:,2);
    x_ = u(:,1);
    plot3(x_,y_,z_,'s', ...
        'MarkerFaceColor','r', ...
        'MarkerEdgeColor','w', ...
        'MarkerSize',5);
    u = loc(rx,:);
    z_ = ones(size(u,1),1) + max(map(:));
    y_ = u(:,2);
    x_ = u(:,1);
    plot3(x_,y_,z_,'s', ...
        'MarkerFaceColor','b', ...
        'MarkerEdgeColor','w', ...
        'MarkerSize',5);
title(speciesname, ...
    'FontAngle','italic', ...
    'FontSize',16)
axis off

%%
subplot(3,3,3)
histcbins(m,nbins,color);
title(sprintf('Background n = %i',numel(m)));

%%
if ~isempty(t)
    subplot(3,3,6)
    histcbins(t,nbins,color);
    title(sprintf('Test Sample n = %i',numel(t)));
end

%%
subplot(3,3,9)
plot([0 1],[0 1],':k')
hold on
if ~isempty(t)
    AUC_T = roc(m,t,10000); 
    plot(AUC_T.X,AUC_T.Y,'b','linewidth',2)
end
AUC_S = roc(m,s,10000); 
% if AUC_S.AUC >0.999, lw = 3; else lw = 2; end
plot(AUC_S.X,AUC_S.Y,'r','linewidth',3)
xlabel('Fallout'); %1 - Specificity - commission error
ylabel('Recall'); % Sensitivity - absence of omission error
if isempty(t)
    title(sprintf('ROC - AUC (S = %0.4f)',AUC_S.AUC))
else
    title(sprintf('ROC - AUC (S = %0.4f; T = %0.4f)',AUC_S.AUC,AUC_T.AUC))
end
