load('M:\D3x\Central\data\RGB_mean_ranked.mat')
load('E:\Dropbox\Works\papers\ResponsePrediction\SPD_Central.mat')
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

[CSS, CSS0, CrossTalkMtx, nonlinearCoef, nonlinearCoef0, DeltaE_train, RelativeError_train,fval,exitflag,output,lambda] = CameraResponsePredictionMain(RGB_train, SPD_train, [], 0.1, 30000, 0);
ISO = [1, 2, 4, 8, 16];
ExposureTime = [1/15, 1/30, 1/60, 1/125, 1/250];
[DeltaE_test, RelativeError_test] = CameraResponseTesting(RGB_test,SPD_test,CSS,nonlinearCoef,CrossTalkMtx,ISO,ExposureTime);

% fig
idx_train = idx_train+14;
idx_train(idx_train>=15) = idx_train(idx_train>=15) + 1;
idx_train(idx_train>=28) = idx_train(idx_train>=28) + 2;
idx_train(idx_train>=42) = idx_train(idx_train>=42) + 2;
idx_train(idx_train>=56) = idx_train(idx_train>=56) + 2;
idx_train(idx_train>=70) = idx_train(idx_train>=70) + 2;
idx_train(idx_train>=84) = idx_train(idx_train>=84) + 2;
idx_train(idx_train>=98) = idx_train(idx_train>=98) + 2;
idx_train(idx_train>=112) = idx_train(idx_train>=112) + 2;
idx_train(idx_train>=126) = idx_train(idx_train>=126) + 2;

idx_test = setdiff([1:140],idx_train);
load('E:\Dropbox\Works\Matlab\Ruixinwei\ToolFunctions\SpectralData\DSGColorCheckerSpectralReflectance_order.mat')
sRGB = SpecRef2sRGB(DSGColorCheckerSpectralReflectance,400,780);
ColorChecker = DrawColorChecker(sRGB,10,14,80);
row = ceil(idx_test/14);
col = idx_test - (row-1)*14;
x = 11 + (col-1)*95;
y = 11 + (row-1)*95;
w = 84;
h = 84;
for i = 1:length(idx_test)
    hold on;
    p{i}=patch([x(i),x(i)+w,x(i)+w,x(i)], [y(i),y(i),y(i)+h,y(i)+h],[1 1 1]);
    hp = findobj(p{i},'type','patch');
    hatchfill(hp,'single',45,3);
end
set(gcf,'color','w','Units','inches','Position',[3 1 12 8.8]);
set(gca,'Units','normalized','Position',[.05 .05 .9 .9]);

% A illuminant testing
clear RGB_mean_ranked
load('M:\D3x\A\data\RGB_mean_ranked.mat')
load('E:\Dropbox\Works\papers\ResponsePrediction\SPD_Central_A.mat')
for i = 1:24
    SPD_A_24(i,:) = (SPD_Central_A(2*i-1,:)+SPD_Central_A(2*i,:))/2;
end
SPD_A_24 = SPD_A_24(:,1:5:end);
SPD_A_24x9 = repmat(SPD_A_24,9,1);
clear ISO ExposureTime
ISO = [1, 1.25, 2, 2.5, 4, 5, 8, 10, 16];
ExposureTime = [1/15, 1/20, 1/30, 1/40, 1/60, 1/80, 1/125, 1/160, 1/250];
[DeltaE_test_A, RelativeError_test_A] = CameraResponseTesting(RGB_mean_ranked,SPD_A_24x9,CSS,nonlinearCoef,CrossTalkMtx,ISO,ExposureTime);

clear RGB_mean_ranked
load('M:\D3x\A_ISOext\data\RGB_mean_ranked.mat')
load('E:\Dropbox\Works\papers\ResponsePrediction\SPD_Central_A_ISOext.mat')
RGB_mean_ranked = RGB_mean_ranked(1:24,:); % exclude photos with ISO6400
SPD_Central_A_ISOext = SPD_Central_A_ISOext(:,1:5:end);
ISO = [32];
ExposureTime = [1/500];
[DeltaE_test_A_ISOext, RelativeError_test_A_ISOext] = CameraResponseTesting(RGB_mean_ranked,SPD_Central_A_ISOext,CSS,nonlinearCoef,CrossTalkMtx,ISO,ExposureTime);
