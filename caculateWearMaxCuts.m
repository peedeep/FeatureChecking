function [real_cuts] = caculateWearMaxCuts(R)

real_cuts = zeros(1, 150);
if size(R, 2) == 1
    for wear = 51:200
        i = wear - 50;
        real_cuts(i) = max(checkElements(find(R <= wear)));
    end
elseif size(R, 2) == 3
    real_cuts = zeros(1, 150);
    for wear = 51:200
        i = wear - 50;
        flutes(1) = max(checkElements(find(R(:,1) <= wear)));
        flutes(2) = max(checkElements(find(R(:,2) <= wear)));
        flutes(3) = max(checkElements(find(R(:,3) <= wear)));
        %disp(flutes);
        [a, ~] = max(flutes);
        if ~isempty(a)
            real_cuts(i) = a;
        end
    end
end

real_cuts = real_cuts(:);

end