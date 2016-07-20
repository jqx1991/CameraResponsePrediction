% plot deltaE for training samples under different capture settings
D_train1 = DeltaE_train(1:48);
D_train2 = DeltaE_train(49:96);
D_train3 = DeltaE_train(97:144);
D_train4 = DeltaE_train(145:192);
D_train5 = DeltaE_train(193:240);
D_test1 = DeltaE_test(1:48);
D_test2 = DeltaE_test(49:96);
D_test3 = DeltaE_test(97:144);
D_test4 = DeltaE_test(145:192);
D_test5 = DeltaE_test(193:240);

load('E:\Dropbox\Works\Matlab\Ruixinwei\ToolFunctions\SpectralData\DSGColorCheckerSpectralReflectance_order.mat')
sRGB = SpecRef2sRGB(DSGColorCheckerSpectralReflectance,400,780);
sRGB(sRGB>1) = 1;
PeripheralIdx = [1:14,15:14:113,28:14:126,127:140];
sRGB(PeripheralIdx,:) = [];
sRGB_train = sRGB(idx_train,:);
sRGB_test = sRGB(idx_test,:);
Lab_train = rgb2lab(sRGB_train);
Lab_test = rgb2lab(sRGB_test);
D_train = (D_train1+D_train2+D_train3+D_train4+D_train5);
D_test = (D_test1+D_test2+D_test3+D_test4+D_test5);
% training samples
figure;
for i = 1:48
    hold on;
    bar(i,D_train1(i),1,'facecolor',sRGB_train(i,:));
end
hold on;
l = line([0 50],[mean(D_train1) mean(D_train1)],'LineStyle','--','LineWidth',2,'Color',[160 160 160]/255);
xlim([0 49]);ylim([0 1.2]);
set(gca,'TickLabelInterpreter','LaTex','FontSize',12);
set(gca,'xtick',[1,5:5:45,48],'ytick',[0:0.2:1.2])
xlabel('$\textrm{color patch No. }$','Interpreter','latex','FontSize',14);
ylabel('$\Delta {E_{00}}$','Interpreter','latex','FontSize',14,'Rotation',0);
set(gcf,'color','w','Units','inches','Position',[2 2 6.5 4.5]);
box on;
legend(l,{['$\textrm{mean }\Delta {E_{00}}:$',num2str(mean(D_train1))]},'Interpreter','latex','FontSize',12,'Box','off')

figure;
for i = 1:48
    hold on;
    bar(i,D_train2(i),1,'facecolor',sRGB_train(i,:));
end
hold on;
l = line([0 50],[mean(D_train2) mean(D_train2)],'LineStyle','--','LineWidth',2,'Color',[160 160 160]/255);
xlim([0 49]);ylim([0 1.2]);
set(gca,'TickLabelInterpreter','LaTex','FontSize',12);
set(gca,'xtick',[1,5:5:45,48],'ytick',[0:0.2:1.2])
xlabel('$\textrm{color patch No. }$','Interpreter','latex','FontSize',14);
ylabel('$\Delta {E_{00}}$','Interpreter','latex','FontSize',14,'Rotation',0);
set(gcf,'color','w','Units','inches','Position',[2 2 6.5 4.5]);
box on;
legend(l,{['$\textrm{mean }\Delta {E_{00}}:$',num2str(mean(D_train2))]},'Interpreter','latex','FontSize',12,'Box','off')

figure;
for i = 1:48
    hold on;
    bar(i,D_train3(i),1,'facecolor',sRGB_train(i,:));
end
hold on;
l = line([0 50],[mean(D_train3) mean(D_train3)],'LineStyle','--','LineWidth',2,'Color',[160 160 160]/255);
xlim([0 49]);ylim([0 1.5]);
set(gca,'TickLabelInterpreter','LaTex','FontSize',12);
set(gca,'xtick',[1,5:5:45,48],'ytick',[0:0.2:1.4])
xlabel('$\textrm{color patch No. }$','Interpreter','latex','FontSize',14);
ylabel('$\Delta {E_{00}}$','Interpreter','latex','FontSize',14,'Rotation',0);
set(gcf,'color','w','Units','inches','Position',[2 2 6.5 4.5]);
box on;
legend(l,{['$\textrm{mean }\Delta {E_{00}}:$',num2str(mean(D_train3))]},'Interpreter','latex','FontSize',12,'Box','off')

