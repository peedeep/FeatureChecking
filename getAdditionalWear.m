function [X, Y] = getAdditionalWear(X, Y)

X = X(1:end, :);
m = size(Y, 1);
y_initial = Y(1, :);
Y = Y - repmat(y_initial, m, 1);

end