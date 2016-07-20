function pgm2RGB(filename)
[pathstr,~,~] = fileparts(filename);
flist = dir(filename);
for i = 1:length(flist)
    subFileName = [pathstr,'\',flist(i).name];
    I = double(imread(subFileName))/(2^14-1);
    R = I(1:2:end,1:2:end);
    G = (I(1:2:end,2:2:end) + I(2:2:end,1:2:end))/2;
    B = I(2:2:end,2:2:end);
    ImgRGB = cat(3,R,G,B);
    SaveFileName = [pathstr,'\',flist(i).name(1:end-4),'.mat'];
    save(SaveFileName,'ImgRGB');
    clear I R G B ImgRGB subFileName SaveFileName;
end