function NikonRawRead(filename,suffix)
if ~exist('suffix','var')
    suffix = '';
else
    suffix = ['_',suffix];
end
[pathstr,~,~] = fileparts(filename);
flist = dir(filename);
for i = 1:length(flist)
    subFileName = [pathstr,'\',flist(i).name];
    system(['dcraw -E -4 ',subFileName]);
    info = imfinfo(subFileName);
    exposureTime = info.DigitalCamera.ExposureTime;
    fNumber = info.DigitalCamera.FNumber;
%     ISO = info.DigitalCamera.ISOSpeedRatings;
    Time = info.DigitalCamera.DateTimeDigitized;
    Time = regexprep(Time,':','');Time = regexprep(Time,' ','_');
    [subPathstr,name,~] = fileparts(subFileName);
    OldName = [' ',subPathstr,'\',name,'.pgm'];
    index = ['_',name(5:8)];
    NewName = [' ',Time,'_',num2str(exposureTime),'s_f',num2str(fNumber),index,suffix,'.pgm'];
%     NewName = [' ',Time,'_',num2str(exposureTime),'s_ISO',num2str(ISO),'_f',num2str(fNumber),index,suffix,'.pgm'];
    eval(['!rename',OldName,NewName]);
    
    pgmFileName = [pathstr,'\',NewName(2:end-4),'.pgm'];
    I = double(imread(pgmFileName))/(2^14-1);
    R = I(1:2:end,1:2:end);
    G = (I(1:2:end,2:2:end) + I(2:2:end,1:2:end))/2;
    B = I(2:2:end,2:2:end);
    ImgRGB = cat(3,R,G,B);
    SaveFileName = [pathstr,'\',NewName(2:end-4),'.mat'];
    save(SaveFileName,'ImgRGB');
    delete(pgmFileName);
    clear I R G B ImgRGB subFileName SaveFileName pgmFileName;
end
