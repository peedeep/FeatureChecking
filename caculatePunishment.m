function [punishment] = caculatePunishment(pred_cuts, real_cuts)
d = pred_cuts - real_cuts;
%disp(d);
n = length(d);
s = zeros(n, 1);
for i = 1:n
   if d(i) < 0
       s(i) = exp(-d(i) / 10) - 1;
   else
       s(i) = exp(d(i) / 4.5) - 1;
   end
end 

punishment = sum(s);
disp(punishment);
%fprintf('punishment: %f\t', punishment);

end