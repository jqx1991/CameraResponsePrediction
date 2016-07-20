XYZ_measured_temp = xlsread('E:\Dropbox\Works\papers\ResponsePrediction\DSG_D3x_Central.csv',1,'O15:Q206');
for i = 1:96
    XYZ_measured(i,:) = (XYZ_measured_temp(2*i-1,:) + XYZ_measured_temp(2*i,:))/2;
end
clear XYZ_measured_temp

load('M:\D3x\Central\data\RGB_mean_ranked.mat');
RGB_measured = RGB_mean_ranked(1:96,:);
clear RGB_mean_ranked
R = RGB_measured(:,1);G = RGB_measured(:,2);B = RGB_measured(:,3);
RootPolyRGB = [R, G, B, sqrt(R.*G), sqrt(G.*B), sqrt(R.*B),...
              (R.*G.^2).^(1/3), (G.*B.^2).^(1/3), (R.*B.^2).^(1/3), (G.*R.^2).^(1/3), (B.*G.^2).^(1/3), (B.*R.^2).^(1/3), (R.*G.*B).^(1/3),...
              (R.*G.^3).^(1/4), (G.*B.^3).^(1/4), (R.*B.^3).^(1/4), (G.*R.^3).^(1/4), (B.*G.^3).^(1/4), (B.*R.^3).^(1/4),...
              (R.^2.*G.*B).^(1/4), (G.^2.*R.*B).^(1/4), (B.^2.*R.*G).^(1/4)];
RGB2XYZ0 = pinv(RootPolyRGB)*XYZ_measured;

RGB2XYZ_temp = '';
for i = 1:66
    RGB2XYZ = ['x(',num2str(i),') '];
    RGB2XYZ_temp = [RGB2XYZ_temp,RGB2XYZ];
end
clear RGB2XYZ
eval(['RGB2XYZ = @(x) reshape([',RGB2XYZ_temp,'],22,3);']);
XYZ_predicted = @(x) RootPolyRGB*RGB2XYZ(x);
clear RGB2XYZ
costfun = @(x) mean(sRGB2CIEDeltaE(XYZ_measured/100,XYZ_predicted(x)/100,'cie00','XYZ'));
options = optimoptions(@fmincon ,'MaxFunEvals',100000,'MaxIter',3000);
Mtx = fmincon(costfun,RGB2XYZ0(:),[],[],[],[],[],[],[],options);
RGB2XYZ = reshape(Mtx,22,3);

save E:\Dropbox\Works\Matlab\Papers\ResponsePrediction\cameraRGB2XYZ.mat RGB2XYZ