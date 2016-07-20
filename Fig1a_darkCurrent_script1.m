% ISO固定，考察曝光时间对暗电流的影响
flist = dir('E:\Dropbox\Works\papers\ResponsePrediction\Photos\1230\ISO200\*.pgm');
pathstr = 'E:\Dropbox\Works\papers\ResponsePrediction\Photos\1230\ISO200';
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
    Gi = G(MH-50:MH+50,MW-50:MW+50); N = numel(Gi); Gi = sort(Gi(:));Gi = mean(Gi(round(0.0025*N):round(0.975*N)));
    Bi = B(MH-50:MH+50,MW-50:MW+50); N = numel(Bi); Bi = sort(Bi(:));Bi = mean(Bi(round(0.0025*N):round(0.975*N)));
    Intensity(i,:) = [Ri, Gi, Bi];
    clear Ri Gi Bi
end
t = log([1/320 1/250 1/200 1/160 1/125 1/100 1/80 1/60 1/50 1/40 1/30 1/25 1/20 1/15 1/13 1/10]);
figure;
hold on;pg1 = plot(t,Intensity(:,2),'color',[144 237 125]/237,'lineWidth',1.5,'LineStyle','--',...
             'Marker','s','MarkerEdgeColor','none','MarkerFaceColor',[144 237 125]/255,'MarkerSize',8)
hold on;pr1 = plot(t,Intensity(:,1),'color',[192 70 61]/230,'lineWidth',1.5,'LineStyle','--',...
             'Marker','s','MarkerEdgeColor','none','MarkerFaceColor',[192 70 61]/255,'MarkerSize',8);
hold on;pb1 = plot(t,Intensity(:,3),'color',[124 181 240]/240,'lineWidth',1.5,'LineStyle','--',...
             'Marker','s','MarkerEdgeColor','none','MarkerFaceColor',[124 181 240]/255,'MarkerSize',8)

set(gca,'xtick',t,'xgrid','on','GridLineStyle','--');
set(gca,'xticklabel',{'$\frac{1}{320}$' '$\frac{1}{250}$' '$\frac{1}{200}$' '$\frac{1}{160}$' ...
                      '$\frac{1}{125}$' '$\frac{1}{100}$' '$\frac{1}{80}$' '$\frac{1}{60}$' ...
                      '$\frac{1}{50}$' '$\frac{1}{40}$' '$\frac{1}{30}$' '$\frac{1}{25}$' ...
                      '$\frac{1}{20}$' '$\frac{1}{15}$' '$\frac{1}{13}$' '$\frac{1}{10}$'},...
                      'TickLabelInterpreter','latex','FontSize',22);
xlabel('$\textrm{Exposure Time/s}$','Interpreter','latex','FontSize',24);
ylabel('$\textrm{Dark Current Level (in 14-bit)}$','Interpreter','latex','FontSize',24);
flist = dir('E:\Dropbox\Works\papers\ResponsePrediction\Photos\1230\ISO800\*.pgm');
pathstr = 'E:\Dropbox\Works\papers\ResponsePrediction\Photos\1230\ISO800';
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

hold on;pg2 = plot(t,Intensity(:,2),'color',[144 237 125]/237,'lineWidth',2,...
             'Marker','o','MarkerEdgeColor','none','MarkerFaceColor',[144 237 125]/255,'MarkerSize',8)
hold on;pr2 = plot(t,Intensity(:,1),'color',[192 70 61]/230,'lineWidth',2,...
             'Marker','o','MarkerEdgeColor','none','MarkerFaceColor',[192 70 61]/255,'MarkerSize',8);
hold on;pb2 = plot(t,Intensity(:,3),'color',[124 181 240]/240,'lineWidth',2,...
             'Marker','o','MarkerEdgeColor','none','MarkerFaceColor',[124 181 240]/255,'MarkerSize',8)
xlim([log(1/400) log(1/8)]);ylim([0 10]);
legend([pr1,pg1,pb1,pr2,pg2,pb2],{'\ Red Response, ISO 200','\ Green Response, ISO 200','\ Blue Response, ISO 200',...
                                 '\ Red Response, ISO 800','\ Green Response, ISO 800','\ Blue Response, ISO 800'},...
                                 'Interpreter','latex','FontSize',18,'Units','normalized','Position',[.71 .69 .1 .2],'box','off');
set(gcf,'color','w','Units','inches','Position',[2 2 8 6]);
set(gca,'Units','normalized','Position',[.12 .2 .83 .74]);
box on

% export_fig E:\Dropbox\Works\papers\ResponsePrediction\graphs\fig1a.png -r600