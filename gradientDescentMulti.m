function [theta, J_history] = gradientDescentMulti (X, y, theta, alpha, num_iters)

m = length(y);
J_history = zeros(num_iters, 1);

for iter = 1 : num_iters
%     fprintf('****************************%d\n', iter);
%     disp(X)
%     fprintf('X * theta:\n');
%     disp(X * theta)
%     fprintf('theta\n');
%     disp(theta) 
	theta = theta - alpha / m * X' * (X * theta - y);
    
%    fprintf('****************************\n');
%    pause;
    clc;
%     if iter < 336 && 330 < iter
%         fprintf('============\n');
%         disp(size(X))
%         fprintf('X * theta: %f\n', (X * theta));
%         disp(size(theta))
%         fprintf('iter: %d\n', iter);
%         %disp(theta) 
%         pause;
%         clc;
%     end
	J_history(iter) = computeCostMulti(X, y, theta);
end

end