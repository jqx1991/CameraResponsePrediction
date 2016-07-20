load('M:\D3x\Central\data\RGB_mean_ranked.mat')
load('E:\Dropbox\Works\MyPapers\ResponsePrediction\SPD_Central.mat')
for i = 1:96
SPD(i,:) = (SPD_Central(2*i-1,:)+SPD_Central(2*i,:))/2;
end
SPD = SPD(:,1:5:end);
idx_train = minCondSubset(SPD',48);
idx_test = setdiff([1:96],idx_train);
SPD_train = repmat(SPD(idx_train,:),5,1);
SPD_test  = repmat(SPD(idx_test, :),5,1);
RGB_train = RGB_mean_ranked([idx_train,idx_train+96,idx_train+192,idx_train+288,idx_train+384],:);
RGB_test  = RGB_mean_ranked([idx_test, idx_test+96, idx_test+192, idx_test+288, idx_test+384], :);
load('E:\Dropbox\Works\Matlab\Papers\ResponsePrediction\result_20160314.mat')
ISO = [1, 2, 4, 8, 16];
ExposureTime = [1/15, 1/30, 1/60, 1/125, 1/250];
[DeltaE_test, RelativeError_test] = CameraResponseTesting(RGB_test,SPD_test,CSS,nonlinearCoef,CrossTalkMtx,ISO,ExposureTime);

load('E:\Dropbox\Works\Matlab\Ruixinwei\ToolFunctions\SpectralData\DSGColorCheckerSpectralReflectance_order.mat')
sRGB = SpecRef2sRGB(DSGColorCheckerSpectralReflectance,400,780);
sRGB(sRGB>1) = 1;
PeripheralIdx = [1:14,15:14:113,28:14:126,127:140];
sRGB(PeripheralIdx,:) = [];
sRGB_train = sRGB(idx_train,:);
sRGB_test = sRGB(idx_test,:);
Lab_train = rgb2lab(sRGB_train);
Lab_test = rgb2lab(sRGB_test);
% Training samples
D_train{1} = DeltaE_train(1:48);
D_train{2} = DeltaE_train(49:96);
D_train{3} = DeltaE_train(97:144);
D_train{4} = DeltaE_train(145:192);
D_train{5} = DeltaE_train(193:240);
for i = 1:5
    Mean(i,:) = mean(D_train{i});
    SEM(i,:) = std(D_train{i})/sqrt(length(D_train{i})); % Standard Error
    ts(i,:) = tinv([0.05  0.95],length(D_train{i})-1); % T-Score
    CI(i,:) = ts(i,:)*SEM(i);
end
figure;
hold on;
for i = 1:5
    bar(i,Mean(i),0.6,'FaceColor', [119 163 188]/255);
end
errorbar([1:5], Mean, CI(:,1),CI(:,2), 'LineStyle', 'none','Color', 'k','LineWidth',1);
xtl = {'\begin{tabular}{c} ISO 100, \\ 1/15\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 200, \\ 1/30\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 400, \\ 1/60\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 800, \\ 1/125\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 1600, \\ 1/250\,s \end{tabular}'};
set(gca,'XTick',[1 2 3 4 5],'Position',[.14 .22 .81 .72])
set(gca,'XTickLabel',xtl,'TickLabelInterpreter','latex','FontSize',18)
xlabel('$\textrm{Exposure Setting}$','Interpreter','latex','FontSize',24);
ylabel('Color Difference $\Delta E_{00}$','Interpreter','latex','FontSize',24);
xlim([0.5 5.5]);ylim([0 2])
box on
set(gcf,'color','w','Units','inches','Position',[2 2 8 6]);
% Colors distribution in CIELab a*b*plane
Radii_train = (D_train{1}+D_train{2}+D_train{3}+D_train{4}+D_train{5})/5;
figure;box on;
hold on;
line([-100 100],[0 0],'LineWidth',2,'LineStyle','--','Color',[160 160 160]/255);
line([0 0],[-100 100],'LineWidth',2,'LineStyle','--','Color',[160 160 160]/255);
for i = 1:48
    hold on
    circles(Lab_train(i,2),Lab_train(i,3),5*Radii_train(i),'facecolor',sRGB_train(i,:),'edgecolor','none');
end
xlabel('$\textrm{CIE - }a^{*}$','Interpreter','latex','FontSize',26);
ylabel('$\textrm{CIE - }b^{*}$','Interpreter','latex','FontSize',26,'Rotation',90);
set(gca,'xtick',[-80:20:120],'ytick',[-120:20:120],'Position',[.17 .16 .78 .78])
set(gca,'TickLabelInterpreter','LaTex','FontSize',20);
set(gcf,'color','w','Units','inches','Position',[2 2 6.5 6]);
axis equal
xlim([-80 80]);ylim([-60 100]);

% Testing samples
clear Mean SEM ts CI
D_test{1} = DeltaE_test(1:48);
D_test{2} = DeltaE_test(49:96);
D_test{3} = DeltaE_test(97:144);
D_test{4} = DeltaE_test(145:192);
D_test{5} = DeltaE_test(193:240);
for i = 1:5
    Mean(i,:) = mean(D_test{i});
    SEM(i,:) = std(D_test{i})/sqrt(length(D_test{i})); % Standard Error
    ts(i,:) = tinv([0.05  0.95],length(D_test{i})-1); % T-Score
    CI(i,:) = ts(i,:)*SEM(i);
end
figure;
hold on;
for i = 1:5
    bar(i,Mean(i),0.6,'FaceColor', [119 163 188]/255);
end
errorbar([1:5], Mean, CI(:,1),CI(:,2), 'LineStyle', 'none','Color', 'k','LineWidth',1);
xtl = {'\begin{tabular}{c} ISO 100, \\ 1/15\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 200, \\ 1/30\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 400, \\ 1/60\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 800, \\ 1/125\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 1600, \\ 1/250\,s \end{tabular}'};
set(gca,'XTick',[1 2 3 4 5],'Position',[.14 .22 .81 .72])
set(gca,'XTickLabel',xtl,'TickLabelInterpreter','latex','FontSize',18)
xlabel('$\textrm{Exposure Setting}$','Interpreter','latex','FontSize',24);
ylabel('Color Difference $\Delta E_{00}$','Interpreter','latex','FontSize',24);
xlim([0.5 5.5]);ylim([0 2])
box on
set(gcf,'color','w','Units','inches','Position',[2 2 8 6]);
% Colors distribution in CIELab a*b*plane
Radii_test = (D_test{1}+D_test{2}+D_test{3}+D_test{4}+D_test{5})/5;
figure;box on;
hold on;
line([-100 100],[0 0],'LineWidth',2,'LineStyle','--','Color',[160 160 160]/255);
line([0 0],[-100 100],'LineWidth',2,'LineStyle','--','Color',[160 160 160]/255);
for i = 1:48
    hold on
    circles(Lab_test(i,2),Lab_test(i,3),5*Radii_test(i),'facecolor',sRGB_test(i,:),'edgecolor','none');
end
xlabel('$\textrm{CIE - }a^{*}$','Interpreter','latex','FontSize',26);
ylabel('$\textrm{CIE - }b^{*}$','Interpreter','latex','FontSize',26,'Rotation',90);
set(gca,'xtick',[-80:20:120],'ytick',[-120:20:120],'Position',[.17 .16 .78 .78])
set(gca,'TickLabelInterpreter','LaTex','FontSize',20);
set(gcf,'color','w','Units','inches','Position',[2 2 6.5 6]);
axis equal
xlim([-80 80]);ylim([-60 100]);

% A illuminant testing
clear all
load('M:\D3x\A\data\RGB_mean_ranked.mat')
load('E:\Dropbox\Works\papers\ResponsePrediction\SPD_Central_A.mat')
for i = 1:24
    SPD_A_24(i,:) = (SPD_Central_A(2*i-1,:)+SPD_Central_A(2*i,:))/2;
end
SPD_A_24 = SPD_A_24(:,1:5:end);
SPD_A_24x9 = repmat(SPD_A_24,9,1);
clear ISO ExposureTime
ISO = [1, 1.25, 2, 2.5, 4, 5, 8, 10, 32];
ExposureTime = [1/15, 1/20, 1/30, 1/40, 1/60, 1/80, 1/125, 1/160, 1/500];
load('E:\Dropbox\Works\Matlab\Papers\ResponsePrediction\result_20160314.mat')
[DeltaE_test_A, RelativeError_test_A] = CameraResponseTesting(RGB_mean_ranked,SPD_A_24x9,CSS,nonlinearCoef,CrossTalkMtx,ISO,ExposureTime);
clear RGB_mean_ranked
load('M:\D3x\A_ISOext\data\RGB_mean_ranked.mat')
load('E:\Dropbox\Works\papers\ResponsePrediction\SPD_Central_A_ISOext.mat')
RGB_mean_ranked = RGB_mean_ranked(1:24,:); % exclude photos with ISO6400
SPD_Central_A_ISOext = SPD_Central_A_ISOext(:,1:5:end);
ISO = [32];
ExposureTime = [1/500];
[DeltaE_test_A_ISOext, RelativeError_test_A_ISOext] = CameraResponseTesting(RGB_mean_ranked,SPD_Central_A_ISOext,CSS,nonlinearCoef,CrossTalkMtx,ISO,ExposureTime);
D_test{1} = DeltaE_test_A(25:48);
D_test{2} = DeltaE_test_A(73:96);
D_test{3} = DeltaE_test_A(121:144);
D_test{4} = DeltaE_test_A(169:192);
D_test{5} = DeltaE_test_A_ISOext(1:24);

for i = 1:5
    Mean(i,:) = mean(D_test{i});
    SEM(i,:) = std(D_test{i})/sqrt(length(D_test{i})); % Standard Error
    ts(i,:) = tinv([0.05  0.95],length(D_test{i})-1); % T-Score
    CI(i,:) = ts(i,:)*SEM(i);
end
figure;
hold on;
for i = 1:5
    bar(i,Mean(i),0.6,'FaceColor', [119 163 188]/255);
end
errorbar([1:5], Mean, CI(:,1),CI(:,2), 'LineStyle', 'none','Color', 'k','LineWidth',1);
xtl = {'\begin{tabular}{c} ISO 125, \\ 1/20\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 250, \\ 1/40\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 500, \\ 1/80\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 1000, \\ 1/160\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 3200, \\ 1/500\,s \end{tabular}'};
set(gca,'XTick',[1 2 3 4 5],'Position',[.14 .22 .81 .72])
set(gca,'XTickLabel',xtl,'TickLabelInterpreter','latex','FontSize',18)
xlabel('$\textrm{Exposure Setting}$','Interpreter','latex','FontSize',24);
ylabel('Color Difference $\Delta E_{00}$','Interpreter','latex','FontSize',24);
xlim([0.5 5.5]);ylim([0 4])
box on
set(gcf,'color','w','Units','inches','Position',[2 2 8 6]);
% Colors distribution in CIELab a*b*plane
load('E:\Dropbox\Works\Matlab\Ruixinwei\ToolFunctions\SpectralData\ClassicColorCheckerSpectralReflectance.mat')
sRGB_A_24 = SpecRef2sRGB(ClassicColorCheckerSpectralReflectance',380,780,'A');
sRGB_A_24 = sRGB_A_24/max(sRGB_A_24(:));
Lab_A_24 = rgb2lab(sRGB_A_24);
Radii_test = (D_test{1}+D_test{2}+D_test{3}+D_test{4}+D_test{5})/5;
figure;box on;
hold on;
line([-100 100],[0 0],'LineWidth',2,'LineStyle','--','Color',[160 160 160]/255);
line([0 0],[-100 100],'LineWidth',2,'LineStyle','--','Color',[160 160 160]/255);
for i = 1:24
    hold on
    circles(Lab_A_24(i,2),Lab_A_24(i,3),5*Radii_test(i),'facecolor',sRGB_A_24(i,:),'edgecolor','none');
end
xlabel('$\textrm{CIE - }a^{*}$','Interpreter','latex','FontSize',26);
ylabel('$\textrm{CIE - }b^{*}$','Interpreter','latex','FontSize',26,'Rotation',90);
set(gca,'xtick',[-80:20:120],'ytick',[-120:20:120],'Position',[.17 .16 .78 .78])
set(gca,'TickLabelInterpreter','LaTex','FontSize',20);
set(gcf,'color','w','Units','inches','Position',[2 2 6.5 6]);
axis equal
xlim([-80 80]);ylim([-60 100]);