function [DeltaE, RelativeError] = CameraResponseTestingComparison(RGB,SPD,CSS,nlCoefs,CrossTalkMtx,ISO,ExposureTime)
N = length(ISO); % the number of images in a image set (the number of combination of different capturing setting)
wlNum = size(SPD,2);
wlInterval = (720-400)/(wlNum-1);
patchNum = size(RGB,1)/N;
const_geometry = (pi/4)*((1/4)^2);

if size(ISO,2) == 1 % ISO and ExposureTime are row vectors
    ISO = ISO';
    ExposureTime = ExposureTime';
end
ISO = repmat(ISO,patchNum,1);
ISO = ISO(:);
ExposureTime = repmat(ExposureTime,patchNum,1);
ExposureTime = ExposureTime(:);
C1 = nlCoefs(1);C2 = nlCoefs(2);alpha = nlCoefs(3);

RGB_pred = diag(ISO) * (real( ( diag(ExposureTime*const_geometry*wlInterval)*SPD*CSS*CrossTalkMtx + C1 ).^alpha )) + C2;
% XYZ = RGB2XYZ_RPCC(RGB)/100;
% XYZ_pred = RGB2XYZ_RPCC(RGB_pred)/100;
% 
% DeltaE = sRGB2CIEDeltaE(XYZ,XYZ_pred,'cie00','XYZ');
DeltaE = sRGB2CIEDeltaE(RGB.^(1/2.2),RGB_pred.^(1/2.2),'cie00');
RelativeError = mean(abs(RGB-RGB_pred)./RGB,2);