function [RGB_mean, RGB_median, RGB_variance] = ColorCheckerDataPickOneByOne(filename, ColorCheckerSize, radius,N)
% N is the number of photos (settings) for each patch
if ~exist('N','var')
    N = 1;
end
patchNum = ColorCheckerSize(1)*ColorCheckerSize(2);
X = zeros(N*patchNum,1); Y = zeros(N*patchNum,1);
RGB_mean = zeros(N*patchNum,3); RGB_median = zeros(N*patchNum,3); RGB_variance = zeros(N*patchNum,3);

[pathstr,~,~] = fileparts(filename);
flist = dir(filename);
% Extraction Begin
load([pathstr,'\',flist(1).name]);
fisrtFig = figure;
imshow(ImgRGB.^(1/2.2));zoomcenter(2680,380,6);
set(fisrtFig,'Units','normalized','Position',[0 0 1 1])
[X(1),Y(1)] = ginput;
hold on;rectangle('Position',[X(1)-radius Y(1)-radius 2*radius+1 2*radius+1]);
clear ImgRGB

for iImg = 1:N:length(flist)
    load([pathstr,'\',flist(iImg).name]);
    if iImg > N
        X(iImg) = X(iImg-N);
        Y(iImg) = Y(iImg-N);
    end
    [RGB_mean(iImg,:), RGB_median(iImg,:), RGB_variance(iImg,:), ~, ~] = ColorCheckerDataPick1By1(ImgRGB, 1, radius, X(iImg), Y(iImg));
    prompt = ['Use default corners coordinates(picked for last patch) for No.',num2str((iImg+(N-1))/N),' patch? (y/n)'];
    result = input(prompt,'s');
    if result == 'n' || result == 'N'
        [RGB_mean(iImg,:), RGB_median(iImg,:), RGB_variance(iImg,:), X(iImg), Y(iImg)] = ColorCheckerDataPick1By1(ImgRGB, 1, radius);
        close gcf;
        clear ImgRGB
    end
    clear ImgRGB
    close gcf;
    clc;
end

for iImg = 1:N:length(flist)
    for k = iImg+1:1:iImg+N-1
        load([pathstr,'\',flist(k).name]);
        R = ImgRGB(round(Y(iImg))-radius:round(Y(iImg))+radius,round(X(iImg))-radius:round(X(iImg))+radius,1);
        R = R(:);
        G = ImgRGB(round(Y(iImg))-radius:round(Y(iImg))+radius,round(X(iImg))-radius:round(X(iImg))+radius,2);
        G = G(:);
        B = ImgRGB(round(Y(iImg))-radius:round(Y(iImg))+radius,round(X(iImg))-radius:round(X(iImg))+radius,3);
        B = B(:);
        RGB_mean(k,:) = [mean(R),mean(G),mean(B)];
        RGB_median(k,:) = [median(R),median(G),median(B)];
        RGB_variance(k,:) = [var(R),var(G),var(B)];
        clear ImgRGB R G B
    end
end
end

function [RGB_mean, RGB_median, RGB_variance, X, Y] = ColorCheckerDataPick1By1(img,gain,radius,X,Y)
% ��ȡ��ĳ��ɫ��ͼƬ�и�ɫ���RGBֵ�����Ϊ[0,255]��double������
% img Ϊ�����а���ɫ����ͼƬ
% ��ԭʼͼ��̫������ʹ��ϵ�� gain ��ǿ��ʾЧ����Ĭ�� gain = 1
% �����ϡ����ϡ����¡����µ�˳����ɫ���ĸ����ϵ�ʮ�ֱ�ǽ��ж�λ
% RGBColorChecker ΪһN*3�ľ�����������ɫ���ţ��������ң��������£���ÿ�б�ʾ��ɫ���RGBֵ
% ͼ�����������ת���������������ʱ����У��������ʹ�øô�����м���
if isa(img,'uint8')
    img = double(img)/(2^8-1);
elseif isa(img,'uint16')
    img = double(img)/(2^16-1);
end
if ~exist('gain','var')
    gain = 1;
end
newfig = figure;imshow((img*gain).^(1/2.2));zoomcenter(2680,380,6);set(newfig,'Units','normalized','Position',[0 0 1 1])
if ~exist('X','var') && ~exist('Y','var')
    [X,Y] = ginput; %��ȡɫ�����������꣬�������Ҵ�������˳��
end
R = img(round(Y)-radius:round(Y)+radius,round(X)-radius:round(X)+radius,1);
R = R(:);
G = img(round(Y)-radius:round(Y)+radius,round(X)-radius:round(X)+radius,2);
G = G(:);
B = img(round(Y)-radius:round(Y)+radius,round(X)-radius:round(X)+radius,3);
B = B(:);
RGB_mean = [mean(R),mean(G),mean(B)];
RGB_median = [median(R),median(G),median(B)];
RGB_variance = [var(R),var(G),var(B)];
hold on;rectangle('Position',[X-radius Y-radius 2*radius+1 2*radius+1]);
end