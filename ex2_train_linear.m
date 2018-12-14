%% Exercise 1: Linear regression with multiple variables

%% ================ 1.Feature Normalization ================
clear; close all; clc

load('selectedData.mat');

flute_size = size(Y, 2);%刀片数量

train_p = (1:315);
test_p = (316: 630);

TrainDataX = flutesTrainX(train_p, :);
TestDataX = flutesTrainX(test_p, :);

if isAdditional 
    TrainDataY = Y_Addi(train_p, :);
    TestDataY = Y_Addi(test_p, :);
else
    TrainDataY = Y(train_p, :);
    TestDataY = Y(test_p, :);
end

pred_train_a = zeros(315, flute_size);%测试样本1预测结果
pred_train_b = zeros(315, flute_size);%测试样本1预测结果
pred_test = zeros(315, flute_size);%测试样本2预测结果

%% ================ 2.NN Train ================
for f = 1:flute_size
    
    %% nn train
    %net = newff(TrainDataX', TrainDataY', 6,  {'logsig', 'purelin'});
    m = size(TrainDataX, 1);
    TrainX = [ones(m, 1) TrainDataX];
    n = size(TrainX, 2);
    alpha = 1e-5;
    num_iters = 70000;
    theta = zeros(n, 1);
    [theta, J] = gradientDescentMulti(TrainX, TrainDataY, theta, alpha, num_iters);
    %plot((1:num_iters), J)
    
    %% for train data predict
    %initial_wear = [62 55 50];
    initial_wear = [48.9 9.89 14.6];
    if isAdditional
        pred_train_b(:, f) = linearPredict(TestDataX, theta, initial_wear(f));
    else
        pred_train_b(:, f) = linearPredict(TestDataX, theta, -1);
    end

    %% for test data predict
    %BPoutput = sim(net, flutesTestX');
        
    %initial_wear = [62 55 50];
    initial_wear = [62.7 9.89 14.6];
    if isAdditional
        pred_test(:, f) = linearPredict(flutesTestX, theta, initial_wear(f));
    else
        pred_test(:, f) = linearPredict(flutesTestX, theta, -1);
    end
    
   %% for train a data predict
    %BPoutput = sim(net, flutesTrainAX');
    initial_wear = [31.4 9.89 14.6];
    if isAdditional
        pred_train_a(:, f) = linearPredict(flutesTrainAX, theta, initial_wear(f));
    else
        pred_train_a(:, f) = linearPredict(flutesTrainAX, theta, -1);
    end
    
end

writetable(table(pred_train_a), './data/train_a_result.csv') ;
writetable(table(pred_train_b), './data/train_b_result.csv') ;
writetable(table(pred_test), './data/test_result.csv') ;
%plot(train_y_value);

%% check
predictWearABTAllCuts

save('AllPredict');
