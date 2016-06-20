%% =============== Part 1: Pre Process Email ===========================
%  Before getting into details of training data, we first pre process 
%  the email to make our following steps easiler.
%
directory_array = {"./spamassasin-dataset/easy_ham/", 
                   "./spamassasin-dataset/easy_ham_2/", 
                   "./spamassasin-dataset/hard_ham/", 
                   "./spamassasin-dataset/spam/", 
                   "./spamassasin-dataset/spam_2/"};
iter_array      = [2500, 1400, 250, 500, 1400];
% for i = 2:5
%     preProcess(directory_array{i}, iter_array(i));
% end

%% =============== Part 2: Calculate Word Frequency ====================
%  Counting the frequency of words occurred in all of our emails, 
%  then we could build our own vocabulary list.
%
word_list = {};
frequency_list = [];
for i = 1:5
    directory  = directory_array{i};
    iter       = iter_array(i);
    file_names = readFileName(iter, strcat(directory, "cmds"));
    dots       = 12;

    for j = 1:iter
        file_path = strcat(strcat(directory, "processed_email/"), file_names{j});
        fid = fopen(file_path);
        if fid == -1
            continue;
        end
        [word_list frequency_list] = wordFrequency(file_path, word_list, frequency_list);

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
end