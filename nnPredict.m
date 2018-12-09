function [y] = nnPredict(y, initialWear)
    
if initialWear ~= -1
    y = y + initialWear; 
else
    y = y;
end

end