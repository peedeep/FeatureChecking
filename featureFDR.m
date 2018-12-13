function [fs, p_val, u] = featureFDR(X, Y)

n = size(X, 2);

fs = (1:n);
y = Y;
k = n;
    
while(k - 1 > 0)
    fprintf('\n********** cutter begin k = %d ***********\n', k);
    x = X(:, fs);
    model = fitlm(x, y);

    p_val = model.Coefficients.pValue(2:end);
    p_val = [p_val fs'];

    [u, k, no_zero_indexs] = findFDRValues(p_val);
    fs = no_zero_indexs';
    fprintf('\n********** cutter end k = %d ***********\n', k); 
end
    
end



