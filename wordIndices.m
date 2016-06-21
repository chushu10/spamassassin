function word_indices = wordIndices(file_path)

% Get vocabulary list
vocabList = getVocabList();

% Init return value
word_indices = [];

% Load proccessed emails
% We will have word_array in Octave workspace
load(file_path);

for i = 1:length(word_array)
    match = strcmp(word_array{i}, vocabList);
    word_indices = [word_indices ; find(match)];
end

% Close the file, otherwise when processed too many files Octave will crash
fclose(file_path);