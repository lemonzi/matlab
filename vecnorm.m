function n = vecnorm(x, dim)

    if nargin < 2
        dim = 1;
    end

    n = sqrt(sum(x.^2, dim));

end