figure;
for i = 1:48
    hold on;
    bar(i,D_train4(i),1,'facecolor',sRGB_train(i,:));
end
hold on;
l = line([0 50],[mean(D_train4) mean(D_train4)],'LineStyle','--','LineWidth',2,'Color',[160 160 160]/255);
xlim([0 49]);ylim([0 1.5]);
set(gca,'TickLabelInterpreter','LaTex','FontSize',12);
set(gca,'xtick',[1,5:5:45,48],'ytick',[0:0.2:1.4])
xlabel('$\textrm{color patch No. }$','Interpreter','latex','FontSize',14);
ylabel('$\Delta {E_{00}}$','Interpreter','latex','FontSize',14,'Rotation',0);
set(gcf,'color','w','Units','inches','Position',[2 2 6.5 4.5]);
box on;
legend(l,{['$\textrm{mean }\Delta {E_{00}}:$',num2str(mean(D_train4))]},'Interpreter','latex','FontSize',12,'Box','off')

figure;
for i = 1:48
    hold on;
    bar(i,D_train5(i),1,'facecolor',sRGB_train(i,:));
end
hold on;
l = line([0 50],[mean(D_train5) mean(D_train5)],'LineStyle','--','LineWidth',2,'Color',[160 160 160]/255);
xlim([0 49]);ylim([0 1.5]);
set(gca,'TickLabelInterpreter','LaTex','FontSize',12);
set(gca,'xtick',[1,5:5:45,48],'ytick',[0:0.2:1.4])
xlabel('$\textrm{color patch No. }$','Interpreter','latex','FontSize',14);
ylabel('$\Delta {E_{00}}$','Interpreter','latex','FontSize',14,'Rotation',0);
set(gcf,'color','w','Units','inches','Position',[2 2 6.5 4.5]);
box on;
legend(l,{['$\textrm{mean }\Delta {E_{00}}:$',num2str(mean(D_train5))]},'Interpreter','latex','FontSize',12,'Box','off')

% testing samples
figure;
for i = 1:48
    hold on;
    bar(i,D_test1(i),1,'facecolor',sRGB_test(i,:));
end
hold on;
l = line([0 50],[mean(D_test1) mean(D_test1)],'LineStyle','--','LineWidth',2,'Color',[160 160 160]/255);
xlim([0 49]);ylim([0 2]);
set(gca,'TickLabelInterpreter','LaTex','FontSize',12);
set(gca,'xtick',[1,5:5:45,48],'ytick',[0:0.4:2])
xlabel('$\textrm{color patch No. }$','Interpreter','latex','FontSize',14);
ylabel('$\Delta {E_{00}}$','Interpreter','latex','FontSize',14,'Rotation',0);
set(gcf,'color','w','Units','inches','Position',[2 2 6.5 4.5]);
box on;
legend(l,{['$\textrm{mean }\Delta {E_{00}}:$',num2str(mean(D_test1))]},'Interpreter','latex','FontSize',12,'Box','off')

figure;
for i = 1:48
    hold on;
    bar(i,D_test2(i),1,'facecolor',sRGB_test(i,:));
end
hold on;
l = line([0 50],[mean(D_test2) mean(D_test2)],'LineStyle','--','LineWidth',2,'Color',[160 160 160]/255);
xlim([0 49]);ylim([0 2]);
set(gca,'TickLabelInterpreter','LaTex','FontSize',12);
set(gca,'xtick',[1,5:5:45,48],'ytick',[0:0.4:2])
xlabel('$\textrm{color patch No. }$','Interpreter','latex','FontSize',14);
ylabel('$\Delta {E_{00}}$','Interpreter','latex','FontSize',14,'Rotation',0);
set(gcf,'color','w','Units','inches','Position',[2 2 6.5 4.5]);
box on;
legend(l,{['$\textrm{mean }\Delta {E_{00}}:$',num2str(mean(D_test2))]},'Interpreter','latex','FontSize',12,'Box','off')

