function [X_rand, y_rand, X_left, y_left] = divideExample(X, y, s)
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

% Randomly divide example indexes into two
rand_num = randperm(m);
sample_rand = rand_num(1:s);
sample_left = rand_num(s + 1:m);

% Pick X_rand and y_rand
X_rand = X(sample_rand, :);
y_rand = y(sample_rand);

% Pick X_left and y_left
X_left = X(sample_left, :);
y_left = y(sample_left);
