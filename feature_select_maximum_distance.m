clc; clear;

A = csvread('./filter/TrainDataA6.csv', 1);
B = csvread('./filter/TrainDataB6.csv', 1);
T_X = csvread('./filter/TestData6.csv', 1);
A_X = A(:,1:end-3);
A_Y = A(:, end-2:end);
A_Y = max(A_Y, [], 2);
B_X = B(:,1:end-3);
B_Y = B(:,end-2: end);
B_Y = max(B_Y, [], 2); 
X = [A_X; B_X];
Y = [A_Y; B_Y];

% load('AllData.mat');
% A_Y = max(A_Y, [], 2);
% B_Y = max(B_Y, [], 2); 
% Y = [A_Y; B_Y];

isAdditional = true;

if isAdditional
  
    %[ffs] = featureMaximumFDR(X, Y);
    %T_X = T_X(:, ffs);
    %A_X = A_X(:, ffs);
    %B_X = B_X(:, ffs);
    
    [X_Addi_A, Y_Addi_A] = getAdditionalWear(A_X, A_Y);
    [X_Addi_B, Y_Addi_B] = getAdditionalWear(B_X, B_Y);

    X_Addi = [X_Addi_A; X_Addi_B];
    Y_Addi = [Y_Addi_A; Y_Addi_B];
    [fs] = featureMaximumDistance(X_Addi, Y_Addi);
    %fs = fs(1:7);
    
    %fs = (1:6);
    flutesTrainAX = X_Addi_A(:, fs);
    flutesTrainBX = X_Addi_B(:, fs);

    flutesTrainX = X_Addi(:, fs);
    flutesTestX = T_X(:, fs);
    
else
    
    [fs] = featureMaximumFDR(X, Y);
    flutesTrainX = X(:, fs);
    flutesTestX = T_X(:, fs);
    
end

writetable(table([flutesTrainX Y]), './data/TrainFlutes.csv') ;
writetable(table(flutesTestX), './data/TestFlutes.csv') ;

save('selectedData');

ex3_train_nn_maximum