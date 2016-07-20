filename = 'm:\D3x\ResponseCurve\raw\*.mat';
[pathstr,~,~] = fileparts(filename);
flist = dir(filename);
% Extraction Begin
load([pathstr,'\',flist(end).name]);
[RGBColorChecker,X,Y,beg_col,beg_row] = ColorCheckerDataPick(ImgRGB,[4 6],2);
clear ImgRGB
for iImg = 1:length(flist)
    load([pathstr,'\',flist(iImg).name]);
    [RGB{iImg},~,~,~,~] = ColorCheckerDataPick(ImgRGB,[4 6],2,X,Y);
    clear ImgRGB
    close all
end
% Extract responses of No.19-23 patches
for i = 1:22
    R(:,i) = RGB{i}(19:23,1);
    G(:,i) = RGB{i}(19:23,2);
    B(:,i) = RGB{i}(19:23,3);
end
load('E:\Dropbox\Works\Matlab\Ruixinwei\ToolFunctions\SpectralData\ClassicColorCheckerSpectralReflectance.mat');
coef20 = ClassicColorCheckerSpectralReflectance(:,19)\ClassicColorCheckerSpectralReflectance(:,20);
coef21 = ClassicColorCheckerSpectralReflectance(:,19)\ClassicColorCheckerSpectralReflectance(:,21);
coef22 = ClassicColorCheckerSpectralReflectance(:,19)\ClassicColorCheckerSpectralReflectance(:,22);
coef23 = ClassicColorCheckerSpectralReflectance(:,19)\ClassicColorCheckerSpectralReflectance(:,23);
t = [1/160, 1/125, 1/100, 1/80, 1/60, 1/50, 1/40, 1/30, 1/25, 1/20, 1/15, 1/13, 1/10, 1/8, 1/6, 1/5, 1/4, 1/3, 1/2.5, 1/2, 1/1.6, 1/1.3];
t20 = t*coef20;
t21 = t*coef21;
t22 = t*coef22;
t23 = t*coef23;
Exposure = [t,t20,t21,t22,t23];
R = R';G = G';B = B';
Red = R(:);Green = G(:);Blue = B(:);
idxR = Red > 0.99;
idxG = Green > 0.936;
idxB = Blue > 0.985;
Red(idxR) = [];
Green(idxG) = [];
Blue(idxB) = [];
ExposureR = Exposure; ExposureR(idxR) = [];
ExposureG = Exposure; ExposureG(idxG) = [];
ExposureB = Exposure; ExposureB(idxB) = [];
% figure;scatter(ExposureR,Red);
figure('Color','w');box on
scatter(ExposureG,Green,60,'Marker','o','MarkerFaceColor',[10 111 180]/255,'MarkerEdgeColor','none');
xt = [0 1/40 1/20 1/13 1/10 1/8];
set(gca,'xtick',xt);
set(gca,'xticklabel',{'$0$' '$\frac{1}{40}$' '$\frac{1}{20}$' '$\frac{1}{13}$' '$\frac{1}{10}$' '$\frac{1}{8}$'},...
                      'TickLabelInterpreter','latex','FontSize',20);
xlabel('$\textrm{Exposure Time/s}$','Interpreter','latex','FontSize',26);
ylabel('$\textrm{Normalized Response}$','Interpreter','latex','FontSize',26);
xlim([0 0.13]);ylim([0 1])
set(gcf,'color','w','Units','inches','Position',[2 2 8 6]);
set(gca,'Units','normalized','Position',[.175 .2 .775 .74]);
% figure;scatter(ExposureB,Blue);

