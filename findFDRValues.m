function [u, k, no_zero_indexs] = findFDRValues (p_val)

p_sort = sortrows(p_val);
d = size(p_sort, 1);
u = zeros(d, 1);
q = 0.1; 

for i = 1:d
    u(i) = min(1, d * q / (d - i + 1)^2);
end

p_k = find(p_sort(:, 1) > u);
fprintf('-----p_k length of find (sort > u) is: %d\n', length(p_k));

k = -1;
no_zero_indexs = [];

if isempty(p_k) == 0
    k = min(p_k(:, 1));
    fprintf('-----k: %d\n', k);
    if k > 1
        p_sorted_no_zero = p_sort((1: k - 1), :);
        no_zero_indexs = p_sorted_no_zero(:, 2);
        fprintf('-----no zero indexs: \n');
        disp(no_zero_indexs);
    end
else
    fprintf('-----p_k find (sort > u) is empty\n');
end

end