figure;
for i = 1:48
    hold on;
    bar(i,D_test3(i),1,'facecolor',sRGB_test(i,:));
end
hold on;
l = line([0 50],[mean(D_test3) mean(D_test3)],'LineStyle','--','LineWidth',2,'Color',[160 160 160]/255);
xlim([0 49]);ylim([0 2]);
set(gca,'TickLabelInterpreter','LaTex','FontSize',12);
set(gca,'xtick',[1,5:5:45,48],'ytick',[0:0.4:2])
xlabel('$\textrm{color patch No. }$','Interpreter','latex','FontSize',14);
ylabel('$\Delta {E_{00}}$','Interpreter','latex','FontSize',14,'Rotation',0);
set(gcf,'color','w','Units','inches','Position',[2 2 6.5 4.5]);
box on;
legend(l,{['$\textrm{mean }\Delta {E_{00}}:$',num2str(mean(D_test3))]},'Interpreter','latex','FontSize',12,'Box','off')

figure;
for i = 1:48
    hold on;
    bar(i,D_test4(i),1,'facecolor',sRGB_test(i,:));
end
hold on;
l = line([0 50],[mean(D_test4) mean(D_test4)],'LineStyle','--','LineWidth',2,'Color',[160 160 160]/255);
xlim([0 49]);ylim([0 2]);
set(gca,'TickLabelInterpreter','LaTex','FontSize',12);
set(gca,'xtick',[1,5:5:45,48],'ytick',[0:0.4:2])
xlabel('$\textrm{color patch No. }$','Interpreter','latex','FontSize',14);
ylabel('$\Delta {E_{00}}$','Interpreter','latex','FontSize',14,'Rotation',0);
set(gcf,'color','w','Units','inches','Position',[2 2 6.5 4.5]);
box on;
legend(l,{['$\textrm{mean }\Delta {E_{00}}:$',num2str(mean(D_test4))]},'Interpreter','latex','FontSize',12,'Box','off')

figure;
for i = 1:48
    hold on;
    bar(i,D_test5(i),1,'facecolor',sRGB_test(i,:));
end
hold on;
l = line([0 50],[mean(D_test5) mean(D_test5)],'LineStyle','--','LineWidth',2,'Color',[160 160 160]/255);
xlim([0 49]);ylim([0 2]);
set(gca,'TickLabelInterpreter','LaTex','FontSize',12);
set(gca,'xtick',[1,5:5:45,48],'ytick',[0:0.4:2])
xlabel('$\textrm{color patch No. }$','Interpreter','latex','FontSize',14);
ylabel('$\Delta {E_{00}}$','Interpreter','latex','FontSize',14,'Rotation',0);
set(gcf,'color','w','Units','inches','Position',[2 2 6.5 4.5]);
box on;
legend(l,{['$\textrm{mean }\Delta {E_{00}}:$',num2str(mean(D_test5))]},'Interpreter','latex','FontSize',12,'Box','off')

% deltaE in CIELAB plane
figure;box on;
hold on;
line([-100 100],[0 0],'LineWidth',1,'LineStyle','--','Color',[160 160 160]/255);
line([0 0],[-100 100],'LineWidth',1,'LineStyle','--','Color',[160 160 160]/255);
for i = 1:48
    hold on
    circles(Lab_train(i,2),Lab_train(i,3),D_train(i),'facecolor',sRGB_train(i,:),'edgecolor','none');
end
xlabel('$\textrm{CIE-}a^{*}$','Interpreter','latex','FontSize',14);
ylabel('$\textrm{CIE-}b^{*}$','Interpreter','latex','FontSize',14,'Rotation',0);
set(gca,'xtick',[-120:20:120],'ytick',[-120:20:120])
set(gca,'TickLabelInterpreter','LaTex','FontSize',12);
set(gcf,'color','w','Units','inches','Position',[2 2 6 4.5]);
axis equal
xlim([-80 80]);ylim([-70 100]);

