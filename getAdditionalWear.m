function [X, Y] = getAdditionalWear(X, Y)

X = X(2:end, :);
m = size(Y, 1);
y_initial = Y(1, :);
Y = Y(2:end, :) - repmat(y_initial, m - 1, 1);

end