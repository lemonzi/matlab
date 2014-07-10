function out = threshold(data, varargin)

    if length(varargin) == 1
        out = data > varargin{1};
        return;
    elseif length(varargin) == 2
        thres = varargin{1};
        lowBound = thres - varargin{2};
        upBound  = thres + varargin{2};
    elseif length(varargin) == 3
        thres    = varargin{1};
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