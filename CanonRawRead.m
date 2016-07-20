function CanonRawRead(filename,suffix)
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
    [temp,~,~,~] = info.DigitalCamera;
    exposureTime = temp.ExposureTime;
    fNumber = temp.FNumber;
    ISO = temp.ISOSpeedRatings;
    Time = temp.DateTimeDigitized;
    Time = regexprep(Time,':','');Time = regexprep(Time,' ','_');
    [subPathstr,name,~] = fileparts(subFileName);
    OldName = [' ',subPathstr,'\',name,'.pgm'];
    NewName = [' ',Time,'_',num2str(exposureTime),'s_ISO',num2str(ISO),'_f',num2str(fNumber),suffix,'.pgm'];
    eval(['!rename',OldName,NewName]);
end
