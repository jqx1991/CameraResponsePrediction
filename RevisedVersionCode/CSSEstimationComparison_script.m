% Ours
load('E:\Dropbox\Works\Matlab\Papers\ResponsePrediction\result_20160314.mat')
clearvars -except CSS CSS0
wl1 = 380:5:780;
wl = 400:5:720;
CSS_Ours = interp1(wl1,CSS,wl,'pchip');

% Pseudo Inverse
load('E:\Dropbox\Works\MyPapers\ResponsePrediction\SPD_Central.mat')
for i = 1:96
    SPD(i,:) = (SPD_Central(2*i-1,:)+SPD_Central(2*i,:))/2;
end
SPD = SPD(:,1:5:end);
idx_train = minCondSubset(SPD',48);
clear i SPD_Central SPD
clc

load('M:\D3x\Central\data\RGB_mean_ranked.mat')
RGB = RGB_mean_ranked(1:96,:);
load('E:\Dropbox\Works\MyPapers\ResponsePrediction\SPD_Central.mat')
SPD = SPD_Central(1:2:end,:);
wl2 = 380:1:780;
SPD = interp1(wl2,SPD',wl,'pchip')';
wlNum = size(SPD,2);
S = zeros(wlNum-2,wlNum);
for i = 1:wlNum-2
    S(i,i) = -1;
    S(i,i+1) = 2;
    S(i,i+2) = -1;
end
lambda = 0.005;
SPD_train = SPD(idx_train,:);
RGB_train = RGB(idx_train,:);
CSS_PI = pinv([SPD_train;lambda*S])*[RGB_train;zeros(wlNum-2,3)];
clearvars -except CSS_Ours CSS_PI wlNum wl

% Radial basis function
load('E:\Dropbox\Works\Matlab\Papers\ResponsePrediction\Comparison\CSS_RBF.mat')

% PCA
load('E:\Dropbox\Works\Matlab\Papers\ResponsePrediction\Comparison\CSS_PCA.mat')

% Normalized
CSS_Ours = CSS_Ours./repmat(max(CSS_Ours),wlNum,1);
CSS_PI = CSS_PI./repmat(max(CSS_PI),wlNum,1);
CSS_RBF = CSS_RBF./repmat(max(CSS_RBF),wlNum,1);
CSS_All = CSS_All./repmat(max(CSS_All),wlNum,1);
CSS_Nikon = CSS_Nikon./repmat(max(CSS_Nikon),wlNum,1);


figure('Color','w','Units','Normalized','Position',[.1 .2 .8 .5]);
subplot('Position',[.08 .27 .26 .6],'Unit','Normalized');
hold on;box on;
plot(wl,CSS_PI(:,1),'LineStyle','--','Color',[248 182 108]/255,'LineWidth',2);
plot(wl,CSS_RBF(:,1),'LineStyle',':','Color',[165 119 141]/255,'LineWidth',2);
plot(wl,CSS_All(:,1),'LineStyle','-.','Color',[213 78 68]/255,'LineWidth',2);
plot(wl,CSS_Nikon(:,1),'LineStyle','-','Color',[142 235 124]/255,'LineWidth',2);
plot(wl,CSS_Ours(:,1),'LineStyle','-','Color',[131 192 255]/255,'LineWidth',2);
xlim([400 720]);ylim([0 1.2]);
xlabel('$\textrm{Wavelength }(\textrm{nm})$','Interpreter','latex','FontSize',20);
ylabel('$\textrm{Normalized Spectral Sensitivity }$','Interpreter','latex','FontSize',22);
text(.5,1.1,'(a) Red Channel','unit','normalized','HorizontalAlignment','Center','Interpreter','latex','FontSize',20);
set(gca,'XTick',[400:50:750],'YTick',[0:0.2:1.2],'YTickLabel',{'0','.2','.4','.6','.8','1','1.2'},'TickLabelInterpreter','LaTex','FontSize',14);

subplot('Position',[.395 .27 .26 .6],'Unit','Normalized');
hold on;box on;
plot(wl,CSS_PI(:,2),'LineStyle','--','Color',[248 182 108]/255,'LineWidth',2);
plot(wl,CSS_RBF(:,2),'LineStyle',':','Color',[165 119 141]/255,'LineWidth',2);
plot(wl,CSS_All(:,2),'LineStyle','-.','Color',[213 78 68]/255,'LineWidth',2);
plot(wl,CSS_Nikon(:,2),'LineStyle','-','Color',[142 235 124]/255,'LineWidth',2);
plot(wl,CSS_Ours(:,2),'LineStyle','-','Color',[131 192 255]/255,'LineWidth',2);
xlim([400 720]);ylim([0 1.2]);
xlabel('$\textrm{Wavelength }(\textrm{nm})$','Interpreter','latex','FontSize',20);
text(.5,1.1,'(b) Green Channel','unit','normalized','HorizontalAlignment','Center','Interpreter','latex','FontSize',20);
set(gca,'XTick',[400:50:750],'YTick',[0:0.2:1.2],'YTickLabel',{'0','.2','.4','.6','.8','1','1.2'},'TickLabelInterpreter','LaTex','FontSize',14);

subplot('Position',[.71 .27 .26 .6],'Unit','Normalized');
hold on;box on;
plot(wl,CSS_PI(:,3),'LineStyle','--','Color',[248 182 108]/255,'LineWidth',2);
plot(wl,CSS_RBF(:,3),'LineStyle',':','Color',[165 119 141]/255,'LineWidth',2);
plot(wl,CSS_All(:,3),'LineStyle','-.','Color',[213 78 68]/255,'LineWidth',2);
plot(wl,CSS_Nikon(:,3),'LineStyle','-','Color',[142 235 124]/255,'LineWidth',2);
plot(wl,CSS_Ours(:,3),'LineStyle','-','Color',[131 192 255]/255,'LineWidth',2);
xlim([400 720]);ylim([0 1.2]);
xlabel('$\textrm{Wavelength }(\textrm{nm})$','Interpreter','latex','FontSize',20);
text(.5,1.1,'(c) Blue Channel','unit','normalized','HorizontalAlignment','Center','Interpreter','latex','FontSize',20);
set(gca,'XTick',[400:50:750],'YTick',[0:0.2:1.2],'YTickLabel',{'0','.2','.4','.6','.8','1','1.2'},'TickLabelInterpreter','LaTex','FontSize',14);

legend({'Pseudo Inverse','Radial Basis Function','PCA-All','PCA-Nikon','Proposed'},'Orientation','Horizontal','Box','off',...
        'Units','Normalized','Position',[0 0 1 .2],'Fontsize',16);
