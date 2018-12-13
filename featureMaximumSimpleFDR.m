function [fs] = featureMaximumSimpleFDR(X, Y)

n = size(X, 2);

fs = (1:n);
y = Y;
k = n;
isFirst = true;
    
while( isFirst || (~isempty(p_k) && length(p_k) > 0))
    isFirst = false;
    fprintf('\n********** cutter begin k = %d ***********\n', k);
    x = X(:, fs);
    model = fitlm(x, y);

    p_val = model.Coefficients.pValue(2:end);
    p_len = length(p_val);
    p_val = [p_val (1:p_len)'];

    [p_k, k, no_zero_indexs] = findFDRValues(p_val);
    if length(p_k) > 0
        fprintf('********** p_k not empty... length is ***********%d', length(p_k));
        fs = no_zero_indexs';
    end
    fprintf('\n********** cutter end k = %d ***********\n', k); 

end
    
end



