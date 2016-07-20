% plot spectral sensitivity curves
figure;
wl = [380:5:780]';
hold on;
R0 = plot(wl,CSS0(:,1),'.','markersize',15,'color',[120 140 220]/255,'LineStyle','-','lineWidth',2);
G0 = plot(wl,CSS0(:,2),'.','markersize',15,'color',[120 140 220]/255,'LineStyle','-','lineWidth',2);
B0 = plot(wl,CSS0(:,3),'.','markersize',15,'color',[120 140 220]/255,'LineStyle','-','lineWidth',2);

R = plot(wl,CSS(:,1),'s','markersize',6,'color',[230 100 90]/255,'LineStyle','--','lineWidth',1.5);
G = plot(wl,CSS(:,2),'s','markersize',6,'color',[230 100 90]/255,'LineStyle','--','lineWidth',1.5);
B = plot(wl,CSS(:,3),'s','markersize',6,'color',[230 100 90]/255,'LineStyle','--','lineWidth',1.5);


xlim([380 780]);
box on;
set(gca,'TickLabelInterpreter','LaTex','FontSize',18);
xlabel('$\textrm{Wavelength }(\textrm{nm})$','Interpreter','latex','FontSize',22);
ylabel('$\textrm{Camera Spectral Sensitivity }(\textrm{m}^{2} \cdot \textrm{W}^{-1} \cdot \textrm{s}^{-1})$','Interpreter','latex','FontSize',20);
set(gcf,'color','w','Units','inches','Position',[2 2 8 6]);

legend([R0,R],{'Initial Estimated $\mathbf{S}_0$',...
        'Optimized $\mathbf{S}$',...
        },'Interpreter','latex','FontSize',20,'box','off')

% The nonlinearity
PHi = 0:0.001:1;
nl0 = real(PHi+nonlinearCoef0(1)).^(nonlinearCoef0(3)) + nonlinearCoef0(2);
nl = real(PHi+nonlinearCoef(1)).^(nonlinearCoef(3)) + nonlinearCoef(2);
figure;box on;hold on
l1 = line([0 1],[0 1],'LineWidth',2,'color',[210 210 210]/255)
l2 = plot(PHi,nl0,'LineWidth',2.5,'color',[100 150 195]/255);
l3 = plot(PHi,nl,'LineStyle','--','LineWidth',2.5,'color',[229 110 120]/255);
axis equal;xlim([0 1]);ylim([0 1]);
legend([l2,l3,l1],{...
        '\ Initial Fitting',...
        '\ Optimized Nonlinearity',...
        '\ $f(\Phi ) = \Phi$',...
        },'Interpreter','latex','FontSize',18,'Box','off')
xlabel('$\Phi$','Interpreter','latex','FontSize',30);
ylabel('$f(\Phi)$','Interpreter','latex','FontSize',26,'Rotation',90);

set(gca,'TickLabelInterpreter','LaTex','FontSize',22);
set(gca,'XTick',[0:0.2:1],'YTick',[0:0.2:1])
set(gcf,'color','w','Units','inches','Position',[2 2 6.5 6]);

% Iteration plot
xlim([-1 41]);ylim([0 4]);
xlabel('Iteration','Interpreter','latex','FontSize',30);
ylabel('Cost Function Value','Interpreter','latex','FontSize',30);
set(gca,'XTick',[0:10:40],'YTick',[0:1:5],'TickLabelInterpreter','LaTex','FontSize',22);
set(gcf,'color','w','Units','inches','Position',[2 2 7.5 5.8]);

%
clear all;
SPD_mono = xlsread('E:\nikon.xlsx','A2:D51');
wl = SPD_mono(:,1);
SPD_mono = SPD_mono(:,2:4);
% wl_5nm = [389,390:5:780];
% SPD_mono = interp1(wl,SPD_mono,wl_5nm,'pchip');
SPD_mono = SPD_mono/max(SPD_mono(:));
figure;l1 = plot(wl,SPD_mono(:,1),'o-','LineWidth',1.1,'Color',[243 70 73]/255);
hold on;plot(wl,SPD_mono(:,2),'o-','LineWidth',1.1,'Color',[243 70 73]/255);
hold on;plot(wl,SPD_mono(:,3),'o-','LineWidth',1.1,'Color',[243 70 73]/255);
load('E:\Dropbox\Works\Matlab\Papers\ResponsePrediction\result_20160314.mat')
wl_5nm = [380:5:780];
CSS = CSS/max(CSS(:));
hold on;l2 = plot(wl_5nm,CSS(:,1),'s-','LineWidth',1.1,'Color',[78 170 226]/255);
hold on;plot(wl_5nm,CSS(:,2),'s-','LineWidth',1.1,'Color',[78 170 226]/255);
hold on;plot(wl_5nm,CSS(:,3),'s-','LineWidth',1.1,'Color',[78 170 226]/255);
xlim([380 780]);ylim([0 1.2]);
set(gca,'TickLabelInterpreter','LaTex','FontSize',12);
set(gca,'XTick',[380:50:780],'YTick',[0:0.2:1.2])
xlabel('$\textrm{wavelength }(\textrm{nm})$','Interpreter','latex','FontSize',14);
ylabel('$\textrm{Normalized camera spectral sensitivity }$','Interpreter','latex','FontSize',14);
set(gcf,'color','w','Units','inches','Position',[2 2 6.5 4.5]);
legend([l2,l1],{...
        'Estimated Spectral Sensitivity',...
        'Ground Truth',...
        },'Interpreter','latex','FontSize',11,'Box','on')
