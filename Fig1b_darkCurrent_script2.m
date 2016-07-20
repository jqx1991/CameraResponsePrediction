% 曝光时间固定，考察ISO对暗电流的影响
flist = dir('E:\Dropbox\Works\papers\ResponsePrediction\Photos\1230\0.00625s\*.pgm');
pathstr = 'E:\Dropbox\Works\papers\ResponsePrediction\Photos\1230\0.00625s';
for i = 1:length(flist)
    subFileName = [pathstr,'\',flist(i).name];
    I = double(imread(subFileName));
    [height, width] = size(I);
    R = I(1:2:end,1:2:end);
    Gr = I(1:2:end,2:2:end);
    Gb = I(2:2:end,1:2:end);
    B = I(2:2:end,2:2:end);
    G = (Gr+Gb)/2;
    MH = round(height/4);
    MW = round(width/4);
    Ri = R(MH-50:MH+50,MW-50:MW+50); N = numel(Ri); Ri = sort(Ri(:));Ri = mean(Ri(round(0.025*N):round(0.975*N)));
    Gi = G(MH-50:MH+50,MW-50:MW+50); N = numel(Gi); Gi = sort(Gi(:));Gi = mean(Gi(round(0.025*N):round(0.975*N)));
    Bi = B(MH-50:MH+50,MW-50:MW+50); N = numel(Bi); Bi = sort(Bi(:));Bi = mean(Bi(round(0.025*N):round(0.975*N)));
    Intensity(i,:) = [Ri, Gi, Bi];
    clear Ri Gi Bi
end
ISO = log([100 125 160 200 250 320 400 500 640 800 1000 1250 1600]);
figure;
hold on;pg1 = plot(ISO,Intensity(:,2),'color',[144 237 125]/237,'lineWidth',1.5,'LineStyle','--',...
             'Marker','s','MarkerEdgeColor','none','MarkerFaceColor',[144 237 125]/255,'MarkerSize',8)
hold on;pr1 = plot(ISO,Intensity(:,1),'color',[192 70 61]/230,'lineWidth',1.5,'LineStyle','--',...
             'Marker','s','MarkerEdgeColor','none','MarkerFaceColor',[192 70 61]/255,'MarkerSize',8);
hold on;pb1 = plot(ISO,Intensity(:,3),'color',[124 181 240]/240,'lineWidth',1.5,'LineStyle','--',...
             'Marker','s','MarkerEdgeColor','none','MarkerFaceColor',[124 181 240]/255,'MarkerSize',8)
set(gca,'xtick',ISO,'xgrid','on','GridLineStyle','--','XTickLabelRotation',45);
set(gca,'xticklabel',{'100' '125' '160' '200' ...
                      '250' '320' '400' '500' ...
                      '640' '800' '1000' '1250' ...
                      '1600'},...
                      'TickLabelInterpreter','latex','FontSize',22);
xlabel('$\textrm{ISO Sensitivity}$','Interpreter','latex','FontSize',24);
ylabel('$\textrm{Dark Current Level (in 14-bit)}$','Interpreter','latex','FontSize',24);

flist = dir('E:\Dropbox\Works\papers\ResponsePrediction\Photos\1230\0.025s\*.pgm');
pathstr = 'E:\Dropbox\Works\papers\ResponsePrediction\Photos\1230\0.025s';
for i = 1:length(flist)
    subFileName = [pathstr,'\',flist(i).name];
    I = double(imread(subFileName));
    [height, width] = size(I);
    R = I(1:2:end,1:2:end);
    Gr = I(1:2:end,2:2:end);
    Gb = I(2:2:end,1:2:end);
    B = I(2:2:end,2:2:end);
    G = (Gr+Gb)/2;
    MH = round(height/4);
    MW = round(width/4);
    Ri = R(MH-50:MH+50,MW-50:MW+50); N = numel(Ri); Ri = sort(Ri(:));Ri = mean(Ri(round(0.025*N):round(0.975*N)));
    Gi = G(MH-50:MH+50,MW-50:MW+50); N = numel(Gi); Gi = sort(Gi(:));Gi = mean(Gi(round(0.025*N):round(0.975*N)));
    Bi = B(MH-50:MH+50,MW-50:MW+50); N = numel(Bi); Bi = sort(Bi(:));Bi = mean(Bi(round(0.025*N):round(0.975*N)));
    Intensity(i,:) = [Ri, Gi, Bi];
    clear Ri Gi Bi
end
hold on;pg2 = plot(ISO,Intensity(:,2),'color',[144 237 125]/237,'lineWidth',2,...
             'Marker','o','MarkerEdgeColor','none','MarkerFaceColor',[144 237 125]/255,'MarkerSize',8)
hold on;pr2 = plot(ISO,Intensity(:,1),'color',[192 70 61]/230,'lineWidth',2,...
             'Marker','o','MarkerEdgeColor','none','MarkerFaceColor',[192 70 61]/255,'MarkerSize',8);
hold on;pb2 = plot(ISO,Intensity(:,3),'color',[124 181 240]/240,'lineWidth',2,...
             'Marker','o','MarkerEdgeColor','none','MarkerFaceColor',[124 181 240]/255,'MarkerSize',8)
xlim([log(80) log(2000)]);ylim([0 10]);
legend([pr1,pg1,pb1,pr2,pg2,pb2],{'\ Red Response, 1/160\,s','\ Green Response, 1/160\,s','\ Blue Response, 1/160\,s',...
                                 '\ Red Response, 1/40\,s','\ Green Response, 1/40\,s','\ Blue Response, 1/40\,s'},...
                                 'Interpreter','latex','FontSize',18,'Units','normalized','Position',[.71 .69 .1 .2],'box','off');
set(gcf,'color','w','Units','inches','Position',[2 2 8 6]);
set(gca,'Units','normalized','Position',[.12 .2 .83 .74]);
box on

% export_fig E:\Dropbox\Works\papers\ResponsePrediction\graphs\fig1b.png -r600