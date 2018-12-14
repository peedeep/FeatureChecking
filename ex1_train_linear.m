%% Exercise 1: Linear regression with multiple variables

%% ================ 1.Feature Normalization ================
clear; close all; clc

fprintf('Loading data ...\n');

load('selectedData.mat');

isNormalize = true;

p = (1:314);%选择训练样本数量
Y = Y(p, :);
m = size(Y, 1);%训练样本个数
flute_size = size(Y, 2);%刀片数量
pred = zeros(size(T_X, 1), flute_size);

%% ================ 2.Gradient Descent Train ================
for f = 1:flute_size
    if f == 1
        X = flute1TrainX(p,:);
        T_X = flute1TestX;
    elseif f == 2
        X = flute2TrainX(p,:);
        T_X = flute2TestX;
    elseif f== 3
        X = flute3TrainX(p,:);
        T_X = flute3TestX;
    end
    disp(f)
    
    y = Y(:,f);
    if isNormalize
       [X, mu, sigma] = featureNormalize(X); 
    end
    X = [ones(m, 1) X];
    n = size(X, 2);
    alpha = 0.01;
    num_iters = 61000;
    theta = zeros(n, 1);
    [theta, ~] = gradientDescentMulti(X, y, theta, alpha, num_iters);

    if isAdditional
        initial_wear = [62 55 50];
    else
        initial_wear = [-1 -1 -1];
    end
    
    if isNormalize
       pred(:,f) = linearPredictNormalize(T_X, theta, mu, sigma, initial_wear(f)); 
    else
       pred(:,f) = linearPredict(T_X, theta, initial_wear(f)); 
    end
    
    if f == 1
        theta1 = theta;
        if isAdditional
            fprintf('flute1 Train set 均方误差（MSE）: %f\n', sum((X * theta - Y(:,1)).^2) / m);
        else
            fprintf('flute1 Train set 均方误差（MSE）: %f\n', sum((X * theta - Y(:,1)).^2) / m);
        end
    elseif f == 2
        theta2 = theta;
        if isAdditional
            fprintf('flute2 Train set 均方误差（MSE）: %f\n', sum((X * theta - Y(:,2)).^2) / m);
        else
            fprintf('flute2 Train set 均方误差（MSE）: %f\n', sum((X * theta - Y(:,2)).^2) / m);
        end
    elseif f == 3
        theta3 = theta;  
        if isAdditional
            fprintf('\flute3 Train set 均方误差（MSE）: %f\n', sum((X * theta - Y(:,3)).^2) / m);
        else
            fprintf('flute3 Train set 均方误差（MSE）: %f\n', sum((X * theta - Y(:,3)).^2) / m);
        end
    end
    
end

writetable(table(pred), './data/result.csv') ;

%% check
predictWearCuts
