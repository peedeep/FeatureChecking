%function [] = predictWearCuts()

%% Predict train a Wear Cuts
pred_a_wear = csvread('./data/train_a_result.csv', 1);
figure;
subplot(3, 1, 1);
pred_maximum_a_wear = max(pred_a_wear, [], 2);
plot(pred_maximum_a_wear);
pred_a_cuts = caculateWearMaxCuts(pred_maximum_a_wear);
%save result.txt cuts var -ascii;
fid=fopen('./data/train_a_result.txt','wt');
fprintf(fid,'%d\n', pred_a_cuts); 
fclose(fid);

hold on;
real_maximum_a_wear = A_Y;
plot(real_maximum_a_wear);
legend('predA', 'realA');
real_a_cuts = caculateWearMaxCuts(real_maximum_a_wear);

%% Predict train b Wear Cuts
pred_b_wear = csvread('./data/train_b_result.csv', 1);
subplot(3, 1, 2);
pred_maximum_b_wear = max(pred_b_wear, [], 2);
plot(pred_maximum_b_wear);
pred_b_cuts = caculateWearMaxCuts(pred_maximum_b_wear);
%save result.txt cuts var -ascii;
fid=fopen('./data/train_b_result.txt','wt');
fprintf(fid,'%d\n', pred_b_cuts); 
fclose(fid);

hold on;
real_maximum_b_wear = B_Y;
plot(real_maximum_b_wear);
legend('predB', 'realB');
real_b_cuts = caculateWearMaxCuts(real_maximum_b_wear);

%% Predict test Wear Cuts
pred_test_wear = csvread('./data/test_result.csv', 1);
subplot(3, 1, 3);
pred_maximum_test_wear = max(pred_test_wear, [], 2);
%figure;
plot(pred_maximum_test_wear);
pred_test_cuts = caculateWearMaxCuts(pred_maximum_test_wear);
%save result.txt cuts var -ascii;
fid=fopen('./data/test_result.txt','wt');
fprintf(fid,'%d\n', pred_test_cuts); 
fclose(fid);

%% Real Wear Cuts
real_test_wear = csvread('./data/test.csv');
hold on;
real_maximum_test_wear = max(real_test_wear, [], 2);
plot(real_maximum_test_wear);
legend('predTest', 'realTest');
real_test_cuts = caculateWearMaxCuts(real_maximum_test_wear);
%save result.txt cuts var -ascii;
fid=fopen('./data/real.txt','wt');
fprintf(fid,'%d\n', real_test_cuts); 
fclose(fid);

%% caculate score
punishment_a = caculatePunishment(pred_a_cuts, real_a_cuts);
punishment_b = caculatePunishment(pred_b_cuts, real_b_cuts);
punishment_test = caculatePunishment(pred_test_cuts, real_test_cuts);

%% caculate accuracy
m = size(pred_maximum_test_wear, 1);

for i = 1:flute_size
    fprintf('\n flute%d train a set 均方误差（MSE）: %f', i, sum((pred_maximum_a_wear - real_maximum_a_wear).^2) / m);
    fprintf('\n flute%d train b set 均方误差（MSE）: %f', i, sum((pred_maximum_b_wear - real_maximum_b_wear).^2) / m);
    fprintf('\n flute%d Test set 均方误差（MSE）: %f\n', i, sum((pred_maximum_test_wear - real_maximum_test_wear).^2) / m);
end

%end
