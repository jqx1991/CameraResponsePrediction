load('M:\D3x\ResponseCurve\raw\RGB.mat')
for i = 1:22
R(:,i) = RGB{i}(19:23,1);
G(:,i) = RGB{i}(19:23,2);
B(:,i) = RGB{i}(19:23,3);
end
load('E:\Dropbox\Works\Matlab\Ruixinwei\ToolFunctions\SpectralData\ClassicColorCheckerSpectralReflectance.mat');
coef20 = ClassicColorCheckerSpectralReflectance(:,19)\ClassicColorCheckerSpectralReflectance(:,20);
t19 = [1/160, 1/125, 1/100, 1/80, 1/60, 1/50, 1/40, 1/30, 1/25, 1/20, 1/15, 1/13, 1/10, 1/8, 1/6, 1/5, 1/4, 1/3, 1/2.5, 1/2, 1/1.6, 1/1.3];
t19t = t19;
t20 = t19*coef20;
G19 = G(1,:);
G20 = G(2,:);
idxG = G19 > 0.936;
G19(idxG) = [];
t19(idxG) = [];
idxG = G19 < 0.1;
G19(idxG) = [];
t19(idxG) = [];
idxG = G20 > 0.936;
G20(idxG) = [];
t20(idxG) = [];
t19t(idxG) = [];
idxG = G20 < 0.1;
G20(idxG) = [];
t20(idxG) = [];
t19t(idxG) = [];
figure('Color','w');box on;hold on;
sH1 = scatter(t19,G19,100,'Marker','o','MarkerFaceColor',[10 111 180]/255,'MarkerEdgeColor','none');
sH2 = scatter(t19t,G20,80,'Marker','o','MarkerFaceColor',[230 178 169]/255,'MarkerEdgeColor','none');
sH3 = scatter(t20,G20,100,'Marker','o','MarkerFaceColor',[217 125 110]/255,'MarkerEdgeColor','none');
for i = 1:length(G20)
    line([t19t(i)-0.003,t20(i)+0.006], [G20(i),G20(i)],'LineStyle','--','Color',[.6 .6 .6]);
    arrow([t20(i)+0.006,G20(i)], [t20(i)+0.0024,G20(i)],'Color',[.6 .6 .6],'length',10);
end
xt = [0 1/40 1/20 1/13 1/10 1/8 1/6];
set(gca,'xtick',xt);
set(gca,'xticklabel',{'$0$' '$\frac{1}{40}$' '$\frac{1}{20}$' '$\frac{1}{13}$' '$\frac{1}{10}$' '$\frac{1}{8}$' '$\frac{1}{6}$'},...
                      'TickLabelInterpreter','latex','FontSize',20);
xlabel('$\textrm{Exposure Time/s}$','Interpreter','latex','FontSize',24);
ylabel('$\textrm{Normalized Response}$','Interpreter','latex','FontSize',24);
legend([sH1,sH2,sH3],{'Responses of Patch \texttt{\#}19','Responses of Patch \texttt{\#}20','Responses of Patch \texttt{\#}20 after shift'},'Interpreter','LaTeX','FontSize',14,'Box','off')
xlim([0 0.195]);ylim([0 1])
set(gcf,'color','w','Units','inches','Position',[2 2 8.4 6.5]);
set(gca,'Units','normalized','Position',[.17 .18 .78 .76]);