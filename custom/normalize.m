function [out, mu, sigma] = normalize(x, dim)
% NORMALIZE(x, dim)
% Classic x = (x-mean(x)) / std(x).
% Works on both vectors and matrices (not on ND arrays).
% Operates on rows or columns, depending on dim.
% Usage:
%   x_normalized = normalize(x)
%   [x_normalized, mu, sigma] = normalize(x)
%   [x_normalize, coeffs] = normalize(x)  % coeffs is [mu, sigma]

    if isvector(x)
        mu  = mean(x);
        sigma = std(x);
        out = (x-mu) / sigma;
        if nargout == 2
            mu = [mu, sigma];
        end
        return;
    end

    dimCheck = nargin > 2 && dim ~= 1;

    if dimCheck
        x = x';
    end

    mu  = mean(x, 1);
    sigma = std(x);

    out = bsxfun(@minus, x, mu);
    out = bsxfun(@rdivide, out, sigma);

    if dimCheck
        out = out';
    end

    if nargout == 2
        mu = [mu, sigma];
        if dimCheck
            mu = mu';
        end
    end

end

