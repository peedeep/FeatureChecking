function [y] = linearPredict (X, theta, initialWear)

m = size(X, 1);
X = [ones(m, 1) X];
if initialWear ~= -1
    y = X * theta + initialWear;
    %y = [initialWear; y]; 
else
    y = X * theta;
end

end