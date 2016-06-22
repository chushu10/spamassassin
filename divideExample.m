function [X_rand y_rand X_left y_left] = divideExample(X, y, s)
% divideExample randomly select s examples from X to form X_rand
%                                      and from y to form y_rand
% And also return the examples left which is X_left and y_left
% WARNING: s must be smaller than the size of the dimension of X

% Size of X
m = size(X, 1);
n = size(X, 2);

% Init return values
X_rand = zeros(s, n);
y_rand = zeros(s, 1);
X_left = zeros(m - s, n);
y_left = zeros(m - s, 1);

% Randomly pick s numbers from m numbers
sample = randperm(m, s);

% Pick X_rand and y_rand
for i = 1:s
	X_rand(i, :) = X(sample(i), :);
	y_rand(i) = y(sample(i));
end

% Pick X_left and y_left
iterator = 1;
for i = 1:m
    if ~isempty(find(sample == i))
        continue;
    end
    X_left(iterator, :) = X(i, :);
    y_left(iterator) = y(i, :);
    iterator = iterator + 1;
end
