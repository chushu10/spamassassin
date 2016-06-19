function preProcess(file_path, m)
% file_path is the file path, m is the number of examples

% Read File Names
file_names = readFileName(m, strcat(file_path, "cmds"));

dots = 12;

for i = 1:m
    file_contents = readFile(strcat(file_path, file_names{i}));
    if strcmp(file_contents, "") == 1
        continue;
    end
    word_array    = processEmailSilent(file_contents);
    save(strcat(strcat(file_path, "processed_email/"), file_names{i}), "word_array");
    
    fprintf('.');
    dots = dots + 1;
    if dots > 78
       dots = 0;
       fprintf('\n');
    end
    if exist('OCTAVE_VERSION')
       fflush(stdout);
    end
end
fprintf(' Done! \n\n');