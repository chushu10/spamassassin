function file_names = readFileName(file_num, file_index)
%READFILENAME reads a "cmds" file and return all the file names in it
% file_names = readFileName(fileindex) reads a "cmds" file and return all the file names in file_names

% Number of files in "file_index"
file_names = cell(file_num, 1);

% Load "cmd" file
fid = fopen(file_index);
for i = 1:file_num
    txt = fgetl(fid);
    file_names{i} = strsplit(txt, ' '){3};
end
fclose (fid);