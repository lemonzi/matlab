function smooth_array = polysmooth(array, w_len, overlap, polorder)
% it's one-dimensional
% w_len should be odd (i think)
% overlap 0..1 (default is 0.5, it kinda works)
% polorder is 2 by default (quadratic)

    if nargin < 4
        polorder = 2;
    end
    if nargin < 3 || isempty(overlap)
        overlap = 0.5;
    end

    % Work with row vector internally
    iscolvector = size(array, 2) == 1;
    array = array(:)';

    % Some constants
    len = length(array);
    hop = round(w_len * (1-overlap));
    windows = 1:(floor(len/hop)+1);

    % Get landmarks
    w_c = min(len, max(1, (windows-1) * hop));
    w_l = max(1,   w_c - floor(w_len/2));
    w_r = min(len, w_c + floor(w_len/2));
    w_c(end) = len;

    window_sum   = zeros(1,len);
    smooth_array = zeros(1,len);
    for i = windows

        % Fit Nth order polynomial
        ran = w_l(i):w_r(i);
        x = (ran - mean(ran)) / var(ran);
        pol = polyfit(x, array(ran), polorder);
        arr_fit = polyval(pol, x);

        % Store the fit array using a triangular window
        lenlc = w_c(i) - w_l(i) + 1;
        lencr = w_r(i) - w_c(i);
        if lenlc == 0
            ramp_up = [];
        else
            ramp_up = linspace(0, 1, lenlc);
        end
        if lencr == 0
            ramp_down = [];
        else
            ramp_down = linspace(1 - 1/lencr, 0, lencr);
        end
        ramp = [ramp_up ramp_down];
        window_sum(ran) = window_sum(ran) + ramp;
        smooth_array(ran) = smooth_array(ran) + arr_fit .* ramp;

    end

    % Normalize windows
    smooth_array = smooth_array ./ window_sum;

    if iscolvector
        smooth_array = smooth_array';
    end

end
