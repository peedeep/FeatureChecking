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
    [inputn, inputps] = mapminmax(TrainDataX');
    [outputn, outputps] = mapminmax(TrainDataY');
    net = newff(inputn, outputn, 6,  {'logsig', 'purelin'});
    
    net.trainParam.epochs = 1000;
    net.trainParam.lr = 0.01;
    net.trainParam.goal = 0.00004;
    net = train(net, inputn, outputn);
    
    %% for train data predict
    %BPoutput = sim(net, TestDataX');
    inputn_test = mapminmax('apply', TestDataX', inputps);
    an = sim(net, inputn_test);
    BPoutput = mapminmax('reverse', an', outputps);
    
    %initial_wear = [62 55 50];
    initial_wear = [48.9 9.89 14.6];
    if isAdditional
        pred_train_b(:, f) = nnPredict(BPoutput, initial_wear(f));
    else
        pred_train_b(:, f) = BPoutput;
    end

    %% for test data predict
    %BPoutput = sim(net, flutesTestX');
    inputn_test = mapminmax('apply', flutesTestX', inputps);
    an = sim(net, inputn_test);
    BPoutput = mapminmax('reverse', an', outputps);
        
    %initial_wear = [62 55 50];
    initial_wear = [62.7 9.89 14.6];
    if isAdditional
        pred_test(:, f) = nnPredict(BPoutput, initial_wear(f));
    else
        pred_test(:, f) = BPoutput;
    end
    
   %% for train a data predict
    %BPoutput = sim(net, flutesTrainAX');
    inputn_test = mapminmax('apply', flutesTrainAX', inputps);
    an = sim(net, inputn_test);
    BPoutput = mapminmax('reverse', an', outputps);
    initial_wear = [31.4 9.89 14.6];
    if isAdditional
        pred_train_a(:, f) = nnPredict(BPoutput, initial_wear(f));
    else
        pred_train_a(:, f) = BPoutput;
    end
    
end

writetable(table(pred_train_a), './data/train_a_result.csv') ;
writetable(table(pred_train_b), './data/train_b_result.csv') ;
writetable(table(pred_test), './data/test_result.csv') ;
%plot(train_y_value);

%% check
predictWearABTAllCuts

save('AllPredict');
