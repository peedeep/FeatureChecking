function [y] = linearPredictNormalize (X, theta, mean, sigma, initialWear)

m = size(X, 1);
X_norm = (X - repmat(mean, m, 1)) ./ repmat(sigma, m, 1);
X = [ones(m, 1) X_norm];
%disp(X);
if  initialWear ~= - 1
    y = X * theta + initialWear;
    y = [initialWear; y]; 
else
    y = X * theta;
end

%disp(size(y));

end