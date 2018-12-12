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

pred_train = zeros(315, flute_size);%测试样本1预测结果
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
    inputn_test = mapminmax('apply', TestDataX', inputps);
    an = sim(net, inputn_test);
    BPoutput = mapminmax('reverse', an', outputps);
    %pred(:, f) = BPoutput; 
    
    %initial_wear = [62 55 50];
    initial_wear = [48.9 9.89 14.6];
    if isAdditional
        pred_train(:, f) = nnPredict(BPoutput, initial_wear(f));
    else
        pred_train(:, f) = BPoutput;
    end

    %% for test data predict
    inputn_test = mapminmax('apply', flutesTestX', inputps);
    an = sim(net, inputn_test);
    BPoutput = mapminmax('reverse', an', outputps);
    %pred(:, f) = BPoutput;
        
    %initial_wear = [62 55 50];
    initial_wear = [62.7 9.89 14.6];
    if isAdditional
        pred_test(:, f) = nnPredict(BPoutput, initial_wear(f));
    else
        pred_test(:, f) = BPoutput;
    end
    
    %% 测试数据均方误差（MSE）
    an = sim(net, inputn);
    BPoutput = mapminmax('reverse', an', outputps);
    initial_wear = [31.4 9.89 14.6];
    if isAdditional
        train_y_value(:, f) = nnPredict(BPoutput, initial_wear(f));
    else
        train_y_value(:, f) = BPoutput;
    end
    
    if f == 1
       net1 = net;
       inputps1 = inputps;
       outputps1 = outputps;
       save net1 net1 inputps1 outputps1;
    elseif f == 2
       net2 = net;
       inputps2 = inputps;
       outputps2 = outputps;
       save net2 net2 inputps2 outputps2;
    elseif f == 3
       net3 = net;
       inputps3 = inputps;
       outputps3 = outputps;
       save net3 net3 inputps3 outputps3;
    end
    
    if isAdditional
        %fprintf('flute%d Train set 均方误差（MSE）: %f\n', f, sum((train_y_value(:, f) - A_Y(:,1)).^2) / size(A_Y, 1));
    else
        %fprintf('flute%d Train set 均方误差（MSE）: %f\n', f, sum((train_y_value(:, f) - A_Y(:,1)).^2) / size(A_Y, 1));
    end
    
end

writetable(table(pred_train), './data/train_result.csv') ;
writetable(table(pred_test), './data/test_result.csv') ;
%plot(train_y_value);

%% check
predictWearAllCuts

save('AllPredict');
