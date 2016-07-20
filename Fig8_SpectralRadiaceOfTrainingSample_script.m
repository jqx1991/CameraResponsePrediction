% plot spectral radiance of 48 training samples
load('E:\Dropbox\Works\papers\ResponsePrediction\SPD_Central.mat')
for i = 1:96
    SPD(i,:) = (SPD_Central(2*i-1,:)+SPD_Central(2*i,:))/2;
end
SPD = 10^9*SPD(:,1:5:end);
idx_train = minCondSubset(SPD',48);
SPD_train = SPD(idx_train,:);

load('E:\Dropbox\Works\Matlab\Ruixinwei\ToolFunctions\SpectralData\DSGColorCheckerSpectralReflectance_order.mat')
sRGB = SpecRef2sRGB(DSGColorCheckerSpectralReflectance,400,780);
sRGB(sRGB>1) = 1;
PeripheralIdx = [1:14,15:14:113,28:14:126,127:140];
sRGB(PeripheralIdx,:) = [];
wl = [380:5:780];
hold on;
for i = 1:48
    plot(wl,SPD_train(i,:),'color',sRGB(idx_train(i),:),'LineWidth',2);
end
xlim([380 780]);
ylim([0 6E6])
box on
xt = [400:50:800];
yt = [0:1E6:6E6];
set(gca,'Xtick',400:50:750,'TickLabelInterpreter','LaTex','FontSize',20);
xlabel('$\textrm{Wavelength }(\textrm{nm})$','Interpreter','latex','FontSize',26);
ylabel('$\textrm{Spectral Radiance }(\textrm{W}\cdot\textrm{sr}^{-1}\cdot\textrm{m}^{-3})$','Interpreter','latex','FontSize',22);
set(gcf,'color','w','Units','inches','Position',[2 2 8 6]);
set(gca,'Units','normalized','Position',[.15 .19 .80 .72]);