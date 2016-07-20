% L-curve format
set(gca,'XTick',[10^-0.5 10^0 10^0.5 10^1])
xtl = {'$10^{0}$','$10^{\frac{1}{2}}$','$10^{1}$'};
set(gca,'XTickLabel',xtl,'TickLabelInterpreter','latex','FontSize',20)

set(gca,'YTick',[10^0 10^3 10^6 10^9 10^12])
ytl = {'$10^{0}$','$10^{3}$','$10^{6}$','$10^{9}$','$10^{12}$'};
set(gca,'YTickLabel',ytl,'TickLabelInterpreter','latex','FontSize',20)
xlabel('Residual Error','Interpreter','latex','FontSize',26);
ylabel('Regularization Error','Interpreter','latex','FontSize',26);
xlim([10^(-0.4) 10]);ylim([1 10E11]);

title('Tikhonov corner at $\lambda = 0.011356$','Interpreter','latex','FontSize',24)
grid on
set(gcf,'color','w','Units','inches','Position',[2 2 8 6.1]);
set(gca,'Units','normalized','Position',[.17 .18 .78 .69]);