load('E:\Dropbox\Works\MyPapers\ResponsePrediction\SPD_Central.mat')
for i = 1:96
    SPD(i,:) = (SPD_Central(2*i-1,:)+SPD_Central(2*i,:))/2;
end
SPD = SPD(:,1:5:end);
idx_train = minCondSubset(SPD',48);
clearvars -except idx_train
clc

load('M:\D3x\Central\data\RGB_mean_ranked.mat')
RGB = RGB_mean_ranked(1:96,:);
load('E:\Dropbox\Works\MyPapers\ResponsePrediction\SPD_Central.mat')
SPD = SPD_Central(1:2:end,:);
wl1 = 380:1:780;
wl2 = 400:10:720;
wl3 = 400:5:720;
SPD = interp1(wl1,SPD',wl3,'pchip')';

CSSDatabase = dlmread('e:\Dropbox\Works\Matlab\Papers\ResponsePrediction\Jiang_CameraSpectralDatabase.txt');
CSSDatabase = interp1(wl2,CSSDatabase',wl3,'pchip')';
All = CSSDatabase;
num = size(All,1)/3;
R = All(1:3:end,:);
G = All(2:3:end,:);
B = All(3:3:end,:);
R = R./repmat(max(R,[],2),1,65);
G = G./repmat(max(G,[],2),1,65);
B = B./repmat(max(B,[],2),1,65);
[R_pc, R_coefs,R_latent,~,R_var] = pca(R,'Centered','off');
[G_pc, G_coefs,G_latent,~,G_var] = pca(G,'Centered','off');
[B_pc, B_coefs,B_latent,~,B_var] = pca(B,'Centered','off');

SPD_train = SPD(idx_train,:);
RGB_train = RGB(idx_train,:);
CSS_R = R_pc(:,1:2)*pinv(SPD_train*R_pc(:,1:2))*RGB_train(:,1); % use first two pricipal component
CSS_G = G_pc(:,1:2)*pinv(SPD_train*G_pc(:,1:2))*RGB_train(:,2);
CSS_B = B_pc(:,1:2)*pinv(SPD_train*B_pc(:,1:2))*RGB_train(:,3);
CSS_All = [CSS_R, CSS_G, CSS_B];

clear B B_coefs B_latent B_pc B_var CSS_B CSS_G CSS_R G G_coefs G_latent G_pc G_var num R R_coefs R_latent R_pc R_var RGB_mean_ranked SPD_Central wl1 wl2 All
figure;hold on;
plot([400:5:720]',CSS_All(:,1),'r');
plot([400:5:720]',CSS_All(:,2),'g');
plot([400:5:720]',CSS_All(:,3),'b');


Nikon = CSSDatabase(31:60,:);
num = size(Nikon,1)/3;
R = Nikon(1:3:end,:);
G = Nikon(2:3:end,:);
B = Nikon(3:3:end,:);
R = R./repmat(max(R,[],2),1,65);
G = G./repmat(max(G,[],2),1,65);
B = B./repmat(max(B,[],2),1,65);

[R_pc, R_coefs,R_latent,~,R_var] = pca(R,'Centered','off');
[G_pc, G_coefs,G_latent,~,G_var] = pca(G,'Centered','off');
[B_pc, B_coefs,B_latent,~,B_var] = pca(B,'Centered','off');
CSS_R = R_pc(:,1:2)*pinv(SPD_train*R_pc(:,1:2))*RGB_train(:,1); % use first two pricipal component
CSS_G = G_pc(:,1:2)*pinv(SPD_train*G_pc(:,1:2))*RGB_train(:,2);
CSS_B = B_pc(:,1:2)*pinv(SPD_train*B_pc(:,1:2))*RGB_train(:,3);
CSS_Nikon = [CSS_R, CSS_G, CSS_B];
clear B B_coefs B_latent B_pc B_var CSS_B CSS_G CSS_R G G_coefs G_latent G_pc G_var num R R_coefs R_latent R_pc R_var RGB_mean_ranked SPD_Central wl1 wl2 Nikon
figure;hold on;
plot([400:5:720]',CSS_Nikon(:,1),'r');
plot([400:5:720]',CSS_Nikon(:,2),'g');
plot([400:5:720]',CSS_Nikon(:,3),'b');

save e:\Dropbox\Works\Matlab\Papers\ResponsePrediction\Comparison\CSS_PCA.mat CSS_All CSS_Nikon

