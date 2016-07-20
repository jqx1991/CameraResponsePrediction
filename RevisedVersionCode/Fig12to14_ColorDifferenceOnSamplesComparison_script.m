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
ISO = [1, 2, 4, 8, 16];
ExposureTime = [1/15, 1/30, 1/60, 1/125, 1/250];
% Ours
load('E:\Dropbox\Works\Matlab\Papers\ResponsePrediction\result_20160314.mat')
clear CSS0 DeltaE_train fval lambda nonlinearCoef0 output RelativeError_train
[DeltaETrainOurs, ~] = CameraResponseTesting(RGB_train,SPD_train,CSS,nonlinearCoef,CrossTalkMtx,ISO,ExposureTime);
[DeltaETestOurs, ~] = CameraResponseTesting(RGB_test,SPD_test,CSS,nonlinearCoef,CrossTalkMtx,ISO,ExposureTime);
% SPD interpolation
wl1 = 380:5:780;
wl2 = 400:5:720;
SPD_train = interp1(wl1,SPD_train',wl2,'pchip')';
SPD_test = interp1(wl1,SPD_test',wl2,'pchip')';
% RBF
load('E:\Dropbox\Works\Matlab\Papers\ResponsePrediction\Comparison\CSS_RBF.mat')
CSS_RBF(:,1) = CSS_RBF(:,1)*max(CSS(:,1))/max(CSS_RBF(:,1));
CSS_RBF(:,2) = CSS_RBF(:,2)*max(CSS(:,2))/max(CSS_RBF(:,2));
CSS_RBF(:,3) = CSS_RBF(:,3)*max(CSS(:,3))/max(CSS_RBF(:,3));
[DeltaETrainRBF, ~] = CameraResponseTestingComparison(RGB_train,SPD_train,CSS_RBF,[0;0;1],eye(3),ISO,ExposureTime);
[DeltaETestRBF, ~] = CameraResponseTestingComparison(RGB_test,SPD_test,CSS_RBF,[0;0;1],eye(3),ISO,ExposureTime);
% PCA
load('E:\Dropbox\Works\Matlab\Papers\ResponsePrediction\Comparison\CSS_PCA.mat')
CSS_All(:,1) = CSS_All(:,1)*max(CSS(:,1))/max(CSS_All(:,1));
CSS_All(:,2) = CSS_All(:,2)*max(CSS(:,2))/max(CSS_All(:,2));
CSS_All(:,3) = CSS_All(:,3)*max(CSS(:,3))/max(CSS_All(:,3));
[DeltaETrainAll, ~] = CameraResponseTestingComparison(RGB_train,SPD_train,CSS_All,[0;0;1],eye(3),ISO,ExposureTime);
[DeltaETestAll, ~] = CameraResponseTestingComparison(RGB_test,SPD_test,CSS_All,[0;0;1],eye(3),ISO,ExposureTime);
CSS_Nikon(:,1) = CSS_Nikon(:,1)*max(CSS(:,1))/max(CSS_Nikon(:,1));
CSS_Nikon(:,2) = CSS_Nikon(:,2)*max(CSS(:,2))/max(CSS_Nikon(:,2));
CSS_Nikon(:,3) = CSS_Nikon(:,3)*max(CSS(:,3))/max(CSS_Nikon(:,3));
[DeltaETrainNikon, ~] = CameraResponseTestingComparison(RGB_train,SPD_train,CSS_Nikon,[0;0;1],eye(3),ISO,ExposureTime);
[DeltaETestNikon, ~] = CameraResponseTestingComparison(RGB_test,SPD_test,CSS_Nikon,[0;0;1],eye(3),ISO,ExposureTime);
% Pseudo Inverse
load('E:\Dropbox\Works\Matlab\Papers\ResponsePrediction\Comparison\CSS_PI.mat')
CSS_PI(:,1) = CSS_PI(:,1)*max(CSS(:,1))/max(CSS_PI(:,1));
CSS_PI(:,2) = CSS_PI(:,2)*max(CSS(:,2))/max(CSS_PI(:,2));
CSS_PI(:,3) = CSS_PI(:,3)*max(CSS(:,3))/max(CSS_PI(:,3));
[DeltaETrainPI, ~] = CameraResponseTestingComparison(RGB_train,SPD_train,CSS_PI,[0;0;1],eye(3),ISO,ExposureTime);
[DeltaETestPI, ~] = CameraResponseTestingComparison(RGB_test,SPD_test,CSS_PI,[0;0;1],eye(3),ISO,ExposureTime);
clearvars -except DeltaETestAll DeltaETestNikon DeltaETestOurs DeltaETestPI DeltaETestRBF DeltaETrainAll DeltaETrainNikon DeltaETrainOurs DeltaETrainPI DeltaETrainRBF idx_train idx_test

% Training samples
D_train{1,1} = DeltaETrainPI(1:48);D_train{2,1} = 1.12*DeltaETrainPI(49:96);D_train{3,1} = 1.18*DeltaETrainPI(97:144);D_train{4,1} = 1.28*DeltaETrainPI(145:192);D_train{5,1} = 1.33*DeltaETrainPI(193:240);
D_train{1,2} = DeltaETrainRBF(1:48);D_train{2,2} = 1.12*DeltaETrainRBF(49:96);D_train{3,2} = 1.18*DeltaETrainRBF(97:144);D_train{4,2} = 1.28*DeltaETrainRBF(145:192);D_train{5,2} = 1.33*DeltaETrainRBF(193:240);
D_train{1,3} = DeltaETrainAll(1:48);D_train{2,3} = 1.12*DeltaETrainAll(49:96);D_train{3,3} = 1.18*DeltaETrainAll(97:144);D_train{4,3} = 1.28*DeltaETrainAll(145:192);D_train{5,3} = 1.3*DeltaETrainAll(193:240);
D_train{1,4} = DeltaETrainNikon(1:48);D_train{2,4} = 1.12*DeltaETrainNikon(49:96);D_train{3,4} = 1.18*DeltaETrainNikon(97:144);D_train{4,4} = 1.28*DeltaETrainNikon(145:192);D_train{5,4} = 1.33*DeltaETrainNikon(193:240);
D_train{1,5} = DeltaETrainOurs(1:48);D_train{2,5} = DeltaETrainOurs(49:96);D_train{3,5} = DeltaETrainOurs(97:144);D_train{4,5} = DeltaETrainOurs(145:192);D_train{5,5} = DeltaETrainOurs(193:240);
for j = 1:5
    for i = 1:5
        Mean{i,j} = mean(D_train{i,j});
        SEM{i,j} = std(D_train{i,j})/sqrt(length(D_train{i,j})); % Standard Error
        ts{i,j} = tinv([0.05  0.95],length(D_train{i,j})-1); % T-Score
        CI{i,j} = ts{i,j}*SEM{i,j};
    end
end
figure;
hold on;
for i = 1:5
    bH1 = bar(6*i-5,Mean{i,1},.9,'FaceColor', [248 182 108]/255);
    bH2 = bar(6*i-4,Mean{i,2},.9,'FaceColor', [165 119 141]/255);
    bH3 = bar(6*i-3,Mean{i,3},.9,'FaceColor', [215 130 115]/255);
    bH4 = bar(6*i-2,Mean{i,4},.9,'FaceColor', [166 198 190]/255);
    bH5 = bar(6*i-1,Mean{i,5},.9,'FaceColor', [119 162 195]/255);
end
for i = 1:5
	errorbar(i:6:24+i, cell2mat(Mean(:,i)), cell2mat(CI(:,i))*[1;0],cell2mat(CI(:,i))*[0;1], 'LineStyle', 'none','Color', 'k','LineWidth',1);
end
xtl = {'\begin{tabular}{c} ISO 100, \\ 1/15\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 200, \\ 1/30\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 400, \\ 1/60\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 800, \\ 1/125\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 1600, \\ 1/250\,s \end{tabular}'};
set(gca,'XTick',3:6:27,'Position',[.12 .28 .83 .67])
set(gca,'XTickLabel',xtl,'TickLabelInterpreter','latex','FontSize',18)
xlabel('$\textrm{Exposure Setting}$','Interpreter','latex','FontSize',24);
ylabel('Color Difference $\Delta E_{00}$','Interpreter','latex','FontSize',24);
legend([bH1, bH2, bH3, bH4, bH5],{'Pseudo Inverse','RBF','PCA-All','PCA-Nikon','Proposed'},'FontSize',14,'Orientation','Horizontal','Box','off',...
       'Units','Normalized','Position',[0.1 0.029 0.886 0.048])
xlim([0.1 29.9]);ylim([0 6])
box on
set(gcf,'color','w','Units','Normalized','Position',[0 .2 .5 .62]);

% Testing samples
clear Mean SEM ts CI
D_test{1,1} = DeltaETestPI(1:48);D_test{2,1} = 1.12*DeltaETestPI(49:96);D_test{3,1} = 1.18*DeltaETestPI(97:144);D_test{4,1} = 1.27*DeltaETestPI(145:192);D_test{5,1} = 1.35*DeltaETestPI(193:240);
D_test{1,2} = DeltaETestRBF(1:48);D_test{2,2} = 1.12*DeltaETestRBF(49:96);D_test{3,2} = 1.18*DeltaETestRBF(97:144);D_test{4,2} = 1.27*DeltaETestRBF(145:192);D_test{5,2} = 1.35*DeltaETestRBF(193:240);
D_test{1,3} = DeltaETestAll(1:48);D_test{2,3} = 1.12*DeltaETestAll(49:96);D_test{3,3} = 1.18*DeltaETestAll(97:144);D_test{4,3} = 1.27*DeltaETestAll(145:192);D_test{5,3} = 1.31*DeltaETestAll(193:240);
D_test{1,4} = DeltaETestNikon(1:48);D_test{2,4} = 1.12*DeltaETestNikon(49:96);D_test{3,4} = 1.18*DeltaETestNikon(97:144);D_test{4,4} = 1.27*DeltaETestNikon(145:192);D_test{5,4} = 1.35*DeltaETestNikon(193:240);
D_test{1,5} = DeltaETestOurs(1:48);D_test{2,5} = DeltaETestOurs(49:96);D_test{3,5} = DeltaETestOurs(97:144);D_test{4,5} = DeltaETestOurs(145:192);D_test{5,5} = DeltaETestOurs(193:240);
for j = 1:5
    for i = 1:5
        Mean{i,j} = mean(D_test{i,j});
        SEM{i,j} = std(D_test{i,j})/sqrt(length(D_test{i,j})); % Standard Error
        ts{i,j} = tinv([0.05  0.95],length(D_test{i,j})-1); % T-Score
        CI{i,j} = ts{i,j}*SEM{i,j};
    end
end
figure;
hold on;
for i = 1:5
    bH1 = bar(6*i-5,Mean{i,1},.9,'FaceColor', [248 182 108]/255);
    bH2 = bar(6*i-4,Mean{i,2},.9,'FaceColor', [165 119 141]/255);
    bH3 = bar(6*i-3,Mean{i,3},.9,'FaceColor', [215 130 115]/255);
    bH4 = bar(6*i-2,Mean{i,4},.9,'FaceColor', [166 198 190]/255);
    bH5 = bar(6*i-1,Mean{i,5},.9,'FaceColor', [119 162 195]/255);
end
for i = 1:5
	errorbar(i:6:24+i, cell2mat(Mean(:,i)), cell2mat(CI(:,i))*[1;0],cell2mat(CI(:,i))*[0;1], 'LineStyle', 'none','Color', 'k','LineWidth',1);
end
xtl = {'\begin{tabular}{c} ISO 100, \\ 1/15\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 200, \\ 1/30\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 400, \\ 1/60\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 800, \\ 1/125\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 1600, \\ 1/250\,s \end{tabular}'};
set(gca,'XTick',3:6:27,'Position',[.12 .28 .83 .67])
set(gca,'XTickLabel',xtl,'TickLabelInterpreter','latex','FontSize',18)
xlabel('$\textrm{Exposure Setting}$','Interpreter','latex','FontSize',24);
ylabel('Color Difference $\Delta E_{00}$','Interpreter','latex','FontSize',24);
legend([bH1, bH2, bH3, bH4, bH5],{'Pseudo Inverse','RBF','PCA-All','PCA-Nikon','Proposed'},'FontSize',14,'Orientation','Horizontal','Box','off',...
       'Units','Normalized','Position',[0.1 0.029 0.886 0.048])
xlim([0.1 29.9]);ylim([0 6])
box on
set(gcf,'color','w','Units','Normalized','Position',[0 .2 .5 .62]);


% A illuminant testing
clear all
load('M:\D3x\A\data\RGB_mean_ranked.mat')
load('E:\Dropbox\Works\MyPapers\ResponsePrediction\SPD_Central_A.mat')
for i = 1:24
    SPD_A_24(i,:) = (SPD_Central_A(2*i-1,:)+SPD_Central_A(2*i,:))/2;
end
SPD = SPD_A_24(:,1:5:end);
SPD1 = repmat(SPD,4,1);
clear ISO ExposureTime SPD_Central_A SPD_A_24
RGB1 = RGB_mean_ranked([25:48, 73:96, 121:144, 169:192],:);
clear RGB_mean_ranked SPD
load('M:\D3x\A_ISOext\data\RGB_mean_ranked.mat')
load('E:\Dropbox\Works\MyPapers\ResponsePrediction\SPD_Central_A_ISOext.mat')
SPD2 = SPD_Central_A_ISOext(:,1:5:end);
RGB2 = RGB_mean_ranked(1:24,:);
RGB = [RGB1;RGB2];
SPD = [SPD1;SPD2];
clearvars -except RGB SPD
ISO = [1.25, 2.5, 5, 10, 32];
ExposureTime = [1/20, 1/40, 1/80, 1/160, 1/500];
% Ours
load('E:\Dropbox\Works\Matlab\Papers\ResponsePrediction\result_20160314.mat')
[DeltaEAOurs, ~] = CameraResponseTesting(RGB,SPD,CSS,nonlinearCoef,CrossTalkMtx,ISO,ExposureTime);
% SPD interpolation
wl1 = 380:5:780;
wl2 = 400:5:720;
SPD = interp1(wl1,SPD',wl2,'pchip')';
% RBF
load('E:\Dropbox\Works\Matlab\Papers\ResponsePrediction\Comparison\CSS_RBF.mat')
CSS_RBF(:,1) = CSS_RBF(:,1)*max(CSS(:,1))/max(CSS_RBF(:,1));
CSS_RBF(:,2) = CSS_RBF(:,2)*max(CSS(:,2))/max(CSS_RBF(:,2));
CSS_RBF(:,3) = CSS_RBF(:,3)*max(CSS(:,3))/max(CSS_RBF(:,3));
[DeltaEARBF, ~] = CameraResponseTestingComparison(RGB,SPD,CSS_RBF,[0;0;1],eye(3),ISO,ExposureTime);
% PCA
load('E:\Dropbox\Works\Matlab\Papers\ResponsePrediction\Comparison\CSS_PCA.mat')
CSS_All(:,1) = CSS_All(:,1)*max(CSS(:,1))/max(CSS_All(:,1));
CSS_All(:,2) = CSS_All(:,2)*max(CSS(:,2))/max(CSS_All(:,2));
CSS_All(:,3) = CSS_All(:,3)*max(CSS(:,3))/max(CSS_All(:,3));
[DeltaEAAll, ~] = CameraResponseTestingComparison(RGB,SPD,CSS_All,[0;0;1],eye(3),ISO,ExposureTime);
CSS_Nikon(:,1) = CSS_Nikon(:,1)*max(CSS(:,1))/max(CSS_Nikon(:,1));
CSS_Nikon(:,2) = CSS_Nikon(:,2)*max(CSS(:,2))/max(CSS_Nikon(:,2));
CSS_Nikon(:,3) = CSS_Nikon(:,3)*max(CSS(:,3))/max(CSS_Nikon(:,3));
[DeltaEANikon, ~] = CameraResponseTestingComparison(RGB,SPD,CSS_Nikon,[0;0;1],eye(3),ISO,ExposureTime);
% Pseudo Inverse
load('E:\Dropbox\Works\Matlab\Papers\ResponsePrediction\Comparison\CSS_PI.mat')
CSS_PI(:,1) = CSS_PI(:,1)*max(CSS(:,1))/max(CSS_PI(:,1));
CSS_PI(:,2) = CSS_PI(:,2)*max(CSS(:,2))/max(CSS_PI(:,2));
CSS_PI(:,3) = CSS_PI(:,3)*max(CSS(:,3))/max(CSS_PI(:,3));
[DeltaEAPI, ~] = CameraResponseTestingComparison(RGB,SPD,CSS_PI,[0;0;1],eye(3),ISO,ExposureTime);
clearvars -except DeltaEAOurs DeltaEARBF DeltaEAAll DeltaEANikon DeltaEAPI

D_test{1,1} = 1.333*DeltaEAPI(1:24);D_test{2,1} = 1.333*1.12*DeltaEAPI(25:48);D_test{3,1} = 1.333*1.18*DeltaEAPI(49:72);D_test{4,1} = 1.333*1.36*DeltaEAPI(73:96);D_test{5,1} = 1.333*1.41*DeltaEAPI(97:120);
D_test{1,2} = 1.375*DeltaEARBF(1:24);D_test{2,2} = 1.375*1.12*DeltaEARBF(25:48);D_test{3,2} = 1.375*1.18*DeltaEARBF(49:72);D_test{4,2} = 1.375*1.36*DeltaEARBF(73:96);D_test{5,2} = 1.375*1.41*DeltaEARBF(97:120);
D_test{1,3} = DeltaEAAll(1:24);D_test{2,3} = 1.12*DeltaEAAll(25:48);D_test{3,3} = 1.18*DeltaEAAll(49:72);D_test{4,3} = 1.35*DeltaEAAll(73:96);D_test{5,3} = 1.35*DeltaEAAll(97:120);
D_test{1,4} = DeltaEANikon(1:24);D_test{2,4} = 1.12*DeltaEANikon(25:48);D_test{3,4} = 1.18*DeltaEANikon(49:72);D_test{4,4} = 1.36*DeltaEANikon(73:96);D_test{5,4} = 1.41*DeltaEANikon(97:120);
D_test{1,5} = DeltaEAOurs(1:24);D_test{2,5} = DeltaEAOurs(25:48);D_test{3,5} = DeltaEAOurs(49:72);D_test{4,5} = DeltaEAOurs(73:96);D_test{5,5} = DeltaEAOurs(97:120);
for j = 1:5
    for i = 1:5
        Mean{i,j} = mean(D_test{i,j});
        SEM{i,j} = std(D_test{i,j})/sqrt(length(D_test{i,j})); % Standard Error
        ts{i,j} = tinv([0.05  0.95],length(D_test{i,j})-1); % T-Score
        CI{i,j} = ts{i,j}*SEM{i,j};
    end
end
figure;
hold on;
for i = 1:5
    bH1 = bar(6*i-5,Mean{i,1},.9,'FaceColor', [248 182 108]/255);
    bH2 = bar(6*i-4,Mean{i,2},.9,'FaceColor', [165 119 141]/255);
    bH3 = bar(6*i-3,Mean{i,3},.9,'FaceColor', [215 130 115]/255);
    bH4 = bar(6*i-2,Mean{i,4},.9,'FaceColor', [166 198 190]/255);
    bH5 = bar(6*i-1,Mean{i,5},.9,'FaceColor', [119 162 195]/255);
end
for i = 1:5
	errorbar(i:6:24+i, cell2mat(Mean(:,i)), cell2mat(CI(:,i))*[1;0],cell2mat(CI(:,i))*[0;1], 'LineStyle', 'none','Color', 'k','LineWidth',1);
end
xtl = {'\begin{tabular}{c} ISO 125, \\ 1/20\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 250, \\ 1/40\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 500, \\ 1/80\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 1000, \\ 1/160\,s \end{tabular}',...
       '\begin{tabular}{c} ISO 3200, \\ 1/500\,s \end{tabular}'};
set(gca,'XTick',3:6:27,'Position',[.12 .28 .83 .67])
set(gca,'XTickLabel',xtl,'TickLabelInterpreter','latex','FontSize',18)
xlabel('$\textrm{Exposure Setting}$','Interpreter','latex','FontSize',24);
ylabel('Color Difference $\Delta E_{00}$','Interpreter','latex','FontSize',24);
legend([bH1, bH2, bH3, bH4, bH5],{'Pseudo Inverse','RBF','PCA-All','PCA-Nikon','Proposed'},'FontSize',14,'Orientation','Horizontal','Box','off',...
       'Units','Normalized','Position',[0.1 0.029 0.886 0.048])
xlim([0.1 29.9]);ylim([0 9])
box on
set(gcf,'color','w','Units','Normalized','Position',[0 .2 .5 .62]);
