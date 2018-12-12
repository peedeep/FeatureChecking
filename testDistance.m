clear; clc;

load('selectedData.mat');

m = size(A_X, 1);
n = size(A_X, 2);
K = 15;

u_k_mean = zeros(K , n);
u_mean = mean(A_X, 1);

num = m / K;
    
for k = 1:K
    p(k, :) = ((k - 1) * num + 1 : k * num);
    x_k = A_X(p(k, :), :);
    u_k_mean(k, :) = mean(x_k, 1);
    %b(k, :) = num * (u_k_mean(k, :) - u_mean) * (u_k_mean(k, 1) - u_mean);
    %s_i = (x_k - u_k_mean(k, :))' * (x_k - u_k_mean(k, :)); 
end

for i = 1:n
    s_b(i) = num * (u_k_mean(:, i) - u_mean(i))' * (u_k_mean(:, 1) - u_mean(i));
    %s_i = (x_k - u_k_mean(i))' * (x_k - u_k_mean(i)); 
    %s_i(:, i) = (u_k_mean(:, i) - u_mean(i))' * (u_k_mean(:, 1) - u_mean(i));
    for k = 1:K
        x_k = A_X(p(k, :), i);
        s_i(k, i) = (x_k - u_k_mean(k, i))' * (x_k - u_k_mean(k, i));
    end
    s_w(i) = sum(s_i(:, i));

end

R = abs(s_b) ./ abs(s_w);