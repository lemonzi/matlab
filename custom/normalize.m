function [out, mu, sig] = normalize(x, dim)
% NORMALIZE(x, dim)
% Classic x = (x-mean(x)) / std(x)
% Works on both vectors and matrices (not on ND arrays)
% Operates on rows or columns, depending on dim

    if isvector(x)
        mu  = mean(x);
        sig = std(x);
        out = (x-mu) / sig;
        return;
    end

    dimCheck = nargin > 2 && dim ~= 1;

    if dimCheck
        x = x';
    end

    mu  = mean(x, 1);
    sig = std(x);

    out = bsxfun(@minus, x, mu);
    out = bsxfun(@rdivide, out, sig);

    if dimCheck
        out = out';
    end

end