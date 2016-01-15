function [s,bias] = getSlope(x,y)
% [s, bias] = getSlope([x], y)
%
% Fit a line (least-squares) to the data and return the slope, and optionally
% the bias term. If no x-data is supplied, the points are assumed to be
% have an equal spacing of one unit (whatever that unit is).
% NaN values are ignored, but a warning is issued if too few remain.
%
% Quim Llimona, 2015

    if nargin < 2
        y = x;
        x = 1:length(x);
        x = reshape(x, size(y));
    end

    if length(x) ~= length(y)
        error('Length mismatch.');
    end

    k = ~isnan(x) & ~isnan(y);
    if (sum(k) < length(x)/2)
        warning('Estimating slope with less than half of the data points!');
    end

    p = polyfit(x(k),y(k),1);
    s = p(1);
    bias = p(2);

end

