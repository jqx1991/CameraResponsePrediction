load('E:\Dropbox\Works\Matlab\Papers\ResponsePrediction\cameraRGB2XYZ.mat')
XYZ_measured_temp = xlsread('E:\Dropbox\Works\papers\ResponsePrediction\DSG_D3x_Central.csv',1,'O15:Q206');
for i = 1:96
    XYZ_measured(i,:) = (XYZ_measured_temp(2*i-1,:) + XYZ_measured_temp(2*i,:))/2;
end
clear XYZ_measured_temp

load('M:\D3x\Central\data\RGB_mean_ranked.mat');
for i = 1:5
    RGB_measured = RGB_mean_ranked(96*(i-1)+1:96*i, :);
    R = RGB_measured(:,1);G = RGB_measured(:,2);B = RGB_measured(:,3);
    RootPolyRGB{i} = [R, G, B, sqrt(R.*G), sqrt(G.*B), sqrt(R.*B),...
              (R.*G.^2).^(1/3), (G.*B.^2).^(1/3), (R.*B.^2).^(1/3), (G.*R.^2).^(1/3), (B.*G.^2).^(1/3), (B.*R.^2).^(1/3), (R.*G.*B).^(1/3),...
              (R.*G.^3).^(1/4), (G.*B.^3).^(1/4), (R.*B.^3).^(1/4), (G.*R.^3).^(1/4), (B.*G.^3).^(1/4), (B.*R.^3).^(1/4),...
              (R.^2.*G.*B).^(1/4), (G.^2.*R.*B).^(1/4), (B.^2.*R.*G).^(1/4)];
    clear RGB_measured R G B
end
clear RGB_mean_ranked
for i = 1:5
    XYZ_predicted{i} = RootPolyRGB{i}*RGB2XYZ;
    DeltaE{i} = sRGB2CIEDeltaE(XYZ_measured/100,XYZ_predicted{i}/100,'cie00','XYZ');
    DeltaE_mean(i) = mean(DeltaE{i});
    SEM(i,:) = std(DeltaE{i})/sqrt(length(DeltaE{i})); % Standard Error
    ts(i,:) = tinv([0.05  0.95],length(DeltaE{i})-1); % T-Score
    CI(i,:) = ts(i,:)*SEM(i);
end

figure;
hold on;
patch([0 1.5 1.5 0],[0 0 3 3],[255 247 226]/255,'EdgeColor','none');
patch([1.5 6 6 1.5],[0 0 3 3],[238 250 255]/255,'EdgeColor','none');
bar(1:5,DeltaE_mean,0.575,'FaceColor', [229,145,151]/255);
errorbar(1:5, DeltaE_mean', CI(:,1),CI(:,2), 'LineStyle', 'none','Color', 'k','LineWidth',1);

xtl = {'\begin{tabular}{c} ISO 100, \\ 1/15\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 200, \\ 1/30\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 400, \\ 1/60\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 800, \\ 1/125\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 1600, \\ 1/250\,s \end{tabular}'};
set(gca,'XTick',[1 2 3 4 5],'Ytick',[0:1:6],'XTickLabel',xtl,'TickLabelInterpreter','latex','FontSize',20);
xlim([0.45 5.55]);
ylim([0 3])
xlabel('$\textrm{Exposure Setting}$','Interpreter','latex','FontSize',24);
ylabel('$\textrm{Color Difference } \Delta{}E_{00}$','Interpreter','latex','FontSize',24);
set(gcf,'color','w','Units','inches','Position',[2 2 7.9 6]);
set(gca,'Units','normalized','Position',[.13 .24 .82 .70]);
box on;
text(1.71,1.75,'$\overbrace{\hspace{234pt}}$','Interpreter','latex','FontSize',14);
text(0.7,1.75,'$\overbrace{\hspace{42pt}}$','Interpreter','latex','FontSize',14);
text(3.5,2.05,'$\textrm{Testing}$','Interpreter','latex','FontSize',22,'HorizontalAlignment','Center');
text(1,2.05,'$\textrm{Training}$','Interpreter','latex','FontSize',20,'HorizontalAlignment','Center')