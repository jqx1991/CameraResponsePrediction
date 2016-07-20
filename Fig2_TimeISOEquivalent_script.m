load('M:\D3x\Central\data\CentralData.mat')
for i = 4:5:479
    RGB_median(i-1,:) = RGB_median(i-1,:)*1.01;
    RGB_median(i,:) = RGB_median(i,:)*125/120;
    RGB_median(i+1,:) = RGB_median(i+1,:)*255/240;
end

ratio = zeros(480,3);
for i = 1:5:476
    ratio(i,:) = RGB_median(i,:)./RGB_median(i,:);
    ratio(i+1,:) = RGB_median(i+1,:)./RGB_median(i,:);
    ratio(i+2,:) = RGB_median(i+2,:)./RGB_median(i,:);
    ratio(i+3,:) = RGB_median(i+3,:)./RGB_median(i,:);
    ratio(i+4,:) = RGB_median(i+4,:)./RGB_median(i,:);
end

R = reshape(ratio(:,1),5,96)';
G = reshape(ratio(:,2),5,96)';
B = reshape(ratio(:,3),5,96)';
indR = R(:,5)>1.05 & R(:,4)>1.01 & R(:,3)>1;
indG = G(:,5)>1.05 & G(:,4)>1.01 & G(:,3)>1;
indB = B(:,5)>1.05 & B(:,4)>1.01 & B(:,3)>1;
R = R(indR,:);
G = G(indG,:);
B = B(indB,:);

I = imread('E:\index.png');
RGB = reshape(double(I(401:500,:,:)),100*1200,3);
[~,C] = kmeans(RGB,48);
clear I RGB
cmap = C;
cmap = cmap/255;

figure;
for i = 1:size(G,1)
    hold on;
    patchline([1 2 3 4 5],G(i,:),'edgecolor',cmap(i,:),'LineWidth',2,'EdgeAlpha',.7);
    scatter_patches([1 2 3 4 5],G(i,:),20,[],'s','FaceColor',cmap(i,:),'EdgeColor','none','FaceAlpha',.8);
end
xlim([0.5 5.5])
ylim([0.98 1.12])

xtl = {'\begin{tabular}{c} ISO 100, \\ 1/15\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 200, \\ 1/30\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 400, \\ 1/60\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 800, \\ 1/120\,s$^*$ \end{tabular}',...
       '\begin{tabular}{c} ISO 1600, \\ 1/240\,s$^*$ \end{tabular}'};
set(gca,'XTick',[1 2 3 4 5],'YTick',[1 1.04 1.08 1.12])
set(gca,'XTickLabel',xtl,'TickLabelInterpreter','latex','FontSize',20,...
        'xgrid','on','GridLineStyle','--')
xlabel('$\textrm{Exposure Setting}$','Interpreter','latex','FontSize',26);
ylabel('$\textrm{Normalized Response}$','Interpreter','latex','FontSize',26);
set(gcf,'color','w','Units','inches','Position',[2 2 8 6]);
set(gca,'Units','normalized','Position',[.16 .22 .80 .72]);
box on