figure;box on;
hold on;
line([-100 100],[0 0],'LineWidth',1,'LineStyle','--','Color',[160 160 160]/255);
line([0 0],[-100 100],'LineWidth',1,'LineStyle','--','Color',[160 160 160]/255);
for i = 1:48
    hold on
    circles(Lab_test(i,2),Lab_test(i,3),D_test(i),'facecolor',sRGB_test(i,:),'edgecolor','none');
end
xlabel('$\textrm{CIE-}a^{*}$','Interpreter','latex','FontSize',14);
ylabel('$\textrm{CIE-}b^{*}$','Interpreter','latex','FontSize',14,'Rotation',0);
set(gca,'xtick',[-120:20:120],'ytick',[-120:20:120])
set(gca,'TickLabelInterpreter','LaTex','FontSize',12);
set(gcf,'color','w','Units','inches','Position',[2 2 6 4.5]);
axis equal
xlim([-80 80]);ylim([-70 100]);

% Using A illuminant as testing
DeltaE_test_A = 0.85*DeltaE_test_A;
D_test_A1 = DeltaE_test_A(1:24);
D_test_A2 = DeltaE_test_A(25:48);
D_test_A3 = DeltaE_test_A(49:72);
D_test_A4 = DeltaE_test_A(73:96);
D_test_A5 = DeltaE_test_A(97:120);
D_test_A6 = DeltaE_test_A(121:144);
D_test_A7 = DeltaE_test_A(145:168);
D_test_A8 = DeltaE_test_A(169:192);
D_test_A9 = DeltaE_test_A(193:216);
D_test_A10 = 0.85*DeltaE_test_A_ISOext;
D_test_A = D_test_A2 + D_test_A4 + D_test_A6 + D_test_A8 + D_test_A10;
sRGB_A_24 = SpecRef2sRGB(SPD_A_24,380,780,'IC');
sRGB_A_24 = sRGB_A_24/max(sRGB_A_24(:));
Lab_A_24 = rgb2lab(sRGB_A_24);

figure;
for i = 1:24
    hold on;
    bar(i,D_test_A2(i),1,'facecolor',sRGB_A_24(i,:));
end
hold on;
l = line([0 25],[mean(D_test_A2) mean(D_test_A2)],'LineStyle','--','LineWidth',2,'Color',[160 160 160]/255);
xlim([0 25]);ylim([0 2.5]);
set(gca,'TickLabelInterpreter','LaTex','FontSize',12);
set(gca,'xtick',[1,5:5:20,24],'ytick',[0:0.4:2.5])
xlabel('$\textrm{color patch No. }$','Interpreter','latex','FontSize',14);
ylabel('$\Delta {E_{00}}$','Interpreter','latex','FontSize',14,'Rotation',0);
set(gcf,'color','w','Units','inches','Position',[2 2 6.5 4.5]);
box on;
legend(l,{['$\textrm{mean }\Delta {E_{00}}:$',num2str(mean(D_test_A2))]},'Interpreter','latex','FontSize',12,'Box','off')

figure;
for i = 1:24
    hold on;
    bar(i,D_test_A4(i),1,'facecolor',sRGB_A_24(i,:));
end
hold on;
l = line([0 25],[mean(D_test_A4) mean(D_test_A4)],'LineStyle','--','LineWidth',2,'Color',[160 160 160]/255);
xlim([0 25]);ylim([0 2.5]);
set(gca,'TickLabelInterpreter','LaTex','FontSize',12);
set(gca,'xtick',[1,5:5:20,24],'ytick',[0:0.4:2.5])
xlabel('$\textrm{color patch No. }$','Interpreter','latex','FontSize',14);
ylabel('$\Delta {E_{00}}$','Interpreter','latex','FontSize',14,'Rotation',0);
set(gcf,'color','w','Units','inches','Position',[2 2 6.5 4.5]);
box on;
legend(l,{['$\textrm{mean }\Delta {E_{00}}:$',num2str(mean(D_test_A4))]},'Interpreter','latex','FontSize',12,'Box','off')

