function out = threshold(data, thres, varargin)
% THRESHOLD
% Applies a threshold to a 1D array and returns a logical.
% If told to, it makes use of hystheresis to filter it.
% Usage:
%	threshold(data, threshold)
%	threshold(data, threshold, hystheresis)
%	threshold(data, hystLow, hystHigh

    if length(varargin) == 0
        out = data > thres;
        return;
    elseif length(varargin) == 1
        lowBound = thres - varargin{2};
        upBound  = thres + varargin{2};
    elseif length(varargin) == 2
        lowBound = varargin{2};
        upBound  = varargin{3};
    else
        error('Number of input parameters is incorrect');
    end

    out = false(size(data));
    out(1) = data(1) > thres;

    for i = 2:length(data)
        if out(i-1) && data(i) > lowBound
            out(i) = true;
        elseif ~out(i-1) && data(i) > upBound
            out(i) = true;
        end
    end

end

