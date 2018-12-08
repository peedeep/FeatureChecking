%function [] = predictWearCuts()

%% Predict train Wear Cuts
P_B = csvread('./data/train_result.csv', 1);
plot(max(P_B, [], 2));
train_cuts = caculateWearMaxCuts(P_B);
%save result.txt cuts var -ascii;
fid=fopen('./data/train_result.txt','wt');
fprintf(fid,'%d\n', train_cuts); 
fclose(fid);

%% Predict test Wear Cuts
P = csvread('./data/test_result.csv', 1);
hold on;
plot(max(P, [], 2));
pred_cuts = caculateWearMaxCuts(P);
%save result.txt cuts var -ascii;
fid=fopen('./data/test_result.txt','wt');
fprintf(fid,'%d\n', pred_cuts); 
fclose(fid);

%% Real Wear Cuts
R = csvread('./data/test.csv');
hold on;
plot(max(R, [], 2));
legend('train', 'test', 'real');
real_cuts = caculateWearMaxCuts(R);
%save result.txt cuts var -ascii;
fid=fopen('./data/real.txt','wt');
fprintf(fid,'%d\n', real_cuts); 
fclose(fid);

%% caculate score
punishment1 = caculatePunishment(train_cuts, real_cuts);
punishment = caculatePunishment(pred_cuts, real_cuts);

%% caculate accuracy
m = size(P, 1);

for i = 1:flute_size
    fprintf('\n flute%d Train set 均方误差（MSE）: %f', i, sum((P_B(:, i) - R(:, i)).^2) / m);
    fprintf('\n flute%d Test set 均方误差（MSE）: %f', i, sum((P(:, i) - R(:, i)).^2) / m);
end

%end
