%% =============== Part 1: Pre Process Email ===========================
%  Before getting into details of training data, we first pre process 
%  the email to make our following steps easiler.
%
directory_array = {'./spamassasin-dataset/easy_ham/', 
                   './spamassasin-dataset/easy_ham_2/', 
                   './spamassasin-dataset/hard_ham/', 
                   './spamassasin-dataset/spam/', 
                   './spamassasin-dataset/spam_2/'};
iter_array      = [2500, 1400, 250, 500, 1400];
example_cat     = [0   , 0   , 0  , 1  , 1];

% Number of examples
m = 6046;

% Number of features
n = 2248;

% for i = 1:5
%     preProcess(directory_array{i}, iter_array(i));
% end

%% =============== Part 2: Calculate Word Frequency ====================
%  Counting the frequency of words occurred in all of our emails, 
%  then we could build our own vocabulary list.
%
% word_list = {};
% frequency_list = [];
% for i = 1:5
%     directory  = directory_array{i};
%     iter       = iter_array(i);
%     file_names = readFileName(iter, strcat(directory, 'cmds'));
%     dots       = 12;

%     for j = 1:iter
%         file_path = strcat(strcat(directory, 'processed_email/'), file_names{j});
%         fid = fopen(file_path);
%         if fid == -1
%             continue;
%         end
%         [word_list frequency_list] = wordFrequency(file_path, word_list, frequency_list);

%         fprintf('.');
%         dots = dots + 1;
%         if dots > 78
%            dots = 0;
%            fprintf('\n');
%         end
%         if exist('OCTAVE_VERSION')
%            fflush(stdout);
%         end
%     end
%     fprintf(' Done! \n\n');
% end

%% =============== Part 2: Build Vocabulary List ====================
%  After counted the frequency of words occurred in all of our emails, 
%  then we could build our own vocabulary list.

% % Set the least frequency
% min_frequency = 100;

% % Leaves only words whose frequency is greater or equal than min_frequency
% most_frequent_words = word_list(frequency_list >= min_frequency);

% % Sort words in lexicographic order, and add index to the second column
% most_frequent_words = sortrows(most_frequent_words');
% for i = 1:length(most_frequent_words)
%     most_frequent_words{i, 2} = i;
% end

% % Save the words just like the file vocab.txt in Machine Learning course ex6
% fid = fopen('vocab.txt', 'wt');
% for i = 1:length(most_frequent_words)
%     fprintf(fid, '%d\t%s\n', most_frequent_words{i, 2}, most_frequent_words{i, 1});
% end
% fclose(fid);

%% =============== Part 3: Calculate Word Indices ====================
%  We now have our own vocabulary list. Back to our processed emails, 
%  we should calculate each email's word indices so as to form our 
%  final dataset.

% X = zeros(m, n);
% y = zeros(m, 1);
% iterator = 1;

% for i = 1:5
%     directory  = directory_array{i};
%     iter       = iter_array(i);
%     file_names = readFileName(iter, strcat(directory, 'cmds'));
%     dots       = 12;

%     for j = 1:iter
%         file_path = strcat(strcat(directory, 'processed_email/'), file_names{j});
%         fid = fopen(file_path);
%         if fid == -1
%             continue;
%         end
%         word_indices = wordIndices(file_path);
%         X(iterator, :) = emailFeatures(word_indices);
%         y(iterator) = example_cat(i);
%         iterator = iterator + 1;

%         fprintf('.');
%         dots = dots + 1;
%         if dots > 78
%            dots = 0;
%            fprintf('\n');
%         end
%         if exist('OCTAVE_VERSION')
%            fflush(stdout);
%         end
%     end
%     fprintf(' Done! \n\n');
% end

% % Benign examples from 1 to 4150
% % Spam exmaples from 4151 to 6046
% save ('dataset.mat', 'X', 'y');

%% =============== Part 4: Divide Dataset =========================
%  Randomly devide dataset into three parts:
%      1) A trainning set (60% = 3627).
%      2) A cross validation set (20% = 1209).
%      3) A test set (20% = 1210).
%  Because we have 4150 benign examples and 1896 spam examples
%  that is 68.6% vs 31.4%, we should insure that each set have the same
%  proportion like this:
%      1) Training set (2489 vs 1138)
%      2) CV set (830 vs 379)
%      3) Test set (831 vs 379)

% % Load dataset
% % We will have X and y in our workspace
% load('dataset.mat');

% % Divide proportion
% benign = [2489, 830, 831];
% spam   = [1138, 379, 379];
% name   = {'trainset.mat', 'cvset.mat', 'testset.mat'};

% % Divide dataset into three parts
% % Taining set
% [X_rand_benign y_rand_benign X_left_benign y_left_benign] = divideExample(X(1:4150, :), y(1:4150), 2489);
% [X_rand_spam y_rand_spam X_left_spam y_left_spam] = divideExample(X(4151:6046, :), y(4151:6046), 1138);
% X_train = [X_rand_benign; X_rand_spam];
% y_train = [y_rand_benign; y_rand_spam];
% save('trainset.mat', 'X_train', 'y_train');

% % Cross validation set
% [X_rand_benign y_rand_benign X_left_benign y_left_benign] = divideExample(X_left_benign, y_left_benign, 830);
% [X_rand_spam y_rand_spam X_left_spam y_left_spam] = divideExample(X_left_spam, y_left_spam, 379);
% X_cv = [X_rand_benign; X_rand_spam];
% y_cv = [y_rand_benign; y_rand_spam];
% save('cvset.mat', 'X_cv', 'y_cv');

% % Test set
% [X_rand_benign y_rand_benign X_left_benign y_left_benign] = divideExample(X_left_benign, y_left_benign, 831);
% [X_rand_spam y_rand_spam X_left_spam y_left_spam] = divideExample(X_left_spam, y_left_spam, 379);
% X_test = [X_rand_benign; X_rand_spam];
% y_test = [y_rand_benign; y_rand_spam];
% save('testset.mat', 'X_test', 'y_test');

%% =============== Part 5: SVM Training =========================