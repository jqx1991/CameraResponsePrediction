function XYZ = RGB2XYZ_RPCC(RGB)
% RGB should be N*3 matrix
R = RGB(:,1);
G = RGB(:,2);
B = RGB(:,3);
RootPolyRGB = [R, G, B, sqrt(R.*G), sqrt(G.*B), sqrt(R.*B),...
              (R.*G.^2).^(1/3), (G.*B.^2).^(1/3), (R.*B.^2).^(1/3), (G.*R.^2).^(1/3), (B.*G.^2).^(1/3), (B.*R.^2).^(1/3), (R.*G.*B).^(1/3),...
              (R.*G.^3).^(1/4), (G.*B.^3).^(1/4), (R.*B.^3).^(1/4), (G.*R.^3).^(1/4), (B.*G.^3).^(1/4), (B.*R.^3).^(1/4),...
              (R.^2.*G.*B).^(1/4), (G.^2.*R.*B).^(1/4), (B.^2.*R.*G).^(1/4)];
load('E:\Dropbox\Works\Matlab\Papers\ResponsePrediction\cameraRGB2XYZ.mat')
XYZ = RootPolyRGB * RGB2XYZ;