% find optimal cross talk matrix for bisected responses, given camera
% spectral sensitivity and nonlinearity data from central training result
load('M:\D3x\Half\data\RGB_mean_ranked.mat')
load('E:\Dropbox\Works\papers\ResponsePrediction\SPD_Middle.mat')
for i = 1:96
    SPD(i,:) = (SPD_Middle(2*i-1,:)+SPD_Middle(2*i,:))/2;
end
SPD = SPD(:,1:5:end);
SPD = repmat(SPD,5,1);
RGB = RGB_mean_ranked;
maxWeight = 0.1;
wlNum = size(SPD,2);
wlInterval = (780-380)/(wlNum-1);
patchesNum = size(SPD,1)/5;

load('E:\Dropbox\Works\Matlab\Papers\ResponsePrediction\result_20160314.mat')

const_geometry = (pi/4)*((1/4)^2); % #F = 4
ISO = [1*ones(patchesNum,1);2*ones(patchesNum,1);4*ones(patchesNum,1);8*ones(patchesNum,1);16*ones(patchesNum,1)];
ExposureTime = [1/15*ones(patchesNum,1);1/30*ones(patchesNum,1);1/60*ones(patchesNum,1);1/125*ones(patchesNum,1);1/250*ones(patchesNum,1)];
CrossTalkMtx = @(x) [x(1) x(2) 0; x(3) x(4) x(5); 0 x(6) x(7)];
RGB_reconst = @(x) diag(ISO) * (real( ( diag(x(8)*ExposureTime*const_geometry*wlInterval)*SPD*CSS*CrossTalkMtx(x) + nonlinearCoef(1) ).^nonlinearCoef(3) )) + nonlinearCoef(2);
RGB_reconst = @(x) max(RGB_reconst(x),0);
RGB_reconst = @(x) min(RGB_reconst(x),1);
DeltaE = @(x) sRGB2CIEDeltaE(RGB.^(1/2.2),RGB_reconst(x).^(1/2.2),'cie00');
costfun = @(x) mean(DeltaE(x)) + maxWeight*max(DeltaE(x));

x0 = [1;0;0;1;0;0;1;1];
lb = [0.95;0;0;0.95;0;0;0.95;0.6];
ub = [1;0.05;0.05;1;0.05;0.05;1;1];

options = optimoptions(@fmincon ,'MaxFunEvals',30000,'Display','iter','PlotFcns',@optimplotfval);
[x_optimal,fval,exitflag,output,lambda] = fmincon(costfun,x0,[],[],[],[],lb,ub,[],options);
clear CSS_opt CrossTalkMtx RGB_reconst DeltaE

CrossTalkMtx = [x_optimal(1) x_optimal(2) 0; x_optimal(3) x_optimal(4) x_optimal(5); 0 x_optimal(6) x_optimal(7)];
geometryScale = x_optimal(8);

% find optimal cross talk matrix for peripherical responses, given camera
% spectral sensitivity and nonlinearity data from central training result
load('m:\D3x\Corner\data\RGB_mean_ranked.mat')
load('e:\Dropbox\Works\papers\ResponsePrediction\SPD_Periphery.mat')
for i = 1:96
    SPD(i,:) = (SPD_Periphery(2*i-1,:)+SPD_Periphery(2*i,:))/2;
end
SPD = SPD(:,1:5:end);
SPD = repmat(SPD,5,1);
RGB = RGB_mean_ranked;
maxWeight = 0.1;
wlNum = size(SPD,2);
wlInterval = (780-380)/(wlNum-1);
patchesNum = size(SPD,1)/5;

load('E:\Dropbox\Works\Matlab\Papers\ResponsePrediction\result_20160314.mat')

const_geometry = (pi/4)*((1/4)^2); % #F = 4
ISO = [1*ones(patchesNum,1);2*ones(patchesNum,1);4*ones(patchesNum,1);8*ones(patchesNum,1);16*ones(patchesNum,1)];
ExposureTime = [1/15*ones(patchesNum,1);1/30*ones(patchesNum,1);1/60*ones(patchesNum,1);1/125*ones(patchesNum,1);1/250*ones(patchesNum,1)];
CrossTalkMtx = @(x) [x(1) x(2) 0; x(3) x(4) x(5); 0 x(6) x(7)];
RGB_reconst = @(x) diag(ISO) * (real( ( diag(x(8)*ExposureTime*const_geometry*wlInterval)*SPD*CSS*CrossTalkMtx(x) + nonlinearCoef(1) ).^nonlinearCoef(3) )) + nonlinearCoef(2);
RGB_reconst = @(x) max(RGB_reconst(x),0);
RGB_reconst = @(x) min(RGB_reconst(x),1);
DeltaE = @(x) sRGB2CIEDeltaE(RGB.^(1/2.2),RGB_reconst(x).^(1/2.2),'cie00');
costfun = @(x) mean(DeltaE(x)) + maxWeight*max(DeltaE(x));

x0 = [1;0;0;1;0;0;1;1];
lb = [0.9;0;0;0.9;0;0;0.9;0.3];
ub = [1;0.1;0.1;1;0.1;0.1;1;1];

options = optimoptions(@fmincon ,'MaxFunEvals',30000,'Display','iter','PlotFcns',@optimplotfval);
[x_optimal,fval,exitflag,output,lambda] = fmincon(costfun,x0,[],[],[],[],lb,ub,[],options);
clear CSS_opt CrossTalkMtx RGB_reconst DeltaE

CrossTalkMtx = [x_optimal(1) x_optimal(2) 0; x_optimal(3) x_optimal(4) x_optimal(5); 0 x_optimal(6) x_optimal(7)];
geometryScale = x_optimal(8);