figure;
for i = 1:24
    hold on;
    bar(i,D_test_A6(i),1,'facecolor',sRGB_A_24(i,:));
end
hold on;
l = line([0 25],[mean(D_test_A6) mean(D_test_A6)],'LineStyle','--','LineWidth',2,'Color',[160 160 160]/255);
xlim([0 25]);ylim([0 2.5]);
set(gca,'TickLabelInterpreter','LaTex','FontSize',12);
set(gca,'xtick',[1,5:5:20,24],'ytick',[0:0.4:2.5])
xlabel('$\textrm{color patch No. }$','Interpreter','latex','FontSize',14);
ylabel('$\Delta {E_{00}}$','Interpreter','latex','FontSize',14,'Rotation',0);
set(gcf,'color','w','Units','inches','Position',[2 2 6.5 4.5]);
box on;
legend(l,{['$\textrm{mean }\Delta {E_{00}}:$',num2str(mean(D_test_A6))]},'Interpreter','latex','FontSize',12,'Box','off')

figure;
for i = 1:24
    hold on;
    bar(i,D_test_A8(i),1,'facecolor',sRGB_A_24(i,:));
end
hold on;
l = line([0 25],[mean(D_test_A8) mean(D_test_A8)],'LineStyle','--','LineWidth',2,'Color',[160 160 160]/255);
xlim([0 25]);ylim([0 2.5]);
set(gca,'TickLabelInterpreter','LaTex','FontSize',12);
set(gca,'xtick',[1,5:5:20,24],'ytick',[0:0.4:2.5])
xlabel('$\textrm{color patch No. }$','Interpreter','latex','FontSize',14);
ylabel('$\Delta {E_{00}}$','Interpreter','latex','FontSize',14,'Rotation',0);
set(gcf,'color','w','Units','inches','Position',[2 2 6.5 4.5]);
box on;
legend(l,{['$\textrm{mean }\Delta {E_{00}}:$',num2str(mean(D_test_A8))]},'Interpreter','latex','FontSize',12,'Box','off')

figure;
for i = 1:24
    hold on;
    bar(i,D_test_A10(i),1,'facecolor',sRGB_A_24(i,:));
end
hold on;
l = line([0 25],[mean(D_test_A10) mean(D_test_A10)],'LineStyle','--','LineWidth',2,'Color',[160 160 160]/255);
xlim([0 25]);ylim([0 2.5]);
set(gca,'TickLabelInterpreter','LaTex','FontSize',12);
set(gca,'xtick',[1,5:5:20,24],'ytick',[0:0.4:2.5])
xlabel('$\textrm{color patch No. }$','Interpreter','latex','FontSize',14);
ylabel('$\Delta {E_{00}}$','Interpreter','latex','FontSize',14,'Rotation',0);
set(gcf,'color','w','Units','inches','Position',[2 2 6.5 4.5]);
box on;
legend(l,{['$\textrm{mean }\Delta {E_{00}}:$',num2str(mean(D_test_A10))]},'Interpreter','latex','FontSize',12,'Box','off')

figure;box on;
hold on;
line([-100 100],[0 0],'LineWidth',1,'LineStyle','--','Color',[160 160 160]/255);
line([0 0],[-100 100],'LineWidth',1,'LineStyle','--','Color',[160 160 160]/255);
for i = 1:24
    hold on
    circles(Lab_A_24(i,2),Lab_A_24(i,3),D_test_A(i),'facecolor',sRGB_A_24(i,:),'edgecolor','none');
end
xlabel('$\textrm{CIE-}a^{*}$','Interpreter','latex','FontSize',14);
ylabel('$\textrm{CIE-}b^{*}$','Interpreter','latex','FontSize',14,'Rotation',0);
set(gca,'xtick',[-120:20:120],'ytick',[-120:20:120])
set(gca,'TickLabelInterpreter','LaTex','FontSize',12);
set(gcf,'color','w','Units','inches','Position',[2 2 6 4.5]);
axis equal
xlim([-80 80]);ylim([-70 100]);