function [fs] = featureMaximumDistance(X, Y)

n = size(X, 2);

fs = (1:n);
y = Y;
k = n;
    
while(k - 1 > 0)
    fprintf('\n********** cutter begin k = %d ***********\n', k);
    x = X(:, fs);
    model = fitlm(x, y);

    p_val = model.Coefficients.pValue(2:end);
    p_len = length(p_val);
    p_val = [p_val (1:p_len)'];

    [~, k, no_zero_indexs] = findFDRValues(p_val);
    if k - 1 > 0
        fs = no_zero_indexs';
    end
    fprintf('\n********** cutter end k = %d ***********\n', k); 

end
    
end



