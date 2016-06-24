function [word_list, frequency_list] = wordFrequency(file_path, word_list, frequency_list)
% wordFrequency funtions calculate the words occurred in one file,
% it take three arguments:
%     file_path:       the path to the file to be dealt with
%     word_list:       currently how many words are occurred in all of the emails
%     frequency_list:  the frequency of each word corresponding to wordList

% Load proccessed emails
% We will have word_array in Octave workspace
load(file_path);

% Loop to find if the words in word_array is in word_list
for i = 1:length(word_array)
    word = word_array{i};
    match = strcmp(word, word_list);
    index = find(match);
    if ~isempty(index)
        frequency_list(index) = frequency_list(index) + 1;
    else
        current = length(word_list) + 1;
        word_list{current} = word;
        frequency_list(current) = 0;
        frequency_list(current) = frequency_list(current) + 1;
    end
end

% Close the file, otherwise when processed too many files Octave will crash
fclose(file_path);