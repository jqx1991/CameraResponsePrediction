load('E:\Dropbox\Works\MyPapers\ResponsePrediction\SPD_Central.mat')
for i = 1:96
    SPD(i,:) = (SPD_Central(2*i-1,:)+SPD_Central(2*i,:))/2;
end
SPD = SPD(:,1:5:end);
idx_train = minCondSubset(SPD',48);
clearvars -except idx_train
clc

wl2 = 400:10:720;
wl3 = 400:5:720;
CSSDatabase = dlmread('e:\Dropbox\Works\Matlab\Papers\ResponsePrediction\Jiang_CameraSpectralDatabase.txt');
CSSDatabase = interp1(wl2,CSSDatabase',wl3,'pchip')';
num = size(CSSDatabase,1)/3;
R = CSSDatabase(1:3:end,:);
G = CSSDatabase(2:3:end,:);
B = CSSDatabase(3:3:end,:);
R = R./repmat(max(R,[],2),1,65);
G = G./repmat(max(G,[],2),1,65);
B = B./repmat(max(B,[],2),1,65);
clear CSSDatabase num

wl = 400:5:720;
[RBF_R, Coefs_R,Mu_R,sigma_R] = RBFFitting(wl',R',7,600);
[RBF_G, Coefs_G,Mu_G,sigma_G] = RBFFitting(wl',G',7,540);
[RBF_B, Coefs_B,Mu_B,sigma_B] = RBFFitting(wl',B',7,480);

RR = (RBF_R*Coefs_R)';
GG = (RBF_G*Coefs_G)';
BB = (RBF_B*Coefs_B)';

% figure;
% for i = 1:28
%     hold on;
%     plot(wl,R(i,:));
% end
% ylim([0 1]);
% title('Red channels of database');
% figure;
% for i = 1:28
%     hold on;
%     plot(wl,RR(i,:));
% end
% ylim([0 1]);
% title('Red channels of reconstruted spectral sensitivity');
% 
% figure;
% for i = 1:28
%     hold on;
%     plot(wl,G(i,:));
% end
% ylim([0 1]);
% title('Green channels of database');
% figure;
% for i = 1:28
%     hold on;
%     plot(wl,GG(i,:));
% end
% ylim([0 1]);
% title('Green channels of reconstruted spectral sensitivity');
% 
% figure;
% for i = 1:28
%     hold on;
%     plot(wl,B(i,:));
% end
% ylim([0 1]);
% title('Blue channels of database');
% figure;
% for i = 1:28
%     hold on;
%     plot(wl,BB(i,:));
% end
% ylim([0 1]);
% title('Blue channels of reconstruted spectral sensitivity');

% Test D3x camera spectral sensitivity using radial basis function trained
% from Jiang Jun's database
load('M:\D3x\Central\data\RGB_mean_ranked.mat')
RGB = RGB_mean_ranked(1:96,:);
load('E:\Dropbox\Works\MyPapers\ResponsePrediction\SPD_Central.mat')
SPD = SPD_Central(1:2:end,:);
wl1 = 380:1:780;
SPD = interp1(wl1,SPD',wl,'pchip')';
clear wl1 wl SPD_Central RGB_mean_ranked
SPD_train = SPD(idx_train,:);
RGB_train = RGB(idx_train,:);

Coefs_R = lsqnonneg(SPD_train*RBF_R, RGB_train(:,1));
Coefs_G = lsqnonneg(SPD_train*RBF_G, RGB_train(:,2));
Coefs_B = lsqnonneg(SPD_train*RBF_B, RGB_train(:,3));
CSS_R = RBF_R*Coefs_R;
CSS_G = RBF_G*Coefs_G;
CSS_B = RBF_B*Coefs_B;
CSS_RBF = [CSS_R, CSS_G, CSS_B];

figure;hold on;
plot([400:5:720]',CSS_RBF(:,1),'r');
plot([400:5:720]',CSS_RBF(:,2),'g');
plot([400:5:720]',CSS_RBF(:,3),'b');

save e:\Dropbox\Works\Matlab\Papers\ResponsePrediction\Comparison\CSS_RBF.mat CSS_RBF