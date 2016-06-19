%% =============== Part 1: Pre Process Email ===========================
%  Before getting into details of training data, we first pre process 
%  the email to make our following steps easiler.
%
file_path_array = {"./spamassasin-dataset/easy_ham/", 
                   "./spamassasin-dataset/easy_ham_2", 
                   "./spamassasin-dataset/hard_ham/", 
                   "./spamassasin-dataset/spam/", 
                   "./spamassasin-dataset/spam_2/"};
iter_array = [2500, 1400, 250, 500, 1400];
for i = 1:5
    preProcess(file_path_array{i}, iter_array(i));
end